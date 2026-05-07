{-# LANGUAGE BangPatterns #-}
{- |
   Module      : Main
   Description : Vol6 paper 01 — finite Blaschke packet runnable verification.
   Copyright   : (c) Yoneda AI Research, 2026
   License     : research / internal
   Maintainer  : research@yonedaai.com

   This program is the executable companion to vol6 paper 01,
   /Concrete Finite Blaschke Packet Model Spaces/.  It implements the
   finite Blaschke product

       B_P(z) = prod_{i=1..n} (z - alpha_i) / (1 - conj(alpha_i) * z)

   as a composition of single Möbius factors, the kernel vector field

       k_w(z) = (1 - B_P(z) * conj(B_P(w))) / (1 - z * conj(w)),

   and the standard Pick basis used in the LaTeX writeup.  We construct
   a 3-zero packet and:

   1.  evaluate B_P at one of its zeros and check it vanishes,
   2.  build the reproducing-kernel vector at one of the packet zeros and
       check it is nonzero at a generic point in the open unit disk,
   3.  build the 3x3 Gram/Pick matrix at the packet zeros and check that
       its diagonal entries are nonzero (the simplest finite-rank
       nondegeneracy witness for the model space K_{B_P}).

   Compile / run:

       runghc Main.hs

   Or with cabal (no extra deps; only `base`):

       cabal run paper-01-finite-blaschke-packet

   Cabal file (one-liner: copy into a `paper-01-finite-blaschke-packet.cabal`
   alongside this file if desired):

       cabal-version:      2.2
       name:               paper-01-finite-blaschke-packet
       version:            0.1.0.0
       executable paper-01-finite-blaschke-packet
         main-is:          Main.hs
         build-depends:    base
         default-language: Haskell2010

   The program exits with code 0 on success and prints PASS for each
   asserted invariant.  On failure it prints FAIL with diagnostic info.
-}

module Main (main) where

import           Data.Complex (Complex (..), conjugate, magnitude, realPart)
import           Data.List    (foldl')
import           System.Exit  (exitFailure, exitSuccess)

------------------------------------------------------------------------
-- Complex helpers
------------------------------------------------------------------------

-- | Type alias to keep signatures readable.
type C = Complex Double

-- | A small numerical tolerance for floating-point assertions.
eps :: Double
eps = 1.0e-10

-- | Approximate-equality predicate for complex numbers.
approxZero :: C -> Bool
approxZero z = magnitude z < eps

-- | Approximate-equality between complex numbers.
approxEq :: C -> C -> Bool
approxEq a b = magnitude (a - b) < eps

------------------------------------------------------------------------
-- Single Möbius factor and finite Blaschke product
------------------------------------------------------------------------

-- | The single-zero Blaschke factor centered at @alpha@:
--
--   @b_alpha(z) = (z - alpha) / (1 - conj(alpha) * z)@
--
--   Defined on the open unit disk @|z| < 1@; we do not enforce that
--   constraint at the type level, but the inputs we use below all lie in
--   the unit disk.
mobiusFactor :: C -> C -> C
mobiusFactor alpha z =
  let num = z - alpha
      den = (1 :+ 0) - conjugate alpha * z
  in  num / den

-- | The finite Blaschke product attached to a packet of zeros.
--
--   Implemented as a left fold (composition of factor evaluations) over
--   the list of zeros.  This realizes the product
--
--     B_P(z) = prod_i b_{alpha_i}(z).
finiteBlaschke :: [C] -> C -> C
finiteBlaschke alphas z =
  foldl' (\acc a -> acc * mobiusFactor a z) (1 :+ 0) alphas

------------------------------------------------------------------------
-- Reproducing kernel vector for the model space
------------------------------------------------------------------------

-- | The Szegő reproducing kernel of the unit-disk Hardy space.
--
--   @szegoKernel w z = 1 / (1 - z * conj(w))@.
szegoKernel :: C -> C -> C
szegoKernel w z = (1 :+ 0) / ((1 :+ 0) - z * conjugate w)

-- | The reproducing kernel vector for the model space @K_{B_P}@ at the
--   point @w@:
--
--     k_w(z) = (1 - B_P(z) * conj(B_P(w))) / (1 - z * conj(w)).
--
--   When @w@ is itself a zero of @B_P@, the formula simplifies to the
--   ordinary Szegő kernel @1/(1 - z * conj(w))@, which is manifestly
--   nonzero on the open unit disk.  We verify this numerically below.
modelKernelVector :: [C] -> C -> C -> C
modelKernelVector alphas w z =
  let bw  = finiteBlaschke alphas w
      bz  = finiteBlaschke alphas z
      num = (1 :+ 0) - bz * conjugate bw
      den = (1 :+ 0) - z  * conjugate w
  in  num / den

------------------------------------------------------------------------
-- Gram / Pick matrix at the packet zeros
------------------------------------------------------------------------

-- | The Gram/Pick matrix entry @G(i,j) = k_{alpha_j}(alpha_i)@.  When
--   @alpha_j@ is a packet zero, @B_P(alpha_j) = 0@, so this reduces to
--   the Szegő kernel @1/(1 - alpha_i * conj(alpha_j))@.
gramEntry :: [C] -> C -> C -> C
gramEntry alphas wRow wCol =
  modelKernelVector alphas wCol wRow

-- | Build the full Gram matrix as a list of rows.
gramMatrix :: [C] -> [[C]]
gramMatrix alphas =
  [ [ gramEntry alphas wRow wCol | wCol <- alphas ] | wRow <- alphas ]

------------------------------------------------------------------------
-- Top-level verification
------------------------------------------------------------------------

-- | A simple inline test runner.  Prints PASS / FAIL and threads a
--   cumulative success flag.
check :: String -> Bool -> IO Bool
check name ok = do
  putStrLn $ (if ok then "PASS  " else "FAIL  ") <> name
  pure ok

main :: IO ()
main = do
  putStrLn "vol6 paper-01-finite-blaschke-packet (Yoneda AI Research)"
  putStrLn "  finite Blaschke product / kernel-vector / Gram-matrix sanity"
  putStrLn ""

  -- A 3-zero packet inside the open unit disk.
  let alpha1, alpha2, alpha3 :: C
      alpha1 = 0.30 :+ 0.10
      alpha2 = (-0.20) :+ 0.40
      alpha3 = 0.10 :+ (-0.50)
      packet = [alpha1, alpha2, alpha3]

  -- Sanity 1: each alpha_i must be inside the open unit disk.
  let inDisk z = magnitude z < 1.0
  ok1 <- check "all packet zeros lie in the open unit disk"
                 (all inDisk packet)

  -- Sanity 2: B_P(alpha_i) = 0 for each packet zero (within tolerance).
  let bAtAlphas = map (finiteBlaschke packet) packet
  ok2 <- check "B_P vanishes at each packet zero"
                 (all approxZero bAtAlphas)

  -- Sanity 3: the kernel vector at alpha_1 evaluated at a generic point
  -- z = 0.5 + 0.2i is nonzero.
  let zTest = 0.5 :+ 0.2
      kVal  = modelKernelVector packet alpha1 zTest
  putStrLn $ "  k_{alpha_1}(z_test) = " <> show kVal
  ok3 <- check "kernel vector at alpha_1 is nonzero at z_test"
                 (not (approxZero kVal))

  -- Sanity 4: the kernel vector at alpha_1 reduces to the Szegő kernel
  -- there, since B_P(alpha_1) = 0.
  let szego = szegoKernel alpha1 zTest
  ok4 <- check "kernel vector at alpha_1 equals Szegő kernel at z_test"
                 (approxEq kVal szego)

  -- Sanity 5: the diagonal of the Pick matrix at the packet zeros is
  -- nonzero.  This is the simplest nondegeneracy witness used in the
  -- LaTeX writeup; it is enough for paper-01's nonemptiness theorem and
  -- the basis for paper-02's full Gram-matrix nondegeneracy proof.
  let g       = gramMatrix packet
      diag    = [ g !! i !! i | i <- [0 .. length packet - 1] ]
  putStrLn $ "  Gram diagonal = " <> show diag
  ok5 <- check "Pick matrix diagonal is strictly positive (real part)"
                 (all (\x -> realPart x > 0) diag)

  -- Sanity 6: principal theorem witness.  In the Lean module the
  -- principal theorem `finite_packet_model_space_nonempty` exhibits
  -- a vector in the model-space carrier; here we exhibit the analogous
  -- complex number `k_{alpha_1}(zTest)` and assert it is nonzero.
  ok6 <- check "principal theorem analogue: model-space witness is nonzero"
                 (not (approxZero kVal))

  let allOk = and [ok1, ok2, ok3, ok4, ok5, ok6]
  putStrLn ""
  if allOk
    then do
      putStrLn "ALL CHECKS PASSED"
      exitSuccess
    else do
      putStrLn "ONE OR MORE CHECKS FAILED"
      exitFailure
