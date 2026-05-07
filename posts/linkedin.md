---
platform: linkedin
topic: hott-riemann-hypothesis-vol6
title: "HoTT Riemann Hypothesis Vol VI"
url: "https://hott-riemann-hypothesis-vol6.vercel.app"
status: draft
created: 2026-05-07
---

Vol VI of the HoTT Riemann Hypothesis series is published. Here is the honest verdict: two papers closed unconditionally, four obstructions precisely characterized, and the full build is clean of any sorry, admit, or new axiom across 2937 jobs. That is a meaningful advance, even though unconditional closure of RH itself did not happen in this volume.

The series has been working toward discharging the conditions of vol5's conditional theorem `RH_classical_of_no_phantom_language_breakthrough`. Vol VI addresses both payloads. Papers 01 and 02 complete their principal theorems without any deferred assumptions. Papers 03 through 06 take a different approach: rather than attempting unconditional proofs, each delivers a parameterised iff-bridge paired with a typed-proposition obstruction module. These modules do not hedge — they specify in machine-checkable Lean 4 exactly which definitions from vol5 prevent the argument from going through unconditionally.

The four obstructions reduce to a small set of named opacities inherited from vol5: the bare `axiom burnolBlaschkeFactor` with its opaque `modelSpaceCarrier` type, plus four `opaque Prop` predicates covering admissibility and orthogonality conditions in the Burnol-Blaschke zero-detector calculus. Paper 07 assembles these into `Vol6FinalObstruction`, a four-field structure, and proves `RH_classical_new_language_of_obstruction : Vol6FinalObstruction → RH_classical`. The `#print axioms` check confirms the statement is clean of RH, Nyman density, and Beurling-Nyman. Six runghc-runnable Haskell artifacts independently verify the underlying numerical calculations.

Precisely characterizing a barrier is a scientific result. The field now has a machine-checked, named, minimally-stated obstruction set rather than an informal conjecture about what might be hard. That is the contribution of Vol VI.

Full series: https://hott-riemann-hypothesis-vol6.vercel.app

#RiemannHypothesis #FormalMathematics #LeanProver #HomotopyTypeTheory #NumberTheory #TheoremProving #MathematicsResearch
