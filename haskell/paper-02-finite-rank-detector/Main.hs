-- | Vol6 Paper 02 — Finite-Rank Detector Numerical Verification
--
-- Computes the 3-by-3 Hardy Gram matrix
--
--     G_{ij} = 1 / (1 - w_j * conj(w_i))
--
-- for three distinct disc points and asserts that |det G| > 1e-9
-- (Cauchy-determinant nondegeneracy).  Also verifies the closed-form
-- Cauchy determinant formula against the direct expansion.
--
-- Run:
--
--     runghc Main.hs
--
-- Output prints PASS/FAIL on each assertion.

module Main where

import Data.Complex (Complex(..), magnitude, conjugate, realPart)
import Data.List (subsequences)

------------------------------------------------------------------------------
-- 3-by-3 complex matrix utilities
------------------------------------------------------------------------------

type CD = Complex Double
type Mat3 = ((CD,CD,CD),(CD,CD,CD),(CD,CD,CD))

-- | det of a 3x3 complex matrix, by Sarrus / cofactor expansion.
det3 :: Mat3 -> CD
det3 ((a,b,c),(d,e,f),(g,h,i)) =
    a*(e*i - f*h) - b*(d*i - f*g) + c*(d*h - e*g)

-- | Build the Hardy Gram matrix at three disc points w1,w2,w3.
hardyGram :: CD -> CD -> CD -> Mat3
hardyGram w1 w2 w3 =
  let g i j = 1 / (1 - j * conjugate i)
  in ( (g w1 w1, g w1 w2, g w1 w3)
     , (g w2 w1, g w2 w2, g w2 w3)
     , (g w3 w1, g w3 w2, g w3 w3) )

-- | Cauchy-determinant closed form:
--     det G = prod_{i<j} |w_i - w_j|^2 / prod_{i,j} (1 - w_j conj(w_i)).
cauchyClosedForm :: CD -> CD -> CD -> CD
cauchyClosedForm w1 w2 w3 =
  let pairs = [(w1,w2),(w1,w3),(w2,w3)]
      num = product [ (magnitude (a - b)) ** 2 :+ 0 | (a,b) <- pairs ]
      ws  = [w1,w2,w3]
      den = product [ 1 - j * conjugate i | i <- ws, j <- ws ]
  in num / den

------------------------------------------------------------------------------
-- Main: run the assertions
------------------------------------------------------------------------------

main :: IO ()
main = do
  putStrLn "Vol6 paper 02 — finite-rank detector / Cauchy-determinant test"
  putStrLn "=============================================================="

  let w1 = 0.3      :+ 0.0
      w2 = 0.5      :+ 0.2
      w3 = (-0.4)   :+ 0.1
      g  = hardyGram w1 w2 w3
      d  = det3 g

  putStrLn $ "Disc points: w1 = " ++ show w1
                 ++ ", w2 = " ++ show w2
                 ++ ", w3 = " ++ show w3
  putStrLn $ "det G                = " ++ show d
  putStrLn $ "|det G|              = " ++ show (magnitude d)

  let dCF = cauchyClosedForm w1 w2 w3
      relErr = magnitude (d - dCF) / magnitude d
  putStrLn $ "Cauchy closed form   = " ++ show dCF
  putStrLn $ "relative error       = " ++ show relErr

  -- Assertion 1: |det G| > 1e-9 (nondegeneracy)
  let pass1 = magnitude d > 1e-9
  putStrLn $ if pass1
                then "PASS: |det G| > 1e-9 (Gram matrix nondegenerate)"
                else "FAIL: |det G| <= 1e-9 (Gram matrix degenerate)"

  -- Assertion 2: det G is real-positive up to numerical error.
  -- The Hardy Gram matrix is Hermitian positive definite, so det G > 0.
  let pass2 = realPart d > 0 && abs (imagPart' d) < 1e-9
  putStrLn $ if pass2
                then "PASS: det G is real-positive (Hermitian PD)"
                else "FAIL: det G is not real-positive"

  -- Assertion 3: closed form matches direct determinant
  let pass3 = relErr < 1e-9
  putStrLn $ if pass3
                then "PASS: Cauchy closed form matches det3 (within 1e-9)"
                else "FAIL: Cauchy closed form disagrees with det3"

  putStrLn ""
  if pass1 && pass2 && pass3
     then putStrLn "ALL ASSERTIONS PASSED"
     else putStrLn "SOME ASSERTION FAILED"
  where
    imagPart' :: CD -> Double
    imagPart' (_ :+ y) = y
