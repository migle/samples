// map

#include <iostream>
#include <vector>

void zero(float& a)
{
    a = 0;
}

void stair(int i, float& a)
{
    a = i;
}

void odd(int i, float& a)
{
    a = 2*i + 1;
}

void saxpy_kernel(float a, float x, float y, float& z)
{
    z = a * x + y;
}

// (Int -> a -> b -> c) -> a -> (Int -> b -> c)
// (Int -> b -> c) -> b -> (Int -> c)
template < class Func, class Head >
struct partial_closure
{
    Func func;
    Head head;
    partial_closure(Func func_, Head&& head_)
        : func(func_), head(head_) {}
    template < class It, class... Tail >
        void operator () (It i, Tail&&... tail) const
            { func(i, head, tail...); }
};

template < class Func, class Head >
struct partial_closure< Func, std::vector<Head>& >
{
    Func func;
    std::vector<Head>& head;
    partial_closure(Func func_, std::vector<Head>& head_)
        : func(func_), head(head_) {}
    template < class It, class... Tail >
        void operator () (It i, Tail&&... tail) const
            { func(i, head[i], tail...); }
};

template < class Func, class Head >
struct partial_closure< Func, std::vector<Head> const& >
{
    Func func;
    std::vector<Head> const& head;
    partial_closure(Func func_, std::vector<Head> const& head_)
        : func(func_), head(head_) {}
    template < class It, class... Tail >
        void operator () (It i, Tail&&... tail) const
            { func(i, head[i], tail...); }
};

template < class Func, class Head >
    inline partial_closure< Func, Head >
        bind(Func func, Head&& head)
{
    return partial_closure< Func, Head >(func, head);
}

template < class Func, class Head, class... Tail >
    inline auto bind(Func func, Head&& head, Tail&&... tail)
        -> decltype(bind(partial_closure< Func, Head >(func, head), tail...))
{
    return bind(partial_closure< Func, Head >(func, head), tail...);
}

template < class Closure >
struct map_closure {
    Closure closure;
    map_closure(Closure clos) : closure(clos) {}
    template < class It >
        void operator [] (It n) const
        {
            for (It i = It(); i != n; ++i)
                closure(i);
        }
    template < class It >
        void operator () (It first, It last) const
        {
            for ( ; first != last; ++first)
                closure(first);
        }
};

template < class Func >
struct map_abstraction {
    Func func;
    map_abstraction(Func func_) : func(func_) {}
    template < class... Args >
        auto operator () (Args&&... args) -> map_closure< decltype(bind(func, args...)) >
    {
        auto closure = bind(func, args...);
        return map_closure< decltype(closure) >(closure);
    }
};

template < class Func >
    inline map_abstraction< Func >
        map(Func func) { return map_abstraction< Func >(func); }

template < class Func >
struct kernel {
    Func func;
    kernel(Func func_) : func(func_) {}
    template < class It, class... Args >
        void operator () (It, Args&&... args) const
        {
            func(args...);
        }
};

template < class Func >
    inline kernel< Func >
        make_kernel(Func func) { return kernel< Func >(func); }

int main()
{
    std::vector<float> X(10), Y(10), Z(10);

    map (stair) (X) [10];
    map (odd) (Y) [5];
    map (odd) (Y) (5, 10);
    map (make_kernel(zero)) (Z) [10];

    map (make_kernel(saxpy_kernel)) (2.0f, X, Y, Z) [10];

    for (int i = 0; i != 10; ++i)
        std::cout << X[i] << '\t' << Y[i] << '\t' << Z[i] << std::endl;

    return 0;
}
