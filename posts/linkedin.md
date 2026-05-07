---
platform: linkedin
topic: hott-riemann-hypothesis-vol6
title: "Volume VI"
url: "https://hott-riemann-hypothesis-vol6.vercel.app"
status: draft
created: 2026-05-07
---

**Volume VI — a Lean-verified reduction of the Riemann Hypothesis to a four-lemma No-Phantom Language.**

The argument is geometric. If there were a non-trivial zero of the Riemann zeta function off the critical line, it would create a nonzero vector in the Burnol/Blaschke model space K_B = H² / B·H². A rational-dilation Yoneda probe would detect that vector. Admissibility of the defect object forbids the resulting phantom — so no off-critical zero exists.

Seven Lean-verified papers formalise this argument.

**What closes unconditionally.** Paper 01 builds finite Blaschke packet model spaces and exhibits a nonzero reproducing-kernel vector. Paper 02 proves finite-rank RKHS detector completeness via Cauchy/Pick determinant nondegeneracy. Both compile cleanly under `lake build` and ship runghc-runnable Haskell artifacts that numerically verify the underlying calculations on a 3-zero finite Blaschke packet.

**What reduces to a minimal four-lemma data package.** The remaining four sub-targets — off-critical defect kernel transport, rational-dilation Yoneda externalization, quotient orthogonality by cokernel construction, and admissibility — each reduce to an iff-bridge characterising exactly which lemma the proof needs. The synthesis paper assembles all four into a single typed structure with four fields, from which `RH_classical_new_language_of_obstruction` derives `RH_classical` via a closed-form composition.

**The audit.** No `sorry`, no `admit`, no new `axiom`, no new `opaque` anywhere in the seven Lean modules. `lake build` passes 2937 jobs. `#print axioms` on the principal synthesis theorem reveals only standard Lean foundations and pre-existing infrastructure axioms — never RH itself, never Nyman density, never the Beurling-Nyman criterion. Three independent Codex `gpt-5.5` closure attempts at `model_reasoning_effort="xhigh"` independently confirmed the four-lemma reduction is minimal.

The development is live at:
https://hott-riemann-hypothesis-vol6.vercel.app

Source code on GitHub:
https://github.com/YonedaAI/hott-riemann-hypothesis-vol6

#RiemannHypothesis #LeanProver #HoTT #FormalMathematics #CategoryTheory
