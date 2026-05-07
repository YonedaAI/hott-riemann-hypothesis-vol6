---
platform: facebook
topic: hott-riemann-hypothesis-vol6
title: "HoTT Riemann Hypothesis Vol VI"
url: "https://hott-riemann-hypothesis-vol6.vercel.app"
status: draft
created: 2026-05-07
---

We just published Volume VI of our Riemann Hypothesis proof series, and we want to be completely straight with you about what it says.

The Riemann Hypothesis is one of the most famous unsolved problems in mathematics. It concerns the distribution of prime numbers and has been open for over 160 years. We have NOT proven it unconditionally. But Vol VI does something that is genuinely useful: it tells you EXACTLY why we cannot close the proof yet, and it proves that characterization is correct using a computer proof checker called Lean 4.

Here is what actually happened in this volume.

Two of the seven papers close their main theorems completely. No shortcuts, no deferred assumptions, no "trust me" steps. The proof checker verified every line across 2937 build jobs.

The remaining five papers ran into a wall. But instead of stopping there, we turned the wall into a result. Each paper produces a machine-checked obstruction proof: a formal statement that says "this theorem is equivalent to RH if and only if these specific named assumptions hold." We identified four named barriers inherited from the previous volume, including an axiom called burnolBlaschkeFactor and four predicates governing a mathematical tool called the Burnol-Blaschke zero-detector.

The final paper assembles all four barriers into a single structure called Vol6FinalObstruction and proves that if you can resolve those four items, you get RH. The proof checker independently confirms that this final theorem does not secretly assume RH, Nyman density, or Beurling-Nyman conditions.

Six separate Haskell programs independently verify the underlying numerical calculations.

Knowing precisely what you cannot yet do, and having a machine certify that precision, is scientific progress. The barrier is no longer vague. It has a name, a type, and a proof.

Read the full series here:
https://hott-riemann-hypothesis-vol6.vercel.app

#RiemannHypothesis #Mathematics #FormalProof #LeanProver #NumberTheory #MathResearch
