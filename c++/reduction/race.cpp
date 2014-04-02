#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstdlib>
#include <functional>
#include <iostream>
#include <limits>
#include <memory>

using namespace std;
using namespace std::placeholders;

template < typename El >
void init(El A[], const int N)
{
    for (int i = 0; i != N; ++i) {
        A[i] = El(i * 65531);
    }
}

int naive_imax(const int A[], const int N)
{
    int m = numeric_limits<int>::min();
    for (int i = 0; i != N; ++i) {
        const int x = A[i];
        if (x > m) m = x;
    }
    return m;
}

float naive_fmax(const float A[], const int N)
{
    float m = numeric_limits<float>::min();
    for (int i = 0; i != N; ++i) {
        const float x = A[i];
        if (x > m) m = x;
    }
    return m;
}

/// Generic version.
template < typename El, typename Op >
El reduce(const El A[], const int N, Op op, El neutral)
{
    El a = neutral;
    for (int i = 0; i != N; ++i) {
        const El x = A[i];
        a = op(a,x);
    }
    return a;
}

/// Nuno's version: unroll by 2, re-associate.
template < typename El, typename Op >
El nuno(const El A[], const int N, Op op, El neutral)
{
    const int H = N / 2;
    El a = neutral;
    for (int i = 0, j = N - 1; i != H; ++i, --j) {
        const El x = A[i], y = A[j];
        a = op(a, op(x,y));
    }
    return a;
}

/// Unroll loop by 2.
template < bool assoc, typename El, typename Op >
El unroll2(const El A[], const int N, Op op, El neutral)
{
    const int H = N / 2;
    El a = neutral;
    for (int i = 0; i != N; i += 2) {
        const El x = A[i], y = A[i+1];
        if (assoc)
            a = op(a, op(x,y));
        else
            a = op(op(a,x), y);
    }
    return a;
}

/// Unroll loop by 4.
template < bool assoc, typename El, typename Op >
El unroll4(const El A[], const int N, Op op, El neutral)
{
    const int Q = N / 4;
    El a = neutral;
    for (int i = 0; i != N; i += 4) {
        const El x = A[i], y = A[i+1], z = A[i+2], w = A[i+3];
        if (assoc)
            a = op(a, op(op(x,y), op(z,w)));
        else
            a = op(op(op(op(a,x), y), z), w);
    }
    return a;
}

/// Strength reduction: pointers.
template < typename El, typename Op >
El ptr(const El A[], const int N, Op op, El neutral)
{
    El a = neutral;
    for (const El *p = A, *end = A + N; p != end; ++p) {
        const El x = *p;
        a = op(a,x);
    }
    return a;
}

/// Pseudo-Nuno's version.
template < typename El, typename Op >
El nuno2(const El A[], const int N, Op op, El neutral)
{
    const int H = N / 2;
    const El *X = A, *Y = X + H;
    El a = neutral;
    for (int i = 0; i != H; ++i) {
        const El x = X[i], y = Y[i];
        a = op(a, op(x,y));
    }
    return a;
}

/// Nunize even further, by 4.
template < typename El, typename Op >
El nuno4(const El A[], const int N, Op op, El neutral)
{
    const int Q = N / 4;
    const El *X = A, *Y = X + Q, *Z = Y + Q, *W = Z + Q;
    El a = neutral;
    for (int i = 0; i != Q; ++i) {
        const El x = X[i], y = Y[i], z = Z[i], w = W[i];
        a = op(a, op(op(x,y), op(z,w)));
    }
    return a;
}

/// Naive recursive version.
template < typename El, typename Op >
El recurs(const El* A, const int N, Op op)
{
    if (N > 2)
    {
        const int H = N / 2;
        return op(recurs(A, H, op), recurs(A + H, N - H, op));
    }
    else if (N == 2)
    {
        return op(A[0], A[1]);
    }
    else // if (N == 1)
    {
        return *A;
    }
}

/// Tail-recursive version.
template < typename El, typename Op >
El tail(const El* A, const int N, Op op, El neutral)
{
    if (N == 1)
        return op(neutral, A[0]);
    else
    {
        const int H = N / 2;
        return tail(A + H, N - H, op, tail(A, H, op, neutral));
    }
}

/// Natural tail-recursive version.
template < typename El, typename Op >
El ntail(const El* A, const int N, Op op, El neutral)
{
    if (N == 1)
        return op(neutral, A[0]);
    else
        return tail(A + 1, N - 1, op, op(neutral, A[0]));
}

/// Function table.
template < typename El >
struct entry {
    const char* op;
    const char* name;
    function< El(const El[], const int) > fn;
};

/// Functions working with integers.
static const auto iop = [](int a, int b) { return max(a, b); };
static const int ineutral = numeric_limits<int>::lowest();
static const auto iop2 = [](int a, int b) { return a + b; };
static const int ineutral2 = 0;
static const entry<int> itab[] = {
    { "max", "naive", naive_imax },
    { "max", "generic", [](const int A[], const int N) { return reduce(A, N, iop, ineutral); } },
    { "max", "nuno", [](const int A[], const int N) { return nuno(A, N, iop, ineutral); } },
    { "max", "unrol2", [](const int A[], const int N) { return unroll2<false>(A, N, iop, ineutral); } },
    { "max", "unrol2a", [](const int A[], const int N) { return unroll2<true>(A, N, iop, ineutral); } },
    { "max", "unrol4", [](const int A[], const int N) { return unroll4<false>(A, N, iop, ineutral); } },
    { "max", "unrol4a", [](const int A[], const int N) { return unroll4<true>(A, N, iop, ineutral); } },
    { "max", "ptr", [](const int A[], const int N) { return ptr(A, N, iop, ineutral); } },
    { "max", "nuno2", [](const int A[], const int N) { return nuno2(A, N, iop, ineutral); } },
    { "max", "nuno4", [](const int A[], const int N) { return nuno4(A, N, iop, ineutral); } },
    { "+", "generic", [](const int A[], const int N) { return reduce(A, N, iop2, ineutral2); } },
    { "+", "nuno", [](const int A[], const int N) { return nuno(A, N, iop2, ineutral2); } },
    { "+", "unrol2", [](const int A[], const int N) { return unroll2<false>(A, N, iop2, ineutral2); } },
    { "+", "unrol2a", [](const int A[], const int N) { return unroll2<true>(A, N, iop2, ineutral2); } },
    { "+", "unrol4", [](const int A[], const int N) { return unroll4<false>(A, N, iop2, ineutral2); } },
    { "+", "unrol4a", [](const int A[], const int N) { return unroll4<true>(A, N, iop2, ineutral2); } },
    { "+", "ptr", [](const int A[], const int N) { return ptr(A, N, iop2, ineutral2); } },
    { "+", "nuno2", [](const int A[], const int N) { return nuno2(A, N, iop2, ineutral2); } },
    { "+", "nuno4", [](const int A[], const int N) { return nuno4(A, N, iop2, ineutral2); } },
};
static const int ientries = sizeof(itab) / sizeof(itab[0]);

/// Functions working with floats.
static const auto fop = [](float a, float b) { return max(a, b); };
static const float fneutral = numeric_limits<float>::lowest();
static const auto fop2 = [](float a, float b) { return a + b; };
static const float fneutral2 = 0;
static const entry<float> ftab[] = {
    { "max", "naive", naive_fmax },
    { "max", "generic", [](const float A[], const int N) { return reduce(A, N, fop, fneutral); } },
    { "max", "nuno", [](const float A[], const int N) { return nuno(A, N, fop, fneutral); } },
    { "max", "unrol2", [](const float A[], const int N) { return unroll2<false>(A, N, fop, fneutral); } },
    { "max", "unrol2a", [](const float A[], const int N) { return unroll2<true>(A, N, fop, fneutral); } },
    { "max", "unrol4", [](const float A[], const int N) { return unroll4<false>(A, N, fop, fneutral); } },
    { "max", "unrol4a", [](const float A[], const int N) { return unroll4<true>(A, N, fop, fneutral); } },
    { "max", "ptr", [](const float A[], const int N) { return ptr(A, N, fop, fneutral); } },
    { "max", "nuno2", [](const float A[], const int N) { return nuno2(A, N, fop, fneutral); } },
    { "max", "nuno4", [](const float A[], const int N) { return nuno4(A, N, fop, fneutral); } },
    { "+", "generic", [](const float A[], const int N) { return reduce(A, N, fop2, fneutral2); } },
    { "+", "nuno", [](const float A[], const int N) { return nuno(A, N, fop2, fneutral2); } },
    { "+", "unrol2", [](const float A[], const int N) { return unroll2<false>(A, N, fop2, fneutral2); } },
    { "+", "unrol2a", [](const float A[], const int N) { return unroll2<true>(A, N, fop2, fneutral2); } },
    { "+", "unrol4", [](const float A[], const int N) { return unroll4<false>(A, N, fop2, fneutral2); } },
    { "+", "unrol4a", [](const float A[], const int N) { return unroll4<true>(A, N, fop2, fneutral2); } },
    { "+", "ptr", [](const float A[], const int N) { return ptr(A, N, fop2, fneutral2); } },
    { "+", "nuno2", [](const float A[], const int N) { return nuno2(A, N, fop2, fneutral2); } },
    { "+", "nuno4", [](const float A[], const int N) { return nuno4(A, N, fop2, fneutral2); } },
};
static const int fentries = sizeof(ftab) / sizeof(ftab[0]);

int main(int argc, char* argv[])
{
    // Round size down to nearest multiple of 4.
    const int M = argc >= 2 ? atoi(argv[1]) : 1024;
    const int N = M - N % 4;
    cerr << "Array size is " << N << endl;

    // Number of test repetitions.
    const int R = argc >= 3 ? atoi(argv[2]) : 100;
    cerr << "Tests repeated " << R << " times" << endl;

    // Time calibration loop.
    typedef chrono::microseconds duration;
    duration Davg(0), Dmin(duration::max());
    for (int i = 0; i != R; ++i)
    {
        auto ti = chrono::high_resolution_clock::now();
        auto tf = chrono::high_resolution_clock::now();
        auto d = chrono::duration_cast<duration>(tf - ti);
        Davg += d;
        Dmin = min(Dmin, d);
    }
    Davg /= R;
    cerr << "Calibration loop (us)\t" << Davg.count() << '\t' << Dmin.count() << endl;

    cerr << "\nTests on integers, array size is " << (N * sizeof(int)) << endl;
    {
        unique_ptr<int[]> A(new int[N]);
        init(A.get(), N);

        int correct = 0;
        for (int i = 0; i != ientries; ++i)
        {
            duration davg(0), dmin(duration::max());
            for (int j = 0; j != R; ++j)
            {
                auto ti = chrono::high_resolution_clock::now();
                int test = itab[i].fn(A.get(), N);
                auto tf = chrono::high_resolution_clock::now();
                auto d = chrono::duration_cast<duration>(tf - ti);
                davg += d;
                dmin = min(dmin, d);
                if (i + j == 0 || j == 0 && itab[i].op != itab[i-1].op)
                    correct = test;
                else if (correct != test)
                {
                    cerr << "Error on " << itab[i].name << " i=" << i << " j=" << j << endl;
                    return 1;
                }
            }
            davg /= R;
            davg -= Davg;
            dmin -= Dmin;
            cout << 'i' << '\t' << itab[i].op << '\t' << itab[i].name << '\t' << davg.count() << '\t' << dmin.count() << endl;
        }
    }

    cerr << "\nTests on floats, array size is " << (N * sizeof(float)) << endl;
    {
        unique_ptr<float[]> A(new float[N]);
        init(A.get(), N);

        float correct = 0;
        for (int i = 0; i != fentries; ++i)
        {
            duration davg(0), dmin(duration::max());
            for (int j = 0; j != R; ++j)
            {
                auto ti = chrono::high_resolution_clock::now();
                float test = ftab[i].fn(A.get(), N);
                auto tf = chrono::high_resolution_clock::now();
                auto d = chrono::duration_cast<duration>(tf - ti);
                davg += d;
                dmin = min(dmin, d);
                if (i + j == 0 || j == 0 && ftab[i].op != ftab[i-1].op)
                    correct = test;
                //else if (test != correct)
                else if (fabs(fabs(test - correct) / correct - 1) < 1e-7)
                {
                    cerr << "Error on " << ftab[i].name << " i=" << i << " j=" << j << endl;
                    return 1;
                }
            }
            davg /= R;
            davg -= Davg;
            dmin -= Dmin;
            cout << 'f' << '\t' << ftab[i].op << '\t' << ftab[i].name << '\t' << davg.count() << '\t' << dmin.count() << endl;
        }
    }

    cerr << "\nDone\n" << endl;
    return 0;
}
