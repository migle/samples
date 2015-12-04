
-- Uma classe como VectorSpace tem associado um construtor de dados
-- D:VectorSpace, um registo, que é o seu "dicionário", daí a letra d.
-- Esse dicionário permite encontrar para cada operação da classe, o método
-- específico do tipo.
--
-- Quando se declara que um tipo concreto é instância de uma classe é criada uma
-- instância do dicionário que é exportada do módulo onde se declarou a instância.
--
-- Se para que um tipo a pertença a uma classe, se exige pelo contexto que a
-- pertença adicionalmente a outra classe (fazendo da primeira classe uma
-- sub-classe da segunda), então requere-se também que o dicionário da
-- sub-classe permita encontrar o dicionário da super-classe.

-- Projecção: dado um dicionário de VectorSpace v s obtém o dicionário de Num para s.
Level0.$p1VectorSpace :: forall (v :: * -> *) s. Level0.VectorSpace v s => GHC.Num.Num s
Level0.$p1VectorSpace =
  \ (@ (v :: * -> *)) (@ s) (x :: Level0.VectorSpace v s) ->
    case x of _
      Level0.D:VectorSpace p _ _ _ -> p

-- Projecção: dado um dicionário de VectorSpace v s obtém o dicionário de Num
-- para (v s).
Level0.$p2VectorSpace :: forall (v :: * -> *) s. Level0.VectorSpace v s => GHC.Num.Num (v s)
Level0.$p2VectorSpace =
  \ (@ (v :: * -> *)) (@ s) (x :: Level0.VectorSpace v s) ->
    case x of _
      Level0.D:VectorSpace _ p _ _ -> p

-- Projecção: dado um dicionário de VectorSpace v s obtém o método para a
-- operação scal.
Level0.scal :: forall (v :: * -> *) s. Level0.VectorSpace v s => s -> v s -> v s
Level0.scal =
  \ (@ (v :: * -> *)) (@ s) (x :: Level0.VectorSpace v s) ->
    case x of _
      Level0.D:VectorSpace _ _ p _ -> p

-- Projecção: dado um dicionário de VectorSpace v s obtém o método para a
-- operação axpy.
Level0.axpy :: forall (v :: * -> *) s. Level0.VectorSpace v s => s -> v s -> v s -> v s
Level0.axpy =
  \ (@ (v :: * -> *)) (@ s) (x :: Level0.VectorSpace v s) ->
    case x of _
      Level0.D:VectorSpace _ _ _ p -> p

-- Projecção: dado um dicionário de NormedVectorSpace v s obtém o dicionário de
-- VectorSpace v s.
Level0.$p1NormedVectorSpace :: forall (v :: * -> *) s. Level0.NormedVectorSpace v s => Level0.VectorSpace v s
Level0.$p1NormedVectorSpace =
  \ (@ (v :: * -> *)) (@ s) (x :: Level0.NormedVectorSpace v s) ->
    case x of _
      Level0.D:NormedVectorSpace p _ -> p

-- Projecção: dado um dicionário de NormedVectorSpace v s obtém o método para a
-- operação norm.
Level0.norm :: forall (v :: * -> *) s. Level0.NormedVectorSpace v s => v s -> s
Level0.norm =
  \ (@ (v :: * -> *)) (@ s) (x :: Level0.NormedVectorSpace v s) ->
    case x of _
      Level0.D:NormedVectorSpace _ p -> p

-- Projecção: dado um dicionário de InnerProductSpace v s obtém o dicionário de
-- VectorSpace v s.
Level0.$p1InnerProductSpace :: forall (v :: * -> *) s. Level0.InnerProductSpace v s => Level0.VectorSpace v s
Level0.$p1InnerProductSpace =
  \ (@ (v :: * -> *)) (@ s) (x :: Level0.InnerProductSpace v s) ->
    case x of _
      Level0.D:InnerProductSpace p _ -> p

-- Projecção: dado um dicionário de InnerProductSpace v s obtém o método para a
-- operação dot.
Level0.dot :: forall (v :: * -> *) s. Level0.InnerProductSpace v s => v s -> v s -> s
Level0.dot =
  \ (@ (v :: * -> *)) (@ s) (x :: Level0.InnerProductSpace v s) ->
    case x of _
      Level0.D:InnerProductSpace _ p -> p

-- Construtor D:VectorSpace da classe VectorSpace.
-- Curiosamente, não se distingue o constructor (função) do construtor (registo)
-- nem pelo nome!
Level0.D:VectorSpace :: forall (v :: * -> *) s.
     (GHC.Num.Num s, GHC.Num.Num (v s)) =>
     (s -> v s -> v s) -> (s -> v s -> v s -> v s) -> Level0.VectorSpace v s
Level0.D:VectorSpace =
  \ (@ (v :: * -> *))
    (@ s)
    (eta_B4 :: GHC.Num.Num s)
    (eta_B3 :: GHC.Num.Num (v s))
    (eta_B2 :: s -> v s -> v s)
    (eta_B1 :: s -> v s -> v s -> v s) ->
    Level0.D:VectorSpace @ v @ s eta_B4 eta_B3 eta_B2 eta_B1

-- Construtor D:NormedVectorSpace.
Level0.D:NormedVectorSpace
  :: forall (v :: * -> *) s.
     Level0.VectorSpace v s => (v s -> s) -> Level0.NormedVectorSpace v s
Level0.D:NormedVectorSpace =
  \ (@ (v :: * -> *))
    (@ s)
    (eta_B2 :: Level0.VectorSpace v s)
    (eta_B1 :: v s -> s) ->
    Level0.D:NormedVectorSpace @ v @ s eta_B2 eta_B1

-- Construtor D:InnerProductSpace.
Level0.D:InnerProductSpace
  :: forall (v :: * -> *) s.
     Level0.VectorSpace v s => (v s -> v s -> s) -> Level0.InnerProductSpace v s
Level0.D:InnerProductSpace =
  \ (@ (v :: * -> *))
    (@ s)
    (eta_B2 :: Level0.VectorSpace v s)
    (eta_B1 :: v s -> v s -> s) ->
    Level0.D:InnerProductSpace @ v @ s eta_B2 eta_B1
