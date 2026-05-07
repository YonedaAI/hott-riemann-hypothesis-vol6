---
platform: slack
topic: hott-riemann-hypothesis-vol6
title: "A Yoneda-RKHS Reduction of the Riemann Hypothesis"
url: "https://hott-riemann-hypothesis-vol6.vercel.app"
status: draft
created: 2026-05-07
---

*A Yoneda–RKHS Reduction of the Riemann Hypothesis* — Volume VI

Hardy model-space rigidity and condensed-Hilbert admissibility, formalised in Lean 4.

The argument: an off-critical zero of ζ produces a nonzero vector in `K_B = H^2 / B · H^2`; a rational-dilation Yoneda probe detects it; admissibility of the defect in the condensed-Hilbert setting forbids the resulting phantom.

• Two principal theorems unconditional (paper 01 finite Blaschke packets, paper 02 finite-rank RKHS detector)
• Remaining four reduce to a minimal four-lemma admissibility package via iff-bridges
• `lake build`: PASS (2937 jobs)
• Zero `sorry` / `admit` / new `axiom` / new `opaque`
• `#print axioms`: only standard Lean foundations — never RH, never Nyman density, never Beurling–Nyman
• Three independent Codex `gpt-5.5 xhigh` closure attempts confirmed the four-lemma reduction is minimal

Site:
<https://hott-riemann-hypothesis-vol6.vercel.app>

Source:
<https://github.com/YonedaAI/hott-riemann-hypothesis-vol6>
