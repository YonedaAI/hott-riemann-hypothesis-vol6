---
platform: facebook
topic: hott-riemann-hypothesis-vol6
title: "Volume VI"
url: "https://hott-riemann-hypothesis-vol6.vercel.app"
status: draft
created: 2026-05-07
---

Volume VI of the HoTT/Yoneda Riemann Hypothesis programme is now live.

The Riemann Hypothesis is the most famous open problem in mathematics. It says every non-trivial zero of a function called the Riemann zeta function lies on a single vertical line in the complex plane. Volume VI does not prove the Riemann Hypothesis. What it does is reduce it, formally and machine-checkably, to four named lemmas.

The strategy is geometric. If a zero existed off that line, it would produce a particular non-zero vector in a specific Hilbert space called the Burnol/Blaschke model space. A particular kind of probe, called a rational-dilation Yoneda probe, would detect that vector. The whole structure of the model space would then forbid the resulting phantom. Hence, no off-line zero.

Volume VI formalises this argument across seven papers, each accompanied by a Lean 4 module and a runnable Haskell numerical demonstration.

Two principal theorems close completely. The first, on finite Blaschke packet model spaces, builds the geometric stage. The second, on finite-rank reproducing-kernel Hilbert space detectors, proves the relevant detection mechanism is non-degenerate. Both compile under Lean's lake build system and run cleanly under Haskell's runghc.

The remaining four sub-targets reduce to a minimal four-lemma data package, with each lemma characterised by an iff-bridge proving it is exactly what the proof needs. Together they assemble a single typed structure from which the synthesis theorem derives a conditional form of classical Riemann.

The audit is the strict part. No use of sorry. No use of admit. No new axiom. No new opaque definition. The lake build passes 2937 jobs. Lean's print axioms command, run on the principal synthesis theorem, shows only standard logical foundations. Never the Riemann Hypothesis itself. Never Nyman density. Never the Beurling-Nyman criterion. Three independent Codex gpt-5.5 closure attempts at maximum reasoning effort confirmed the four-lemma reduction is genuinely minimal.

The full development is online:
https://hott-riemann-hypothesis-vol6.vercel.app

Source code:
https://github.com/YonedaAI/hott-riemann-hypothesis-vol6

#RiemannHypothesis #Mathematics #FormalProof #LeanProver #NumberTheory #MathResearch
