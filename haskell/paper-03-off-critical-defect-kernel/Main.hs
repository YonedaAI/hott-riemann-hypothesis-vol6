{-|
Module      : Main
Description : Numerical witness for Vol6 paper 03 (off-critical defect kernel).

Given a numerical off-critical zeta candidate s ∈ ℂ in the critical strip
0 < Re s < 1 with Re s ≠ 1/2, this program

1. computes the Möbius image α(s) = (s − 1)/(s + 1),
2. constructs the singleton finite Blaschke packet P_s = {α(s)},
3. evaluates the singleton kernel vector — the constant-1 function on the
   one-element index type — and asserts it is a nonzero element of the
   finite-packet model space carrier `Fin 1 → ℂ`.

This mirrors the Lean development in `Vol6.OffCriticalDefectKernel` exactly.
The Haskell side does NOT discharge the Vol5 transport bridge to
`burnolBlaschkeFactor.modelSpaceCarrier`; that step is the obstruction
documented in `Vol6.Obstruction.OffCriticalDefectKernelObstruction`.

The test value `s = 0.6 + 14i` is used to exercise the construction: it has
real part 0.6 ≠ 1/2, lies in the critical strip, and was chosen for
illustrative purposes only — it is NOT claimed to be a zeta zero.
-}

module Main (main) where

import Data.Complex (Complex (..), magnitude, realPart, imagPart)

-- ---------------------------------------------------------------------------
-- 1. Möbius parameter map  s ↦ α(s) = (s - 1) / (s + 1).
-- ---------------------------------------------------------------------------

-- | Möbius image of `s`.  Sends the critical strip to the unit disc:
-- the line  Re s = 1/2  is mapped to the unit circle, and `s = 1` is
-- mapped to `0`.  For an off-critical zero we expect 0 < |α(s)| < 1.
mobiusParam :: Complex Double -> Complex Double
mobiusParam s = (s - 1) / (s + 1)

-- | Convenience wrapper agreeing with the Lean definition `α s`.
alpha :: Complex Double -> Complex Double
alpha = mobiusParam

-- ---------------------------------------------------------------------------
-- 2. Off-critical zero predicate  (numerical surrogate).
-- ---------------------------------------------------------------------------

-- | A numerical surrogate for the Lean predicate
--   `OffCriticalZero s := ζ(s) = 0 ∧ 0 < Re s ∧ Re s < 1 ∧ Re s ≠ 1/2`.
-- The zeta-zero condition is taken on faith for testing — see the module
-- header.  Returns True when the strip and off-line conditions hold.
isOffCriticalCandidate :: Complex Double -> Bool
isOffCriticalCandidate s =
  let re = realPart s
  in re > 0 && re < 1 && abs (re - 0.5) > 1e-9

-- ---------------------------------------------------------------------------
-- 3. Finite Blaschke packet  (singleton case).
-- ---------------------------------------------------------------------------

-- | A singleton finite Blaschke packet recording the Möbius image of `s`.
-- The Lean version has structure
--
--   structure FiniteBlaschkePacket where
--     ZeroIndex : Type
--     finite : Fintype ZeroIndex
--     zeroPoint : ZeroIndex -> ℂ
--     offCritical : ZeroIndex -> Prop
--
-- We model the singleton case with `ZeroIndex = ()`.
data SinglePointPacket = SinglePointPacket
  { zeroPoint   :: () -> Complex Double
  , offCritical :: () -> Bool
  }

singlePointPacket :: Complex Double -> SinglePointPacket
singlePointPacket s = SinglePointPacket
  { zeroPoint   = \() -> alpha s
  , offCritical = \() -> True
  }

-- | The carrier of the finite Blaschke model space attached to a singleton
-- packet: `() -> ℂ`, mirroring `Fin 1 -> ℂ` from the Lean development.
type SinglePointCarrier = () -> Complex Double

-- | The singleton kernel vector — the constant-1 function on the unit-type
-- index.  Lean equivalent: `(finiteBlaschkeModelSpace P).kernelVector`.
singlePointKernelVector :: SinglePointCarrier
singlePointKernelVector = \() -> 1

-- | Numerical norm of a singleton-carrier vector.
carrierNorm :: SinglePointCarrier -> Double
carrierNorm v = magnitude (v ())

-- | Decision that the kernel vector is nonzero (its norm is positive).
kernelVectorNonzero :: Bool
kernelVectorNonzero = carrierNorm singlePointKernelVector > 0

-- ---------------------------------------------------------------------------
-- 4. Test driver.
-- ---------------------------------------------------------------------------

-- | The off-critical test point `s = 0.6 + 14i`.  Chosen for illustration:
-- real part is 0.6 ≠ 0.5, in the critical strip; not claimed to be a zeta
-- zero.
testPoint :: Complex Double
testPoint = 0.6 :+ 14.0

-- | The full numerical pipeline:
--
--   1. Verify the test point is an off-critical candidate.
--   2. Compute α(s) and check |α(s)| < 1.
--   3. Build the singleton packet.
--   4. Evaluate the kernel vector and assert nonzero.
--
-- Prints a structured report and exits 0 on success.  Returns False if any
-- assertion fails (the `main` function then prints FAIL).
runPipeline :: Complex Double -> IO Bool
runPipeline s = do
  let aValue   = alpha s
      aMag     = magnitude aValue
      offCrit  = isOffCriticalCandidate s
      packet   = singlePointPacket s
      vec      = singlePointKernelVector
      vecAt0   = vec ()
      vecMag   = carrierNorm vec
      assert1  = offCrit
      assert2  = aMag < 1.0 && aMag > 0.0
      assert3  = magnitude (zeroPoint packet () - aValue) < 1e-12
      assert4  = vecMag > 0.0
      assert5  = kernelVectorNonzero
  putStrLn "===================================================="
  putStrLn "Vol6 paper 03 — Off-Critical Defect Kernel (Haskell)"
  putStrLn "===================================================="
  putStrLn $ "Input s = "         ++ show s
  putStrLn $ "  Re s    = "       ++ show (realPart s)
  putStrLn $ "  Im s    = "       ++ show (imagPart s)
  putStrLn $ "alpha(s) = (s-1)/(s+1) = " ++ show aValue
  putStrLn $ "  |alpha(s)|  = "    ++ show aMag
  putStrLn $ "Off-critical candidate? " ++ show offCrit
  putStrLn ""
  putStrLn "Singleton packet zero point:"
  putStrLn $ "  P_s.zeroPoint() = " ++ show (zeroPoint packet ())
  putStrLn ""
  putStrLn "Singleton kernel vector v : () -> Complex"
  putStrLn $ "  v()      = " ++ show vecAt0
  putStrLn $ "  |v|      = " ++ show vecMag
  putStrLn $ "  nonzero? = " ++ show assert4
  putStrLn ""
  putStrLn "Assertions:"
  putStrLn $ "  [A1] off-critical strip + off line .... " ++ show assert1
  putStrLn $ "  [A2] 0 < |alpha(s)| < 1 ............... " ++ show assert2
  putStrLn $ "  [A3] zeroPoint() == alpha(s) .......... " ++ show assert3
  putStrLn $ "  [A4] kernel vector norm > 0 ........... " ++ show assert4
  putStrLn $ "  [A5] kernelVectorNonzero flag ......... " ++ show assert5
  let allOk = assert1 && assert2 && assert3 && assert4 && assert5
  putStrLn ""
  putStrLn $ "RESULT: " ++ if allOk then "PASS" else "FAIL"
  return allOk

-- | Sanity table over a few candidates.  Demonstrates that the pipeline
-- discriminates between in-strip off-critical points and on-line / outside
-- points (only off-critical candidates produce assertion-1 = True).
sanityTable :: IO ()
sanityTable = do
  putStrLn ""
  putStrLn "----------------------------------------------------"
  putStrLn "Sanity table: (Re s, Im s) -> |alpha(s)|, off-crit?"
  putStrLn "----------------------------------------------------"
  let pts =
        [ 0.6  :+ 14.0   -- off-critical candidate
        , 0.5  :+ 14.0   -- on the critical line: should be False for off
        , 0.3  :+ 21.0   -- another off-critical candidate
        , 1.5  :+  3.0   -- outside strip: should be False
        , 0.0  :+  5.0   -- boundary: Re s = 0, should be False
        ]
      row s = do
        let a   = alpha s
            am  = magnitude a
            oc  = isOffCriticalCandidate s
        putStrLn $ "  s = "     ++ show s
                ++ "  |alpha| = " ++ show am
                ++ "  off-crit = " ++ show oc
  mapM_ row pts

main :: IO ()
main = do
  ok <- runPipeline testPoint
  sanityTable
  if ok
    then putStrLn "\nAll assertions passed; numerical pipeline mirrors Lean Step 1."
    else do
      putStrLn "\nFAILURE: some assertion failed."
      error "Vol6 paper 03 numerical pipeline FAILED"
