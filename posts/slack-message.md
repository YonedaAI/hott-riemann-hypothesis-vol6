---
platform: slack
topic: hott-riemann-hypothesis-vol6
title: "HoTT Riemann Hypothesis Vol VI"
url: "https://hott-riemann-hypothesis-vol6.vercel.app"
status: draft
created: 2026-05-07
---

*HoTT Riemann Hypothesis Vol VI is live.*

Honest summary of what this volume delivers:

- Papers 01 and 02 close their principal theorems unconditionally: zero sorry, zero admit, zero new axioms
- Papers 03-06 each produce a parameterised iff-bridge plus a typed-proposition obstruction module, pinpointing exactly which vol5 opacities block unconditional closure
- The four named barriers: `axiom burnolBlaschkeFactor` (opaque `modelSpaceCarrier`) + four opaque admissibility/orthogonality predicates in the Burnol-Blaschke zero-detector calculus
- Paper 07 assembles `Vol6FinalObstruction` (4 fields) and proves `RH_classical_new_language_of_obstruction : Vol6FinalObstruction → RH_classical`
- `#print axioms` is clean of RH, Nyman density, and Beurling-Nyman
- `lake build Vol6` passes 2937 jobs; six Haskell artifacts verify the numerical calculations independently

RH was not proven unconditionally. What we have is a minimal, machine-checked, named obstruction set. That is the contribution.

<https://hott-riemann-hypothesis-vol6.vercel.app>
