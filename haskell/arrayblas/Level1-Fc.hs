
-- The function Prelude.maximum gives an error on an empty list, that's how this
-- appears here.
string_maximum :: [GHC.Types.Char]
string_maximum = GHC.CString.unpackCString# "maximum"#

-- This is the outcome of amax for an empty list.
Level1.amax1 :: forall s . s
Level1.amax1 =
  \ (@ s) -> GHC.List.errorEmptyList @ s stringMaximum

-- amax is defined in our source code.
Level1.amax
  :: forall (a :: * -> * -> *) i s.
     (GHC.Num.Num s, GHC.Classes.Ord s, GHC.Arr.Ix i, Data.Array.Base.IArray a s) =>
     a i s -> s
Level1.amax =
  \ (@ (a :: * -> * -> *))
    (@ i)
    (@ s)
    ($dNum_s3JG :: GHC.Num.Num s_a1uG)
    ($dOrd_s3JH :: GHC.Classes.Ord s_a1uG)
    ($dIx_s3JI :: GHC.Arr.Ix i_a1uF)
    ($dIArray_s3JJ :: Data.Array.Base.IArray a_a1uE s_a1uG)
    (eta_s3JK :: a_a1uE i_a1uF s_a1uG) ->
    case Data.Array.Base.bounds
           @ a_a1uE @ s_a1uG $dIArray_s3JJ @ i_a1uF $dIx_s3JI eta_s3JK
    of _ { (_, _) ->
    case Data.Array.Base.numElements
           @ a_a1uE @ s_a1uG $dIArray_s3JJ @ i_a1uF $dIx_s3JI eta_s3JK
    of _ { GHC.Types.I# x_s3JP ->
    case GHC.Prim.-# x_s3JP 1 of y_s3JQ { __DEFAULT ->
    case GHC.Prim.># 0 y_s3JQ of sat_s3JR { __DEFAULT ->
    case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3JR
    of _ {
      GHC.Types.False ->
        let {
          a1_s3JT :: s_a1uG -> s_a1uG
          [LclId, Str=DmdType]
          a1_s3JT = GHC.Num.abs @ s_a1uG $dNum_s3JG } in
        letrec {
          go_s3JU :: GHC.Prim.Int# -> [s_a1uG]
          [LclId, Arity=1, Str=DmdType <L,U>, Unf=OtherCon []]
          go_s3JU =
            \ (x1_s3JV :: GHC.Prim.Int#) ->
              let {
                sat_s3K2 :: [s_a1uG]
                [LclId, Str=DmdType]
                sat_s3K2 =
                  case GHC.Prim.==# x1_s3JV y_s3JQ of sat_s3JZ { __DEFAULT ->
                  case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3JZ
                  of _ {
                    GHC.Types.False ->
                      case GHC.Prim.+# x1_s3JV 1 of sat_s3K1 { __DEFAULT ->
                      go_s3JU sat_s3K1
                      };
                    GHC.Types.True -> GHC.Types.[] @ s_a1uG
                  }
                  } } in
              let {
                sat_s3JY :: s_a1uG
                [LclId, Str=DmdType]
                sat_s3JY =
                  let {
                    sat_s3JX :: s_a1uG
                    [LclId, Str=DmdType]
                    sat_s3JX =
                      let {
                        sat_s3JW :: GHC.Types.Int
                        [LclId, Str=DmdType]
                        sat_s3JW = GHC.Types.I# x1_s3JV } in
                      Data.Array.Base.unsafeAt
                        @ a_a1uE
                        @ s_a1uG
                        $dIArray_s3JJ
                        @ i_a1uF
                        $dIx_s3JI
                        eta_s3JK
                        sat_s3JW } in
                  a1_s3JT sat_s3JX } in
              GHC.Types.: @ s_a1uG sat_s3JY sat_s3K2; } in
        case go_s3JU 0 of _ {
          [] -> Level1.amax1 @ s_a1uG;
          : ipv_s3K4 ipv1_s3K5 ->
            let {
              k_s3K6 :: s_a1uG -> s_a1uG -> s_a1uG
              [LclId, Str=DmdType]
              k_s3K6 = GHC.Classes.max @ s_a1uG $dOrd_s3JH } in
            letrec {
              go1_s3K7 :: [s_a1uG] -> s_a1uG -> s_a1uG
              [LclId, Arity=2, Str=DmdType <S,1*U><L,U>, Unf=OtherCon []]
              go1_s3K7 =
                \ (ds_s3K8 :: [s_a1uG])
                  (eta1_s3K9 :: s_a1uG) ->
                  case ds_s3K8 of _ {
                    [] -> eta1_s3K9;
                    : y1_s3Kb ys_s3Kc ->
                      let {
                        sat_s3Kd :: s_a1uG
                        [LclId, Str=DmdType]
                        sat_s3Kd = k_s3K6 eta1_s3K9 y1_s3Kb } in
                      go1_s3K7 ys_s3Kc sat_s3Kd
                  }; } in
            go1_s3K7 ipv1_s3K5 ipv_s3K4
        };
      GHC.Types.True -> Level1.amax1 @ s_a1uG
    }
    }
    }
    }
    }

-- This is the Integer 0.
-- It will be used wherever the function Prelude.sum was used in the source code.
Level1.$fNormedVectorSpaceas1 :: GHC.Integer.Type.Integer
Level1.$fNormedVectorSpaceas1 = GHC.Integer.Type.S# 0

-- asum is defined in our source code.
Level1.asum
  :: forall (a :: * -> * -> *) i s .
     (GHC.Num.Num s, GHC.Arr.Ix i, Data.Array.Base.IArray a s) => a i s -> s
Level1.asum =
  \ (@ (a :: * -> * -> *)) (@ i) (@ s)
    ($dNum_s :: GHC.Num.Num s)
    ($dIx_i :: GHC.Arr.Ix i)
    ($dIArray_as :: Data.Array.Base.IArray a s) ->
    let scalarAddition :: s -> s -> s
        scalarAddition = GHC.Num.+ @ s $dNum_s
    in let scalarZero :: s
           scalarZero = GHC.Num.fromInteger @ s $dNum_s Level1.$fNormedVectorSpaceas1
       in let scalarAbs :: s -> s
              scalarAbs = GHC.Num.abs @ s $dNum_s
          in let monomorphic :: a i s -> s
                 monomorphic = \ (v :: a i s) ->        -- let v be the input vector
                   case Data.Array.Base.bounds @ a @ s $dIArray_as @ i $dIx_i v of _
                     (_, _) ->
                       case Data.Array.numElements @ a @ s $dIArray_as @ i $dIx_i v of _
                         GHC.Types.I# n ->              -- let n be the number of elements
                           case GHC.Prim.-# n 1 of u    -- let u be n - 1, the upper bound
                             _ ->
                               case GHC.Prim.># 0 u of empty
                                 _ ->
                                   case GHC.Prim.tagToEnum# @ GHC.Types.Bool empty of _
                                     GHC.Types.True -> scalarZero   -- return the scalar zero on empty array
                                     GHC.Types.False ->
                                       -- go is a tail recursive function with
                                       -- an accumulating parameter.
                                       letrec go :: GHC.Prim.Int# -> s -> s
                                              go = \ (k :: GHC.Prim.Int#) -- array index (strict)
                                                     (accum :: s) ->      -- the accumulator
                                                let accumNext :: s -- next value of the accumulator
                                                    accumNext = let absX :: s
                                                                    absX = let x :: s   -- let x be the value stored at position k
                                                                               x = let boxedK :: GHC.Types.Int
                                                                                       boxedK = GHC.Types.I# k
                                                                                   in Data.Array.Base.unsafeAt @ a @ s $dIArray_as @ i $dIx_i v boxedK
                                                                            in scalarAbs x
                                                                in scalarAddition accum absX
                                                in case GHC.Prim.==# k u of guard
                                                     _ ->
                                                       case GHC.Prim.tagToEnum# @ GHC.Types.Bool guard of _
                                                         GHC.Types.True -> accumNext
                                                         GHC.Types.False ->
                                                           case GHC.Prim.+# k 1 of kNext
                                                             _ -> go kNext accumNext
                                       in go 0 scalarZero
             in monomorphic

-- This is the outcome
lvl1_r3JB
  :: forall i_a2fY e_a2fZ (a_a2g0 :: * -> * -> *).
     a_a2g0 i_a2fY e_a2fZ
[GblId, Str=DmdType b]
lvl1_r3JB =
  \ (@ i_a2fY) (@ e_a2fZ) (@ (a_a2g0 :: * -> * -> *)) ->
    Control.Exception.Base.patError
      @ (a_a2g0 i_a2fY e_a2fZ) "Level1.hs:(13,7)-(17,46)|case"#

lvl2_r3JC :: [GHC.Types.Char]
[GblId, Str=DmdType]
lvl2_r3JC = GHC.CString.unpackCString# "Negative range size"#

lvl3_r3JD :: GHC.Types.Int
[GblId, Str=DmdType b]
lvl3_r3JD = GHC.Err.error @ GHC.Types.Int lvl2_r3JC

Level1.azipWith
  :: forall (a_a2fK :: * -> * -> *)
            (a1_a2fL :: * -> * -> *)
            i_a2fM
            e_a2fN
            (a2_a2fO :: * -> * -> *)
            a3_a2fP
            b_a2fQ.
     (GHC.Arr.Ix i_a2fM, Data.Array.Base.IArray a_a2fK a3_a2fP,
      Data.Array.Base.IArray a1_a2fL b_a2fQ,
      Data.Array.Base.IArray a2_a2fO e_a2fN) =>
     (a3_a2fP -> b_a2fQ -> e_a2fN)
     -> a_a2fK i_a2fM a3_a2fP
     -> a1_a2fL i_a2fM b_a2fQ
     -> a2_a2fO i_a2fM e_a2fN
[GblId,
 Arity=7,
 Str=DmdType <S(SLLLLLL),U(U,U,U,U,U,U,U)><S(C(C(S))LLLLLL),U(C(C1(U(U,U))),1*C1(C1(U(U))),A,C(C1(C1(U))),A,A,A)><S(C(C(S))LLLLLL),U(C(C1(U(U,U))),1*C1(C1(U(U))),A,C(C1(C1(U))),A,A,A)><S(LLC(C(C(S)))LLLL),1*U(A,A,1*C1(C1(C1(U))),A,A,A,A)><L,C(C1(U))><L,U><L,U>,
 Unf=OtherCon []]
Level1.azipWith =
  \ (@ (a_a2fW :: * -> * -> *))
    (@ (a1_a2fX :: * -> * -> *))
    (@ i_a2fY)
    (@ e_a2fZ)
    (@ (a2_a2g0 :: * -> * -> *))
    (@ a3_a2g1)
    (@ b_a2g2)
    ($dIx_s3KE :: GHC.Arr.Ix i_a2fY)
    ($dIArray_s3KF :: Data.Array.Base.IArray a_a2fW a3_a2g1)
    ($dIArray1_s3KG :: Data.Array.Base.IArray a1_a2fX b_a2g2)
    ($dIArray2_s3KH
       :: Data.Array.Base.IArray a2_a2g0 e_a2fZ)
    (eta_s3KI :: a3_a2g1 -> b_a2g2 -> e_a2fZ)
    (eta1_s3KJ :: a_a2fW i_a2fY a3_a2g1)
    (eta2_s3KK :: a1_a2fX i_a2fY b_a2g2) ->
    case Data.Array.Base.bounds
           @ a_a2fW @ a3_a2g1 $dIArray_s3KF @ i_a2fY $dIx_s3KE eta1_s3KJ
    of wild_s3KL { (l_s3KM, u_s3KN) ->
    case Data.Array.Base.bounds
           @ a1_a2fX @ b_a2g2 $dIArray1_s3KG @ i_a2fY $dIx_s3KE eta2_s3KK
    of _ { (ww1_s3KP, ww2_s3KQ) ->
    case GHC.Arr.$p1Ix @ i_a2fY $dIx_s3KE
    of a4_s3KR [Dmd=<S(SLLLLLLL),U(U,U,U,U,U,U,U,U)>] { __DEFAULT ->
    case GHC.Classes.$p1Ord @ i_a2fY a4_s3KR
    of $dEq_s3KS [Dmd=<S(C(C(S))L),U(C(C(U)),U)>] { __DEFAULT ->
    case GHC.Classes.== @ i_a2fY $dEq_s3KS ww1_s3KP l_s3KM
    of _ {
      GHC.Types.False -> lvl1_r3JB @ i_a2fY @ e_a2fZ @ a2_a2g0;
      GHC.Types.True ->
        case GHC.Classes.== @ i_a2fY $dEq_s3KS ww2_s3KQ u_s3KN
        of _ {
          GHC.Types.False -> lvl1_r3JB @ i_a2fY @ e_a2fZ @ a2_a2g0;
          GHC.Types.True ->
            let {
              sat_s3LB :: [(GHC.Types.Int, e_a2fZ)]
              [LclId, Str=DmdType]
              sat_s3LB =
                case GHC.Arr.rangeSize @ i_a2fY $dIx_s3KE wild_s3KL
                of _ { GHC.Types.I# x_s3KW ->
                case GHC.Prim.<# x_s3KW 0 of sat_s3KX { __DEFAULT ->
                case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3KX
                of _ {
                  GHC.Types.False ->
                    let {
                      sat_s3Lz :: [e_a2fZ]
                      [LclId, Str=DmdType]
                      sat_s3Lz =
                        case Data.Array.Base.numElements
                               @ a_a2fW @ a3_a2g1 $dIArray_s3KF @ i_a2fY $dIx_s3KE eta1_s3KJ
                        of _ { GHC.Types.I# x1_s3L2 ->
                        case GHC.Prim.-# x1_s3L2 1 of y_s3L3 { __DEFAULT ->
                        case GHC.Prim.># 0 y_s3L3 of sat_s3L4 { __DEFAULT ->
                        case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3L4
                        of _ {
                          GHC.Types.False ->
                            case Data.Array.Base.numElements
                                   @ a1_a2fX @ b_a2g2 $dIArray1_s3KG @ i_a2fY $dIx_s3KE eta2_s3KK
                            of _ { GHC.Types.I# x2_s3L7 ->
                            case GHC.Prim.-# x2_s3L7 1 of y1_s3L8 { __DEFAULT ->
                            letrec {
                              go_s3Lb :: GHC.Prim.Int# -> [b_a2g2] -> [e_a2fZ]
                              [LclId, Arity=2, Str=DmdType <L,U><S,1*U>, Unf=OtherCon []]
                              go_s3Lb =
                                \ (x3_s3Lc :: GHC.Prim.Int#) (eta3_s3Ld :: [b_a2g2]) ->
                                  case eta3_s3Ld of _ {
                                    [] -> GHC.Types.[] @ e_a2fZ;
                                    : y2_s3Lf ys_s3Lg ->
                                      let {
                                        sat_s3Ln :: [e_a2fZ]
                                        [LclId, Str=DmdType]
                                        sat_s3Ln =
                                          case GHC.Prim.==# x3_s3Lc y_s3L3
                                          of sat_s3Lk { __DEFAULT ->
                                          case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3Lk
                                          of _ {
                                            GHC.Types.False ->
                                              case GHC.Prim.+# x3_s3Lc 1 of sat_s3Lm { __DEFAULT ->
                                              go_s3Lb sat_s3Lm ys_s3Lg
                                              };
                                            GHC.Types.True -> GHC.Types.[] @ e_a2fZ
                                          }
                                          } } in
                                      let {
                                        sat_s3Lj :: e_a2fZ
                                        [LclId, Str=DmdType]
                                        sat_s3Lj =
                                          let {
                                            sat_s3Li :: a3_a2g1
                                            [LclId, Str=DmdType]
                                            sat_s3Li =
                                              let {
                                                sat_s3Lh :: GHC.Types.Int
                                                [LclId, Str=DmdType]
                                                sat_s3Lh = GHC.Types.I# x3_s3Lc } in
                                              Data.Array.Base.unsafeAt
                                                @ a_a2fW
                                                @ a3_a2g1
                                                $dIArray_s3KF
                                                @ i_a2fY
                                                $dIx_s3KE
                                                eta1_s3KJ
                                                sat_s3Lh } in
                                          eta_s3KI sat_s3Li y2_s3Lf } in
                                      GHC.Types.: @ e_a2fZ sat_s3Lj sat_s3Ln
                                  }; } in
                            case GHC.Prim.># 0 y1_s3L8 of sat_s3Lo { __DEFAULT ->
                            case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3Lo
                            of _ {
                              GHC.Types.False ->
                                letrec {
                                  go1_s3Lq :: GHC.Prim.Int# -> [b_a2g2]
                                  [LclId, Arity=1, Str=DmdType <L,U>, Unf=OtherCon []]
                                  go1_s3Lq =
                                    \ (x3_s3Lr :: GHC.Prim.Int#) ->
                                      let {
                                        sat_s3Lx :: [b_a2g2]
                                        [LclId, Str=DmdType]
                                        sat_s3Lx =
                                          case GHC.Prim.==# x3_s3Lr y1_s3L8
                                          of sat_s3Lu { __DEFAULT ->
                                          case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3Lu
                                          of _ {
                                            GHC.Types.False ->
                                              case GHC.Prim.+# x3_s3Lr 1 of sat_s3Lw { __DEFAULT ->
                                              go1_s3Lq sat_s3Lw
                                              };
                                            GHC.Types.True -> GHC.Types.[] @ b_a2g2
                                          }
                                          } } in
                                      let {
                                        sat_s3Lt :: b_a2g2
                                        [LclId, Str=DmdType]
                                        sat_s3Lt =
                                          let {
                                            sat_s3Ls :: GHC.Types.Int
                                            [LclId, Str=DmdType]
                                            sat_s3Ls = GHC.Types.I# x3_s3Lr } in
                                          Data.Array.Base.unsafeAt
                                            @ a1_a2fX
                                            @ b_a2g2
                                            $dIArray1_s3KG
                                            @ i_a2fY
                                            $dIx_s3KE
                                            eta2_s3KK
                                            sat_s3Ls } in
                                      GHC.Types.: @ b_a2g2 sat_s3Lt sat_s3Lx; } in
                                case go1_s3Lq 0 of sat_s3Ly { __DEFAULT -> go_s3Lb 0 sat_s3Ly };
                              GHC.Types.True -> GHC.Types.[] @ e_a2fZ
                            }
                            }
                            }
                            };
                          GHC.Types.True -> GHC.Types.[] @ e_a2fZ
                        }
                        }
                        }
                        } } in
                    case GHC.Prim.-# x_s3KW 1 of sat_s3KZ { __DEFAULT ->
                    case GHC.Enum.eftInt 0 sat_s3KZ of sat_s3L0 { __DEFAULT ->
                    GHC.List.zip @ GHC.Types.Int @ e_a2fZ sat_s3L0 sat_s3Lz
                    }
                    };
                  GHC.Types.True -> case lvl3_r3JD of _ { }
                }
                }
                } } in
            Data.Array.Base.unsafeArray
              @ a2_a2g0
              @ e_a2fZ
              $dIArray2_s3KH
              @ i_a2fY
              $dIx_s3KE
              wild_s3KL
              sat_s3LB
        }
    }
    }
    }
    }
    }

Level1.nrm1
  :: forall (a :: * -> * -> *) i s .
     (GHC.Num.Num s, GHC.Arr.Ix i, Data.Array.Base.IArray a s) => a i s -> s
Level1.nrm1 =
  \ (@ (a :: * -> * -> *))
    (@ i)
    (@ s)
    (eta_B3 :: GHC.Num.Num s)
    (eta_B2 :: GHC.Arr.Ix i)
    (eta_B1 :: Data.Array.Base.IArray a s) ->
    Level1.asum @ a @ i @ s eta_B3 eta_B2 eta_B1

Level1.nrm2
  :: forall (a :: * -> * -> *) i s . Level0.NormedVectorSpace (a i) s => a i s -> s
Level1.nrm2 =
  \ (@ (a :: * -> * -> *))
    (@ i)
    (@ s)
    ($dNormedVectorSpace :: Level0.NormedVectorSpace (a i) s) ->
    Level0.norm @ (a i) @ s $dNormedVectorSpace

Level1.nrmInf
  :: forall (a_aoU :: * -> * -> *) i_aoV s_aoW.
     (GHC.Num.Num s_aoW, GHC.Classes.Ord s_aoW, GHC.Arr.Ix i_aoV,
      Data.Array.Base.IArray a_aoU s_aoW) =>
     a_aoU i_aoV s_aoW -> s_aoW
[GblId,
 Arity=5,
 Str=DmdType <L,1*U(A,A,A,A,1*U,A,A)><L,1*U(A,A,A,A,A,A,1*U,A)><L,U><S(C(C(S))C(C(S))LLLLL),U(1*C1(C1(H)),1*C1(C1(U(U))),A,C(C1(C1(U))),A,A,A)><L,U>,
 Unf=OtherCon []]
Level1.nrmInf =
  \ (@ (a_aZN :: * -> * -> *))
    (@ i_aZO)
    (@ s_aZP)
    (eta_B5 :: GHC.Num.Num s_aZP)
    (eta_B4 :: GHC.Classes.Ord s_aZP)
    (eta_B3 :: GHC.Arr.Ix i_aZO)
    (eta_B2 :: Data.Array.Base.IArray a_aZN s_aZP)
    (eta_B1 :: a_aZN i_aZO s_aZP) ->
    Level1.amax
      @ a_aZN @ i_aZO @ s_aZP eta_B5 eta_B4 eta_B3 eta_B2 eta_B1

lvl4_r3JE :: [GHC.Types.Char]
[GblId, Str=DmdType]
lvl4_r3JE =
  GHC.CString.unpackCString#
    "Can't make up an Array from an Integer."#

Level1.$fNuma1
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     a_a2jk i_a2jl s_a2jm
[GblId, Str=DmdType b]
Level1.$fNuma1 =
  \ (@ (a_a2jk :: * -> * -> *)) (@ i_a2jl) (@ s_a2jm) ->
    GHC.Err.error @ (a_a2jk i_a2jl s_a2jm) lvl4_r3JE

Level1.$fNuma_$cfromInteger
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     (GHC.Num.Num s_a2jm, GHC.Arr.Ix i_a2jl,
      Data.Array.Base.IArray a_a2jk s_a2jm) =>
     GHC.Integer.Type.Integer -> a_a2jk i_a2jl s_a2jm
[GblId,
 Arity=4,
 Str=DmdType <B,A><B,A><B,A><B,A>b,
 Unf=OtherCon []]
Level1.$fNuma_$cfromInteger =
  \ (@ (a_a2jk :: * -> * -> *))
    (@ i_a2jl)
    (@ s_a2jm)
    _
    _
    _
    _ ->
    Level1.$fNuma1 @ a_a2jk @ i_a2jl @ s_a2jm

Level1.$fNuma_$csignum
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     (GHC.Num.Num s_a2jm, GHC.Arr.Ix i_a2jl,
      Data.Array.Base.IArray a_a2jk s_a2jm) =>
     a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
[GblId,
 Arity=4,
 Caf=NoCafRefs,
 Str=DmdType <L,1*U(A,A,A,A,A,1*U,A)><L,U><S(C(C(S))LC(C(C(S)))LLLL),U(1*C1(C1(U(U,U))),1*C1(C1(U(U))),1*C1(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U>,
 Unf=OtherCon []]
Level1.$fNuma_$csignum =
  \ (@ (a_a2jk :: * -> * -> *))
    (@ i_a2jl)
    (@ s_a2jm)
    ($dNum_s3LH :: GHC.Num.Num s_a2jm)
    ($dIx_s3LI :: GHC.Arr.Ix i_a2jl)
    ($dIArray_s3LJ :: Data.Array.Base.IArray a_a2jk s_a2jm)
    (eta_s3LK :: a_a2jk i_a2jl s_a2jm) ->
    case Data.Array.Base.bounds
           @ a_a2jk @ s_a2jm $dIArray_s3LJ @ i_a2jl $dIx_s3LI eta_s3LK
    of wild_s3LL { (_, _) ->
    let {
      sat_s3M4 :: [(GHC.Types.Int, s_a2jm)]
      [LclId, Str=DmdType]
      sat_s3M4 =
        case Data.Array.Base.numElements
               @ a_a2jk @ s_a2jm $dIArray_s3LJ @ i_a2jl $dIx_s3LI eta_s3LK
        of _ { GHC.Types.I# x_s3LP ->
        case GHC.Prim.-# x_s3LP 1 of y_s3LQ { __DEFAULT ->
        case GHC.Prim.># 0 y_s3LQ of sat_s3LR { __DEFAULT ->
        case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3LR
        of _ {
          GHC.Types.False ->
            let {
              f_s3LT :: s_a2jm -> s_a2jm
              [LclId, Str=DmdType]
              f_s3LT = GHC.Num.signum @ s_a2jm $dNum_s3LH } in
            letrec {
              go_s3LU
                :: GHC.Prim.Int# -> [(GHC.Types.Int, s_a2jm)]
              [LclId, Arity=1, Str=DmdType <L,U>, Unf=OtherCon []]
              go_s3LU =
                \ (x1_s3LV :: GHC.Prim.Int#) ->
                  let {
                    sat_s3M3 :: [(GHC.Types.Int, s_a2jm)]
                    [LclId, Str=DmdType]
                    sat_s3M3 =
                      case GHC.Prim.==# x1_s3LV y_s3LQ of sat_s3M0 { __DEFAULT ->
                      case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3M0
                      of _ {
                        GHC.Types.False ->
                          case GHC.Prim.+# x1_s3LV 1 of sat_s3M2 { __DEFAULT ->
                          go_s3LU sat_s3M2
                          };
                        GHC.Types.True -> GHC.Types.[] @ (GHC.Types.Int, s_a2jm)
                      }
                      } } in
                  let {
                    ds_s3LW :: GHC.Types.Int
                    [LclId, Str=DmdType m, Unf=OtherCon []]
                    ds_s3LW = GHC.Types.I# x1_s3LV } in
                  let {
                    sat_s3LY :: s_a2jm
                    [LclId, Str=DmdType]
                    sat_s3LY =
                      let {
                        sat_s3LX :: s_a2jm
                        [LclId, Str=DmdType]
                        sat_s3LX =
                          Data.Array.Base.unsafeAt
                            @ a_a2jk
                            @ s_a2jm
                            $dIArray_s3LJ
                            @ i_a2jl
                            $dIx_s3LI
                            eta_s3LK
                            ds_s3LW } in
                      f_s3LT sat_s3LX } in
                  let {
                    sat_s3LZ :: (GHC.Types.Int, s_a2jm)
                    [LclId, Str=DmdType]
                    sat_s3LZ = (ds_s3LW, sat_s3LY) } in
                  GHC.Types.: @ (GHC.Types.Int, s_a2jm) sat_s3LZ sat_s3M3; } in
            go_s3LU 0;
          GHC.Types.True -> GHC.Types.[] @ (GHC.Types.Int, s_a2jm)
        }
        }
        }
        } } in
    Data.Array.Base.unsafeArray
      @ a_a2jk
      @ s_a2jm
      $dIArray_s3LJ
      @ i_a2jl
      $dIx_s3LI
      wild_s3LL
      sat_s3M4
    }

Level1.$fNuma_$cabs
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     (GHC.Num.Num s_a2jm, GHC.Arr.Ix i_a2jl,
      Data.Array.Base.IArray a_a2jk s_a2jm) =>
     a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
[GblId,
 Arity=4,
 Caf=NoCafRefs,
 Str=DmdType <L,1*U(A,A,A,A,1*U,A,A)><L,U><S(C(C(S))LC(C(C(S)))LLLL),U(1*C1(C1(U(U,U))),1*C1(C1(U(U))),1*C1(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U>,
 Unf=OtherCon []]
Level1.$fNuma_$cabs =
  \ (@ (a_a2jk :: * -> * -> *))
    (@ i_a2jl)
    (@ s_a2jm)
    ($dNum_s3M5 :: GHC.Num.Num s_a2jm)
    ($dIx_s3M6 :: GHC.Arr.Ix i_a2jl)
    ($dIArray_s3M7 :: Data.Array.Base.IArray a_a2jk s_a2jm)
    (eta_s3M8 :: a_a2jk i_a2jl s_a2jm) ->
    case Data.Array.Base.bounds
           @ a_a2jk @ s_a2jm $dIArray_s3M7 @ i_a2jl $dIx_s3M6 eta_s3M8
    of wild_s3M9 { (_, _) ->
    let {
      sat_s3Ms :: [(GHC.Types.Int, s_a2jm)]
      [LclId, Str=DmdType]
      sat_s3Ms =
        case Data.Array.Base.numElements
               @ a_a2jk @ s_a2jm $dIArray_s3M7 @ i_a2jl $dIx_s3M6 eta_s3M8
        of _ { GHC.Types.I# x_s3Md ->
        case GHC.Prim.-# x_s3Md 1 of y_s3Me { __DEFAULT ->
        case GHC.Prim.># 0 y_s3Me of sat_s3Mf { __DEFAULT ->
        case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3Mf
        of _ {
          GHC.Types.False ->
            let {
              f_s3Mh :: s_a2jm -> s_a2jm
              [LclId, Str=DmdType]
              f_s3Mh = GHC.Num.abs @ s_a2jm $dNum_s3M5 } in
            letrec {
              go_s3Mi
                :: GHC.Prim.Int# -> [(GHC.Types.Int, s_a2jm)]
              [LclId, Arity=1, Str=DmdType <L,U>, Unf=OtherCon []]
              go_s3Mi =
                \ (x1_s3Mj :: GHC.Prim.Int#) ->
                  let {
                    sat_s3Mr :: [(GHC.Types.Int, s_a2jm)]
                    [LclId, Str=DmdType]
                    sat_s3Mr =
                      case GHC.Prim.==# x1_s3Mj y_s3Me of sat_s3Mo { __DEFAULT ->
                      case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3Mo
                      of _ {
                        GHC.Types.False ->
                          case GHC.Prim.+# x1_s3Mj 1 of sat_s3Mq { __DEFAULT ->
                          go_s3Mi sat_s3Mq
                          };
                        GHC.Types.True -> GHC.Types.[] @ (GHC.Types.Int, s_a2jm)
                      }
                      } } in
                  let {
                    ds_s3Mk :: GHC.Types.Int
                    [LclId, Str=DmdType m, Unf=OtherCon []]
                    ds_s3Mk = GHC.Types.I# x1_s3Mj } in
                  let {
                    sat_s3Mm :: s_a2jm
                    [LclId, Str=DmdType]
                    sat_s3Mm =
                      let {
                        sat_s3Ml :: s_a2jm
                        [LclId, Str=DmdType]
                        sat_s3Ml =
                          Data.Array.Base.unsafeAt
                            @ a_a2jk
                            @ s_a2jm
                            $dIArray_s3M7
                            @ i_a2jl
                            $dIx_s3M6
                            eta_s3M8
                            ds_s3Mk } in
                      f_s3Mh sat_s3Ml } in
                  let {
                    sat_s3Mn :: (GHC.Types.Int, s_a2jm)
                    [LclId, Str=DmdType]
                    sat_s3Mn = (ds_s3Mk, sat_s3Mm) } in
                  GHC.Types.: @ (GHC.Types.Int, s_a2jm) sat_s3Mn sat_s3Mr; } in
            go_s3Mi 0;
          GHC.Types.True -> GHC.Types.[] @ (GHC.Types.Int, s_a2jm)
        }
        }
        }
        } } in
    Data.Array.Base.unsafeArray
      @ a_a2jk
      @ s_a2jm
      $dIArray_s3M7
      @ i_a2jl
      $dIx_s3M6
      wild_s3M9
      sat_s3Ms
    }

Level1.$fNuma_$cnegate
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     (GHC.Num.Num s_a2jm, GHC.Arr.Ix i_a2jl,
      Data.Array.Base.IArray a_a2jk s_a2jm) =>
     a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
[GblId,
 Arity=4,
 Caf=NoCafRefs,
 Str=DmdType <L,1*U(A,A,A,1*U,A,A,A)><L,U><S(C(C(S))LC(C(C(S)))LLLL),U(1*C1(C1(U(U,U))),1*C1(C1(U(U))),1*C1(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U>,
 Unf=OtherCon []]
Level1.$fNuma_$cnegate =
  \ (@ (a_a2jk :: * -> * -> *))
    (@ i_a2jl)
    (@ s_a2jm)
    ($dNum_s3Mt :: GHC.Num.Num s_a2jm)
    ($dIx_s3Mu :: GHC.Arr.Ix i_a2jl)
    ($dIArray_s3Mv :: Data.Array.Base.IArray a_a2jk s_a2jm)
    (eta_s3Mw :: a_a2jk i_a2jl s_a2jm) ->
    case Data.Array.Base.bounds
           @ a_a2jk @ s_a2jm $dIArray_s3Mv @ i_a2jl $dIx_s3Mu eta_s3Mw
    of wild_s3Mx { (_, _) ->
    let {
      sat_s3MQ :: [(GHC.Types.Int, s_a2jm)]
      [LclId, Str=DmdType]
      sat_s3MQ =
        case Data.Array.Base.numElements
               @ a_a2jk @ s_a2jm $dIArray_s3Mv @ i_a2jl $dIx_s3Mu eta_s3Mw
        of _ { GHC.Types.I# x_s3MB ->
        case GHC.Prim.-# x_s3MB 1 of y_s3MC { __DEFAULT ->
        case GHC.Prim.># 0 y_s3MC of sat_s3MD { __DEFAULT ->
        case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3MD
        of _ {
          GHC.Types.False ->
            let {
              f_s3MF :: s_a2jm -> s_a2jm
              [LclId, Str=DmdType]
              f_s3MF = GHC.Num.negate @ s_a2jm $dNum_s3Mt } in
            letrec {
              go_s3MG
                :: GHC.Prim.Int# -> [(GHC.Types.Int, s_a2jm)]
              [LclId, Arity=1, Str=DmdType <L,U>, Unf=OtherCon []]
              go_s3MG =
                \ (x1_s3MH :: GHC.Prim.Int#) ->
                  let {
                    sat_s3MP :: [(GHC.Types.Int, s_a2jm)]
                    [LclId, Str=DmdType]
                    sat_s3MP =
                      case GHC.Prim.==# x1_s3MH y_s3MC of sat_s3MM { __DEFAULT ->
                      case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3MM
                      of _ {
                        GHC.Types.False ->
                          case GHC.Prim.+# x1_s3MH 1 of sat_s3MO { __DEFAULT ->
                          go_s3MG sat_s3MO
                          };
                        GHC.Types.True -> GHC.Types.[] @ (GHC.Types.Int, s_a2jm)
                      }
                      } } in
                  let {
                    ds_s3MI :: GHC.Types.Int
                    [LclId, Str=DmdType m, Unf=OtherCon []]
                    ds_s3MI = GHC.Types.I# x1_s3MH } in
                  let {
                    sat_s3MK :: s_a2jm
                    [LclId, Str=DmdType]
                    sat_s3MK =
                      let {
                        sat_s3MJ :: s_a2jm
                        [LclId, Str=DmdType]
                        sat_s3MJ =
                          Data.Array.Base.unsafeAt
                            @ a_a2jk
                            @ s_a2jm
                            $dIArray_s3Mv
                            @ i_a2jl
                            $dIx_s3Mu
                            eta_s3Mw
                            ds_s3MI } in
                      f_s3MF sat_s3MJ } in
                  let {
                    sat_s3ML :: (GHC.Types.Int, s_a2jm)
                    [LclId, Str=DmdType]
                    sat_s3ML = (ds_s3MI, sat_s3MK) } in
                  GHC.Types.: @ (GHC.Types.Int, s_a2jm) sat_s3ML sat_s3MP; } in
            go_s3MG 0;
          GHC.Types.True -> GHC.Types.[] @ (GHC.Types.Int, s_a2jm)
        }
        }
        }
        } } in
    Data.Array.Base.unsafeArray
      @ a_a2jk
      @ s_a2jm
      $dIArray_s3Mv
      @ i_a2jl
      $dIx_s3Mu
      wild_s3Mx
      sat_s3MQ
    }

Level1.$fNuma_$c*
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     (GHC.Num.Num s_a2jm, GHC.Arr.Ix i_a2jl,
      Data.Array.Base.IArray a_a2jk s_a2jm) =>
     a_a2jk i_a2jl s_a2jm
     -> a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
[GblId,
 Arity=5,
 Str=DmdType <L,1*U(A,A,1*C(C1(U)),A,A,A,A)><S(SLLLLLL),U(U,U,U,U,U,U,U)><S(C(C(S))LC(C(C(S)))LLLL),U(C(C1(U(U,U))),C(C1(U(U))),1*C1(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U><L,U>,
 Unf=OtherCon []]
Level1.$fNuma_$c* =
  \ (@ (a_a2jk :: * -> * -> *))
    (@ i_a2jl)
    (@ s_a2jm)
    ($dNum_s3MR :: GHC.Num.Num s_a2jm)
    ($dIx_s3MS :: GHC.Arr.Ix i_a2jl)
    ($dIArray_s3MT :: Data.Array.Base.IArray a_a2jk s_a2jm)
    (eta_s3MU :: a_a2jk i_a2jl s_a2jm)
    (eta1_s3MV :: a_a2jk i_a2jl s_a2jm) ->
    let {
      sat_s3MW :: s_a2jm -> s_a2jm -> s_a2jm
      [LclId, Str=DmdType]
      sat_s3MW = GHC.Num.* @ s_a2jm $dNum_s3MR } in
    Level1.azipWith
      @ a_a2jk
      @ a_a2jk
      @ i_a2jl
      @ s_a2jm
      @ a_a2jk
      @ s_a2jm
      @ s_a2jm
      $dIx_s3MS
      $dIArray_s3MT
      $dIArray_s3MT
      $dIArray_s3MT
      sat_s3MW
      eta_s3MU
      eta1_s3MV

Level1.$fNuma_$c-
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     (GHC.Num.Num s_a2jm, GHC.Arr.Ix i_a2jl,
      Data.Array.Base.IArray a_a2jk s_a2jm) =>
     a_a2jk i_a2jl s_a2jm
     -> a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
[GblId,
 Arity=5,
 Str=DmdType <L,1*U(A,1*C(C1(U)),A,A,A,A,A)><S(SLLLLLL),U(U,U,U,U,U,U,U)><S(C(C(S))LC(C(C(S)))LLLL),U(C(C1(U(U,U))),C(C1(U(U))),1*C1(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U><L,U>,
 Unf=OtherCon []]
Level1.$fNuma_$c- =
  \ (@ (a_a2jk :: * -> * -> *))
    (@ i_a2jl)
    (@ s_a2jm)
    ($dNum_s3MX :: GHC.Num.Num s_a2jm)
    ($dIx_s3MY :: GHC.Arr.Ix i_a2jl)
    ($dIArray_s3MZ :: Data.Array.Base.IArray a_a2jk s_a2jm)
    (eta_s3N0 :: a_a2jk i_a2jl s_a2jm)
    (eta1_s3N1 :: a_a2jk i_a2jl s_a2jm) ->
    let {
      sat_s3N2 :: s_a2jm -> s_a2jm -> s_a2jm
      [LclId, Str=DmdType]
      sat_s3N2 = GHC.Num.- @ s_a2jm $dNum_s3MX } in
    Level1.azipWith
      @ a_a2jk
      @ a_a2jk
      @ i_a2jl
      @ s_a2jm
      @ a_a2jk
      @ s_a2jm
      @ s_a2jm
      $dIx_s3MY
      $dIArray_s3MZ
      $dIArray_s3MZ
      $dIArray_s3MZ
      sat_s3N2
      eta_s3N0
      eta1_s3N1

Level1.$fNuma_$c+
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     (GHC.Num.Num s_a2jm, GHC.Arr.Ix i_a2jl,
      Data.Array.Base.IArray a_a2jk s_a2jm) =>
     a_a2jk i_a2jl s_a2jm
     -> a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
[GblId,
 Arity=5,
 Str=DmdType <L,1*U(1*C(C1(U)),A,A,A,A,A,A)><S(SLLLLLL),U(U,U,U,U,U,U,U)><S(C(C(S))LC(C(C(S)))LLLL),U(C(C1(U(U,U))),C(C1(U(U))),1*C1(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U><L,U>,
 Unf=OtherCon []]
Level1.$fNuma_$c+ =
  \ (@ (a_a2jk :: * -> * -> *))
    (@ i_a2jl)
    (@ s_a2jm)
    ($dNum_s3N3 :: GHC.Num.Num s_a2jm)
    ($dIx_s3N4 :: GHC.Arr.Ix i_a2jl)
    ($dIArray_s3N5 :: Data.Array.Base.IArray a_a2jk s_a2jm)
    (eta_s3N6 :: a_a2jk i_a2jl s_a2jm)
    (eta1_s3N7 :: a_a2jk i_a2jl s_a2jm) ->
    let {
      sat_s3N8 :: s_a2jm -> s_a2jm -> s_a2jm
      [LclId, Str=DmdType]
      sat_s3N8 = GHC.Num.+ @ s_a2jm $dNum_s3N3 } in
    Level1.azipWith
      @ a_a2jk
      @ a_a2jk
      @ i_a2jl
      @ s_a2jm
      @ a_a2jk
      @ s_a2jm
      @ s_a2jm
      $dIx_s3N4
      $dIArray_s3N5
      $dIArray_s3N5
      $dIArray_s3N5
      sat_s3N8
      eta_s3N6
      eta1_s3N7

lvl5_r3JF
  :: forall (a_a2jk :: * -> * -> *) i_a2jl s_a2jm.
     GHC.Integer.Type.Integer -> a_a2jk i_a2jl s_a2jm
[GblId, Arity=1, Str=DmdType <L,U>b, Unf=OtherCon []]
lvl5_r3JF =
  \ (@ (a_a2jk :: * -> * -> *)) (@ i_a2jl) (@ s_a2jm) _ ->
    Level1.$fNuma1 @ a_a2jk @ i_a2jl @ s_a2jm

Level1.$fNuma [InlPrag=[ALWAYS] CONLIKE]
  :: forall (a_a1kz :: * -> * -> *) i_a1kA s_a1kB.
     (GHC.Num.Num s_a1kB, GHC.Arr.Ix i_a1kA,
      Data.Array.Base.IArray a_a1kz s_a1kB) =>
     GHC.Num.Num (a_a1kz i_a1kA s_a1kB)
[GblId[DFunId],
 Arity=3,
 Str=DmdType <L,U(C(C1(U)),C(C1(U)),C(C1(U)),U,U,U,A)><L,U(U,U,U,U,U,U,U)><L,U(C(C1(U(U,U))),C(C1(U(U))),C(C1(C1(U))),C(C1(C1(U))),A,A,A)>m,
 Unf=OtherCon []]
Level1.$fNuma =
  \ (@ (a_a2jk :: * -> * -> *))
    (@ i_a2jl)
    (@ s_a2jm)
    ($dNum_s3Na :: GHC.Num.Num s_a2jm)
    ($dIx_s3Nb :: GHC.Arr.Ix i_a2jl)
    ($dIArray_s3Nc :: Data.Array.Base.IArray a_a2jk s_a2jm) ->
    let {
      sat_s3Ni :: a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
      [LclId, Str=DmdType]
      sat_s3Ni =
        \ (eta_B1 :: a_a2jk i_a2jl s_a2jm) ->
          Level1.$fNuma_$csignum
            @ a_a2jk
            @ i_a2jl
            @ s_a2jm
            $dNum_s3Na
            $dIx_s3Nb
            $dIArray_s3Nc
            eta_B1 } in
    let {
      sat_s3Nh :: a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
      [LclId, Str=DmdType]
      sat_s3Nh =
        \ (eta_B1 :: a_a2jk i_a2jl s_a2jm) ->
          Level1.$fNuma_$cabs
            @ a_a2jk
            @ i_a2jl
            @ s_a2jm
            $dNum_s3Na
            $dIx_s3Nb
            $dIArray_s3Nc
            eta_B1 } in
    let {
      sat_s3Ng :: a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
      [LclId, Str=DmdType]
      sat_s3Ng =
        \ (eta_B1 :: a_a2jk i_a2jl s_a2jm) ->
          Level1.$fNuma_$cnegate
            @ a_a2jk
            @ i_a2jl
            @ s_a2jm
            $dNum_s3Na
            $dIx_s3Nb
            $dIArray_s3Nc
            eta_B1 } in
    let {
      sat_s3Nf
        :: a_a2jk i_a2jl s_a2jm
           -> a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
      [LclId, Str=DmdType]
      sat_s3Nf =
        \ (eta_B2 :: a_a2jk i_a2jl s_a2jm)
          (eta_B1 :: a_a2jk i_a2jl s_a2jm) ->
          Level1.$fNuma_$c*
            @ a_a2jk
            @ i_a2jl
            @ s_a2jm
            $dNum_s3Na
            $dIx_s3Nb
            $dIArray_s3Nc
            eta_B2
            eta_B1 } in
    let {
      sat_s3Ne
        :: a_a2jk i_a2jl s_a2jm
           -> a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
      [LclId, Str=DmdType]
      sat_s3Ne =
        \ (eta_B2 :: a_a2jk i_a2jl s_a2jm)
          (eta_B1 :: a_a2jk i_a2jl s_a2jm) ->
          Level1.$fNuma_$c-
            @ a_a2jk
            @ i_a2jl
            @ s_a2jm
            $dNum_s3Na
            $dIx_s3Nb
            $dIArray_s3Nc
            eta_B2
            eta_B1 } in
    let {
      sat_s3Nd
        :: a_a2jk i_a2jl s_a2jm
           -> a_a2jk i_a2jl s_a2jm -> a_a2jk i_a2jl s_a2jm
      [LclId, Str=DmdType]
      sat_s3Nd =
        \ (eta_B2 :: a_a2jk i_a2jl s_a2jm)
          (eta_B1 :: a_a2jk i_a2jl s_a2jm) ->
          Level1.$fNuma_$c+
            @ a_a2jk
            @ i_a2jl
            @ s_a2jm
            $dNum_s3Na
            $dIx_s3Nb
            $dIArray_s3Nc
            eta_B2
            eta_B1 } in
    GHC.Num.D:Num
      @ (a_a2jk i_a2jl s_a2jm)
      sat_s3Nd
      sat_s3Ne
      sat_s3Nf
      sat_s3Ng
      sat_s3Nh
      sat_s3Ni
      (lvl5_r3JF @ a_a2jk @ i_a2jl @ s_a2jm)

Level1.$w$caxpy [InlPrag=[0]]
  :: forall (a_a2ip :: * -> * -> *) i_a2iq s_a2ir.
     (GHC.Num.Num s_a2ir, GHC.Arr.Ix i_a2iq,
      Data.Array.Base.IArray a_a2ip s_a2ir) =>
     s_a2ir
     -> a_a2ip i_a2iq s_a2ir
     -> a_a2ip i_a2iq s_a2ir
     -> a_a2ip i_a2iq s_a2ir
[GblId,
 Arity=4,
 Str=DmdType <L,U(1*U,A,1*C1(U),A,A,A,A)><L,U(U,U,U,U,U,U,U)><L,U(C(C1(U(U,U))),C(C1(U(U))),C(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U>,
 Unf=OtherCon []]
Level1.$w$caxpy =
  \ (@ (a_a2ip :: * -> * -> *))
    (@ i_a2iq)
    (@ s_a2ir)
    (w_s3Nj :: GHC.Num.Num s_a2ir)
    (w1_s3Nk :: GHC.Arr.Ix i_a2iq)
    (w2_s3Nl :: Data.Array.Base.IArray a_a2ip s_a2ir)
    (w3_s3Nm :: s_a2ir) ->
    let {
      f_s3Nn :: s_a2ir -> s_a2ir -> s_a2ir
      [LclId, Str=DmdType]
      f_s3Nn = GHC.Num.+ @ s_a2ir w_s3Nj } in
    let {
      g_s3No :: s_a2ir -> s_a2ir
      [LclId, Str=DmdType]
      g_s3No = GHC.Num.* @ s_a2ir w_s3Nj w3_s3Nm } in
    let {
      sat_s3Nr :: s_a2ir -> s_a2ir -> s_a2ir
      [LclId, Str=DmdType]
      sat_s3Nr =
        \ (x_s3Np :: s_a2ir) ->
          let {
            sat_s3Nq :: s_a2ir
            [LclId, Str=DmdType]
            sat_s3Nq = g_s3No x_s3Np } in
          f_s3Nn sat_s3Nq } in
    Level1.azipWith
      @ a_a2ip
      @ a_a2ip
      @ i_a2iq
      @ s_a2ir
      @ a_a2ip
      @ s_a2ir
      @ s_a2ir
      w1_s3Nk
      w2_s3Nl
      w2_s3Nl
      w2_s3Nl
      sat_s3Nr

Level1.$fVectorSpaceas_$caxpy [InlPrag=INLINE[0]]
  :: forall (a_a2ip :: * -> * -> *) i_a2iq s_a2ir.
     (GHC.Num.Num (a_a2ip i_a2iq s_a2ir), GHC.Num.Num s_a2ir,
      GHC.Arr.Ix i_a2iq, Data.Array.Base.IArray a_a2ip s_a2ir) =>
     s_a2ir
     -> a_a2ip i_a2iq s_a2ir
     -> a_a2ip i_a2iq s_a2ir
     -> a_a2ip i_a2iq s_a2ir
[GblId,
 Arity=5,
 Str=DmdType <L,A><L,U(1*U,A,1*C1(U),A,A,A,A)><L,U(U,U,U,U,U,U,U)><L,U(C(C1(U(U,U))),C(C1(U(U))),C(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U>,
 Unf=OtherCon []]
Level1.$fVectorSpaceas_$caxpy =
  \ (@ (a_a2ip :: * -> * -> *))
    (@ i_a2iq)
    (@ s_a2ir)
    _
    (w1_s3Nt :: GHC.Num.Num s_a2ir)
    (w2_s3Nu :: GHC.Arr.Ix i_a2iq)
    (w3_s3Nv :: Data.Array.Base.IArray a_a2ip s_a2ir)
    (w4_s3Nw :: s_a2ir) ->
    Level1.$w$caxpy
      @ a_a2ip @ i_a2iq @ s_a2ir w1_s3Nt w2_s3Nu w3_s3Nv w4_s3Nw

Level1.$w$cscal [InlPrag=[0]]
  :: forall (a_a2ip :: * -> * -> *) i_a2iq s_a2ir.
     (GHC.Num.Num s_a2ir, GHC.Arr.Ix i_a2iq,
      Data.Array.Base.IArray a_a2ip s_a2ir) =>
     s_a2ir -> a_a2ip i_a2iq s_a2ir -> a_a2ip i_a2iq s_a2ir
[GblId,
 Arity=5,
 Caf=NoCafRefs,
 Str=DmdType <L,U(A,A,C(C1(U)),A,A,A,A)><L,U><S(C(C(S))LC(C(C(S)))LLLL),U(1*C1(C1(U(U,U))),1*C1(C1(U(U))),1*C1(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U><L,U>,
 Unf=OtherCon []]
Level1.$w$cscal =
  \ (@ (a_a2ip :: * -> * -> *))
    (@ i_a2iq)
    (@ s_a2ir)
    (w_s3Nx :: GHC.Num.Num s_a2ir)
    (w1_s3Ny :: GHC.Arr.Ix i_a2iq)
    (w2_s3Nz :: Data.Array.Base.IArray a_a2ip s_a2ir)
    (w3_s3NA :: s_a2ir)
    (w4_s3NB :: a_a2ip i_a2iq s_a2ir) ->
    case Data.Array.Base.bounds
           @ a_a2ip @ s_a2ir w2_s3Nz @ i_a2iq w1_s3Ny w4_s3NB
    of wild_s3NC { (_, _) ->
    let {
      sat_s3NU :: [(GHC.Types.Int, s_a2ir)]
      [LclId, Str=DmdType]
      sat_s3NU =
        case Data.Array.Base.numElements
               @ a_a2ip @ s_a2ir w2_s3Nz @ i_a2iq w1_s3Ny w4_s3NB
        of _ { GHC.Types.I# x_s3NG ->
        case GHC.Prim.-# x_s3NG 1 of y_s3NH { __DEFAULT ->
        case GHC.Prim.># 0 y_s3NH of sat_s3NI { __DEFAULT ->
        case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3NI
        of _ {
          GHC.Types.False ->
            letrec {
              go_s3NK
                :: GHC.Prim.Int# -> [(GHC.Types.Int, s_a2ir)]
              [LclId, Arity=1, Str=DmdType <L,U>, Unf=OtherCon []]
              go_s3NK =
                \ (x1_s3NL :: GHC.Prim.Int#) ->
                  let {
                    sat_s3NT :: [(GHC.Types.Int, s_a2ir)]
                    [LclId, Str=DmdType]
                    sat_s3NT =
                      case GHC.Prim.==# x1_s3NL y_s3NH of sat_s3NQ { __DEFAULT ->
                      case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3NQ
                      of _ {
                        GHC.Types.False ->
                          case GHC.Prim.+# x1_s3NL 1 of sat_s3NS { __DEFAULT ->
                          go_s3NK sat_s3NS
                          };
                        GHC.Types.True -> GHC.Types.[] @ (GHC.Types.Int, s_a2ir)
                      }
                      } } in
                  let {
                    ds_s3NM :: GHC.Types.Int
                    [LclId, Str=DmdType m, Unf=OtherCon []]
                    ds_s3NM = GHC.Types.I# x1_s3NL } in
                  let {
                    sat_s3NO :: s_a2ir
                    [LclId, Str=DmdType]
                    sat_s3NO =
                      let {
                        sat_s3NN :: s_a2ir
                        [LclId, Str=DmdType]
                        sat_s3NN =
                          Data.Array.Base.unsafeAt
                            @ a_a2ip @ s_a2ir w2_s3Nz @ i_a2iq w1_s3Ny w4_s3NB ds_s3NM } in
                      GHC.Num.* @ s_a2ir w_s3Nx sat_s3NN w3_s3NA } in
                  let {
                    sat_s3NP :: (GHC.Types.Int, s_a2ir)
                    [LclId, Str=DmdType]
                    sat_s3NP = (ds_s3NM, sat_s3NO) } in
                  GHC.Types.: @ (GHC.Types.Int, s_a2ir) sat_s3NP sat_s3NT; } in
            go_s3NK 0;
          GHC.Types.True -> GHC.Types.[] @ (GHC.Types.Int, s_a2ir)
        }
        }
        }
        } } in
    Data.Array.Base.unsafeArray
      @ a_a2ip @ s_a2ir w2_s3Nz @ i_a2iq w1_s3Ny wild_s3NC sat_s3NU
    }

Level1.$fVectorSpaceas_$cscal [InlPrag=INLINE[0]]
  :: forall (a_a2ip :: * -> * -> *) i_a2iq s_a2ir.
     (GHC.Num.Num (a_a2ip i_a2iq s_a2ir), GHC.Num.Num s_a2ir,
      GHC.Arr.Ix i_a2iq, Data.Array.Base.IArray a_a2ip s_a2ir) =>
     s_a2ir -> a_a2ip i_a2iq s_a2ir -> a_a2ip i_a2iq s_a2ir
[GblId,
 Arity=6,
 Caf=NoCafRefs,
 Str=DmdType <L,A><L,U(A,A,C(C1(U)),A,A,A,A)><L,U><S(C(C(S))LC(C(C(S)))LLLL),U(1*C1(C1(U(U,U))),1*C1(C1(U(U))),1*C1(C1(C1(U))),C(C1(C1(U))),A,A,A)><L,U><L,U>,
 Unf=OtherCon []]
Level1.$fVectorSpaceas_$cscal =
  \ (@ (a_a2ip :: * -> * -> *))
    (@ i_a2iq)
    (@ s_a2ir)
    _
    (w1_s3NW :: GHC.Num.Num s_a2ir)
    (w2_s3NX :: GHC.Arr.Ix i_a2iq)
    (w3_s3NY :: Data.Array.Base.IArray a_a2ip s_a2ir)
    (w4_s3NZ :: s_a2ir)
    (w5_s3O0 :: a_a2ip i_a2iq s_a2ir) ->
    Level1.$w$cscal
      @ a_a2ip @ i_a2iq @ s_a2ir w1_s3NW w2_s3NX w3_s3NY w4_s3NZ w5_s3O0

Level1.$fVectorSpaceas [InlPrag=[ALWAYS] CONLIKE]
  :: forall (a_a1ko :: * -> * -> *) i_a1kp s_a1kq.
     (GHC.Num.Num (a_a1ko i_a1kp s_a1kq), GHC.Num.Num s_a1kq,
      GHC.Arr.Ix i_a1kp, Data.Array.Base.IArray a_a1ko s_a1kq) =>
     Level0.VectorSpace (a_a1ko i_a1kp) s_a1kq
[GblId[DFunId[1]],
 Arity=4,
 Str=DmdType <L,U><L,U(U,U,U,U,U,U,U)><L,U(U,U,U,U,U,U,U)><L,U(C(C1(U(U,U))),C(C1(U(U))),C(C1(C1(U))),C(C1(C1(U))),A,A,A)>m,
 Unf=OtherCon []]
Level1.$fVectorSpaceas =
  \ (@ (a_a2ip :: * -> * -> *))
    (@ i_a2iq)
    (@ s_a2ir)
    ($dNum_s3O1 :: GHC.Num.Num (a_a2ip i_a2iq s_a2ir))
    ($dNum1_s3O2 :: GHC.Num.Num s_a2ir)
    ($dIx_s3O3 :: GHC.Arr.Ix i_a2iq)
    ($dIArray_s3O4 :: Data.Array.Base.IArray a_a2ip s_a2ir) ->
    let {
      sat_s3O9
        :: s_a2ir
           -> a_a2ip i_a2iq s_a2ir
           -> a_a2ip i_a2iq s_a2ir
           -> a_a2ip i_a2iq s_a2ir
      [LclId, Str=DmdType]
      sat_s3O9 =
        \ (w_s3O8 :: s_a2ir) ->
          Level1.$w$caxpy
            @ a_a2ip
            @ i_a2iq
            @ s_a2ir
            $dNum1_s3O2
            $dIx_s3O3
            $dIArray_s3O4
            w_s3O8 } in
    let {
      sat_s3O7
        :: s_a2ir -> a_a2ip i_a2iq s_a2ir -> a_a2ip i_a2iq s_a2ir
      [LclId, Str=DmdType]
      sat_s3O7 =
        \ (w_s3O5 :: s_a2ir)
          (w1_s3O6 :: a_a2ip i_a2iq s_a2ir) ->
          Level1.$w$cscal
            @ a_a2ip
            @ i_a2iq
            @ s_a2ir
            $dNum1_s3O2
            $dIx_s3O3
            $dIArray_s3O4
            w_s3O5
            w1_s3O6 } in
    Level0.D:VectorSpace
      @ (a_a2ip i_a2iq) @ s_a2ir $dNum1_s3O2 $dNum_s3O1 sat_s3O7 sat_s3O9

Level1.$w$cdot [InlPrag=[0]]
  :: forall (a_a2hm :: * -> * -> *) i_a2hn s_a2ho.
     (GHC.Num.Num s_a2ho, GHC.Arr.Ix i_a2hn,
      Data.Array.Base.IArray a_a2hm s_a2ho) =>
     a_a2hm i_a2hn s_a2ho -> a_a2hm i_a2hn s_a2ho -> s_a2ho
[GblId,
 Arity=5,
 Caf=NoCafRefs,
 Str=DmdType <L,U(1*U,A,1*U,A,A,A,1*C1(U))><L,U><S(C(C(S))C(C(S))LLLLL),U(C(C1(H)),C(C1(U(U))),A,C(C1(C1(U))),A,A,A)><L,U><L,U>,
 Unf=OtherCon []]
Level1.$w$cdot =
  \ (@ (a_a2hm :: * -> * -> *))
    (@ i_a2hn)
    (@ s_a2ho)
    (w_s3Oa :: GHC.Num.Num s_a2ho)
    (w1_s3Ob :: GHC.Arr.Ix i_a2hn)
    (w2_s3Oc :: Data.Array.Base.IArray a_a2hm s_a2ho)
    (w3_s3Od :: a_a2hm i_a2hn s_a2ho)
    (w4_s3Oe :: a_a2hm i_a2hn s_a2ho) ->
    case Data.Array.Base.bounds
           @ a_a2hm @ s_a2ho w2_s3Oc @ i_a2hn w1_s3Ob w3_s3Od
    of _ { (_, _) ->
    case Data.Array.Base.numElements
           @ a_a2hm @ s_a2ho w2_s3Oc @ i_a2hn w1_s3Ob w3_s3Od
    of _ { GHC.Types.I# x_s3Oj ->
    case GHC.Prim.-# x_s3Oj 1 of y_s3Ok { __DEFAULT ->
    case GHC.Prim.># 0 y_s3Ok of sat_s3Ol { __DEFAULT ->
    case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3Ol
    of _ {
      GHC.Types.False ->
        case Data.Array.Base.bounds
               @ a_a2hm @ s_a2ho w2_s3Oc @ i_a2hn w1_s3Ob w4_s3Oe
        of _ { (_, _) ->
        case Data.Array.Base.numElements
               @ a_a2hm @ s_a2ho w2_s3Oc @ i_a2hn w1_s3Ob w4_s3Oe
        of _ { GHC.Types.I# x1_s3Or ->
        case GHC.Prim.-# x1_s3Or 1 of y1_s3Os { __DEFAULT ->
        let {
          k_s3Ot :: s_a2ho -> s_a2ho -> s_a2ho
          [LclId, Str=DmdType]
          k_s3Ot = GHC.Num.+ @ s_a2ho w_s3Oa } in
        let {
          a1_s3Ou
            :: s_a2ho -> s_a2ho -> s_a2ho
          [LclId, Str=DmdType]
          a1_s3Ou = GHC.Num.* @ s_a2ho w_s3Oa } in
        letrec {
          go_s3Oy
            :: GHC.Prim.Int# -> [s_a2ho] -> s_a2ho -> s_a2ho
          [LclId, Arity=3, Str=DmdType <L,U><S,1*U><L,U>, Unf=OtherCon []]
          go_s3Oy =
            \ (x2_s3Oz :: GHC.Prim.Int#)
              (eta_s3OA :: [s_a2ho])
              (eta1_s3OB :: s_a2ho) ->
              case eta_s3OA of _ {
                [] -> eta1_s3OB;
                : y2_s3OD ys_s3OE ->
                  case GHC.Prim.==# x2_s3Oz y_s3Ok of sat_s3OF { __DEFAULT ->
                  case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3OF
                  of _ {
                    GHC.Types.False ->
                      let {
                        sat_s3OL :: s_a2ho
                        [LclId, Str=DmdType]
                        sat_s3OL =
                          let {
                            sat_s3OK :: s_a2ho
                            [LclId, Str=DmdType]
                            sat_s3OK =
                              let {
                                sat_s3OJ :: s_a2ho
                                [LclId, Str=DmdType]
                                sat_s3OJ =
                                  let {
                                    sat_s3OI :: GHC.Types.Int
                                    [LclId, Str=DmdType]
                                    sat_s3OI = GHC.Types.I# x2_s3Oz } in
                                  Data.Array.Base.unsafeAt
                                    @ a_a2hm @ s_a2ho w2_s3Oc @ i_a2hn w1_s3Ob w3_s3Od sat_s3OI } in
                              a1_s3Ou sat_s3OJ y2_s3OD } in
                          k_s3Ot eta1_s3OB sat_s3OK } in
                      case GHC.Prim.+# x2_s3Oz 1 of sat_s3OH { __DEFAULT ->
                      go_s3Oy sat_s3OH ys_s3OE sat_s3OL
                      };
                    GHC.Types.True ->
                      let {
                        sat_s3OO :: s_a2ho
                        [LclId, Str=DmdType]
                        sat_s3OO =
                          let {
                            sat_s3ON :: s_a2ho
                            [LclId, Str=DmdType]
                            sat_s3ON =
                              let {
                                sat_s3OM :: GHC.Types.Int
                                [LclId, Str=DmdType]
                                sat_s3OM = GHC.Types.I# x2_s3Oz } in
                              Data.Array.Base.unsafeAt
                                @ a_a2hm @ s_a2ho w2_s3Oc @ i_a2hn w1_s3Ob w3_s3Od sat_s3OM } in
                          a1_s3Ou sat_s3ON y2_s3OD } in
                      k_s3Ot eta1_s3OB sat_s3OO
                  }
                  }
              }; } in
        case GHC.Prim.># 0 y1_s3Os of sat_s3OP { __DEFAULT ->
        case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3OP
        of _ {
          GHC.Types.False ->
            letrec {
              go1_s3OR :: GHC.Prim.Int# -> [s_a2ho]
              [LclId, Arity=1, Str=DmdType <L,U>, Unf=OtherCon []]
              go1_s3OR =
                \ (x2_s3OS :: GHC.Prim.Int#) ->
                  let {
                    sat_s3OY :: [s_a2ho]
                    [LclId, Str=DmdType]
                    sat_s3OY =
                      case GHC.Prim.==# x2_s3OS y1_s3Os of sat_s3OV { __DEFAULT ->
                      case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3OV
                      of _ {
                        GHC.Types.False ->
                          case GHC.Prim.+# x2_s3OS 1 of sat_s3OX { __DEFAULT ->
                          go1_s3OR sat_s3OX
                          };
                        GHC.Types.True -> GHC.Types.[] @ s_a2ho
                      }
                      } } in
                  let {
                    sat_s3OU :: s_a2ho
                    [LclId, Str=DmdType]
                    sat_s3OU =
                      let {
                        sat_s3OT :: GHC.Types.Int
                        [LclId, Str=DmdType]
                        sat_s3OT = GHC.Types.I# x2_s3OS } in
                      Data.Array.Base.unsafeAt
                        @ a_a2hm @ s_a2ho w2_s3Oc @ i_a2hn w1_s3Ob w4_s3Oe sat_s3OT } in
                  GHC.Types.: @ s_a2ho sat_s3OU sat_s3OY; } in
            let {
              sat_s3P0 :: s_a2ho
              [LclId, Str=DmdType]
              sat_s3P0 =
                GHC.Num.fromInteger
                  @ s_a2ho w_s3Oa Level1.$fNormedVectorSpaceas1 } in
            case go1_s3OR 0 of sat_s3OZ { __DEFAULT ->
            go_s3Oy 0 sat_s3OZ sat_s3P0
            };
          GHC.Types.True ->
            GHC.Num.fromInteger @ s_a2ho w_s3Oa Level1.$fNormedVectorSpaceas1
        }
        }
        }
        }
        };
      GHC.Types.True ->
        GHC.Num.fromInteger @ s_a2ho w_s3Oa Level1.$fNormedVectorSpaceas1
    }
    }
    }
    }
    }

Level1.$fInnerProductSpaceas_$cdot [InlPrag=INLINE[0]]
  :: forall (a_a2hm :: * -> * -> *) i_a2hn s_a2ho.
     (Level0.VectorSpace (a_a2hm i_a2hn) s_a2ho, GHC.Num.Num s_a2ho,
      GHC.Arr.Ix i_a2hn, Data.Array.Base.IArray a_a2hm s_a2ho) =>
     a_a2hm i_a2hn s_a2ho -> a_a2hm i_a2hn s_a2ho -> s_a2ho
[GblId,
 Arity=6,
 Caf=NoCafRefs,
 Str=DmdType <L,A><L,U(1*U,A,1*U,A,A,A,1*C1(U))><L,U><S(C(C(S))C(C(S))LLLLL),U(C(C1(H)),C(C1(U(U))),A,C(C1(C1(U))),A,A,A)><L,U><L,U>,
 Unf=OtherCon []]
Level1.$fInnerProductSpaceas_$cdot =
  \ (@ (a_a2hm :: * -> * -> *))
    (@ i_a2hn)
    (@ s_a2ho)
    _
    (w1_s3P2 :: GHC.Num.Num s_a2ho)
    (w2_s3P3 :: GHC.Arr.Ix i_a2hn)
    (w3_s3P4 :: Data.Array.Base.IArray a_a2hm s_a2ho)
    (w4_s3P5 :: a_a2hm i_a2hn s_a2ho)
    (w5_s3P6 :: a_a2hm i_a2hn s_a2ho) ->
    Level1.$w$cdot
      @ a_a2hm @ i_a2hn @ s_a2ho w1_s3P2 w2_s3P3 w3_s3P4 w4_s3P5 w5_s3P6

Level1.$fInnerProductSpaceas [InlPrag=[ALWAYS] CONLIKE]
  :: forall (a_a1k4 :: * -> * -> *) i_a1k5 s_a1k6.
     (Level0.VectorSpace (a_a1k4 i_a1k5) s_a1k6, GHC.Num.Num s_a1k6,
      GHC.Arr.Ix i_a1k5, Data.Array.Base.IArray a_a1k4 s_a1k6) =>
     Level0.InnerProductSpace (a_a1k4 i_a1k5) s_a1k6
[GblId[DFunId[1]],
 Arity=4,
 Caf=NoCafRefs,
 Str=DmdType <L,U><L,U(U,A,U,A,A,A,C(U))><L,U><L,U(C(C1(H)),C(C1(U(U))),A,C(C1(C1(U))),A,A,A)>m,
 Unf=OtherCon []]
Level1.$fInnerProductSpaceas =
  \ (@ (a_a2hm :: * -> * -> *))
    (@ i_a2hn)
    (@ s_a2ho)
    ($dVectorSpace_s3P7
       :: Level0.VectorSpace (a_a2hm i_a2hn) s_a2ho)
    ($dNum_s3P8 :: GHC.Num.Num s_a2ho)
    ($dIx_s3P9 :: GHC.Arr.Ix i_a2hn)
    ($dIArray_s3Pa
       :: Data.Array.Base.IArray a_a2hm s_a2ho) ->
    let {
      sat_s3Pd
        :: a_a2hm i_a2hn s_a2ho -> a_a2hm i_a2hn s_a2ho -> s_a2ho
      [LclId, Str=DmdType]
      sat_s3Pd =
        \ (w_s3Pb :: a_a2hm i_a2hn s_a2ho)
          (w1_s3Pc :: a_a2hm i_a2hn s_a2ho) ->
          Level1.$w$cdot
            @ a_a2hm
            @ i_a2hn
            @ s_a2ho
            $dNum_s3P8
            $dIx_s3P9
            $dIArray_s3Pa
            w_s3Pb
            w1_s3Pc } in
    Level0.D:InnerProductSpace
      @ (a_a2hm i_a2hn) @ s_a2ho $dVectorSpace_s3P7 sat_s3Pd

Level1.$w$cnorm [InlPrag=[0]]
  :: forall (a_a2gn :: * -> * -> *) i_a2go s_a2gp.
     (GHC.Num.Num s_a2gp, GHC.Arr.Ix i_a2go,
      Data.Array.Base.IArray a_a2gn s_a2gp) =>
     a_a2gn i_a2go s_a2gp -> s_a2gp
[GblId,
 Arity=3,
 Caf=NoCafRefs,
 Str=DmdType <L,U(1*U,A,C(C1(U)),A,A,A,1*C1(U))><L,U><L,U(C(C1(H)),C(C1(U(U))),A,C(C1(C1(U))),A,A,A)>,
 Unf=OtherCon []]
Level1.$w$cnorm =
  \ (@ (a_a2gn :: * -> * -> *))
    (@ i_a2go)
    (@ s_a2gp)
    (w_s3Pe :: GHC.Num.Num s_a2gp)
    (w1_s3Pf :: GHC.Arr.Ix i_a2go)
    (w2_s3Pg :: Data.Array.Base.IArray a_a2gn s_a2gp) ->
    let {
      a1_s3Ph :: s_a2gp -> s_a2gp -> s_a2gp
      [LclId, Str=DmdType]
      a1_s3Ph = GHC.Num.+ @ s_a2gp w_s3Pe } in
    let {
      a2_s3Pi :: s_a2gp
      [LclId, Str=DmdType]
      a2_s3Pi =
        GHC.Num.fromInteger
          @ s_a2gp w_s3Pe Level1.$fNormedVectorSpaceas1 } in
    let {
      sat_s3PC :: a_a2gn i_a2go s_a2gp -> s_a2gp
      [LclId, Str=DmdType]
      sat_s3PC =
        \ (x_s3Pj :: a_a2gn i_a2go s_a2gp) ->
          case Data.Array.Base.bounds
                 @ a_a2gn @ s_a2gp w2_s3Pg @ i_a2go w1_s3Pf x_s3Pj
          of _ { (_, _) ->
          case Data.Array.Base.numElements
                 @ a_a2gn @ s_a2gp w2_s3Pg @ i_a2go w1_s3Pf x_s3Pj
          of _ { GHC.Types.I# x1_s3Po ->
          case GHC.Prim.-# x1_s3Po 1 of y_s3Pp { __DEFAULT ->
          case GHC.Prim.># 0 y_s3Pp of sat_s3Pq { __DEFAULT ->
          case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3Pq
          of _ {
            GHC.Types.False ->
              letrec {
                go_s3Ps :: GHC.Prim.Int# -> s_a2gp -> s_a2gp
                [LclId, Arity=2, Str=DmdType <L,U><L,U>, Unf=OtherCon []]
                go_s3Ps =
                  \ (x2_s3Pt :: GHC.Prim.Int#)
                    (tpl_s3Pu :: s_a2gp) ->
                    let {
                      a3_s3Pv :: s_a2gp
                      [LclId, Str=DmdType]
                      a3_s3Pv =
                        let {
                          sat_s3Py :: s_a2gp
                          [LclId, Str=DmdType]
                          sat_s3Py =
                            let {
                              ds_s3Pw :: s_a2gp
                              [LclId, Str=DmdType]
                              ds_s3Pw =
                                let {
                                  sat_s3Px :: GHC.Types.Int
                                  [LclId, Str=DmdType]
                                  sat_s3Px = GHC.Types.I# x2_s3Pt } in
                                Data.Array.Base.unsafeAt
                                  @ a_a2gn @ s_a2gp w2_s3Pg @ i_a2go w1_s3Pf x_s3Pj sat_s3Px } in
                            GHC.Num.* @ s_a2gp w_s3Pe ds_s3Pw ds_s3Pw } in
                        a1_s3Ph tpl_s3Pu sat_s3Py } in
                    case GHC.Prim.==# x2_s3Pt y_s3Pp of sat_s3Pz { __DEFAULT ->
                    case GHC.Prim.tagToEnum# @ GHC.Types.Bool sat_s3Pz
                    of _ {
                      GHC.Types.False ->
                        case GHC.Prim.+# x2_s3Pt 1 of sat_s3PB { __DEFAULT ->
                        go_s3Ps sat_s3PB a3_s3Pv
                        };
                      GHC.Types.True -> a3_s3Pv
                    }
                    }; } in
              go_s3Ps 0 a2_s3Pi;
            GHC.Types.True -> a2_s3Pi
          }
          }
          }
          }
          } } in
    sat_s3PC

Level1.$fNormedVectorSpaceas_$cnorm [InlPrag=INLINE[0]]
  :: forall (a_a2gn :: * -> * -> *) i_a2go s_a2gp.
     (Level0.VectorSpace (a_a2gn i_a2go) s_a2gp, GHC.Num.Num s_a2gp,
      GHC.Arr.Ix i_a2go, Data.Array.Base.IArray a_a2gn s_a2gp) =>
     a_a2gn i_a2go s_a2gp -> s_a2gp
[GblId,
 Arity=4,
 Caf=NoCafRefs,
 Str=DmdType <L,A><L,U(1*U,A,C(C1(U)),A,A,A,1*C1(U))><L,U><L,U(C(C1(H)),C(C1(U(U))),A,C(C1(C1(U))),A,A,A)>,
 Unf=OtherCon []]
Level1.$fNormedVectorSpaceas_$cnorm =
  \ (@ (a_a2gn :: * -> * -> *))
    (@ i_a2go)
    (@ s_a2gp)
    _
    (w1_s3PE :: GHC.Num.Num s_a2gp)
    (w2_s3PF :: GHC.Arr.Ix i_a2go)
    (w3_s3PG :: Data.Array.Base.IArray a_a2gn s_a2gp) ->
    Level1.$w$cnorm @ a_a2gn @ i_a2go @ s_a2gp w1_s3PE w2_s3PF w3_s3PG

Level1.$fNormedVectorSpaceas [InlPrag=[ALWAYS] CONLIKE]
  :: forall (a_a1jM :: * -> * -> *) i_a1jN s_a1jO.
     (Level0.VectorSpace (a_a1jM i_a1jN) s_a1jO, GHC.Num.Num s_a1jO,
      GHC.Arr.Ix i_a1jN, Data.Array.Base.IArray a_a1jM s_a1jO) =>
     Level0.NormedVectorSpace (a_a1jM i_a1jN) s_a1jO
[GblId[DFunId[1]],
 Arity=4,
 Caf=NoCafRefs,
 Str=DmdType <L,U><L,U(U,A,C(C1(U)),A,A,A,C(U))><L,U><L,U(C(C1(H)),C(C1(U(U))),A,C(C1(C1(U))),A,A,A)>m,
 Unf=OtherCon []]
Level1.$fNormedVectorSpaceas =
  \ (@ (a_a2gn :: * -> * -> *))
    (@ i_a2go)
    (@ s_a2gp)
    ($dVectorSpace_s3PH
       :: Level0.VectorSpace (a_a2gn i_a2go) s_a2gp)
    ($dNum_s3PI :: GHC.Num.Num s_a2gp)
    ($dIx_s3PJ :: GHC.Arr.Ix i_a2go)
    ($dIArray_s3PK
       :: Data.Array.Base.IArray a_a2gn s_a2gp) ->
    let {
      sat_s3PL :: a_a2gn i_a2go s_a2gp -> s_a2gp
      [LclId, Str=DmdType]
      sat_s3PL =
        Level1.$w$cnorm
          @ a_a2gn @ i_a2go @ s_a2gp $dNum_s3PI $dIx_s3PJ $dIArray_s3PK } in
    Level0.D:NormedVectorSpace
      @ (a_a2gn i_a2go) @ s_a2gp $dVectorSpace_s3PH sat_s3PL


