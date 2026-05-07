# A Yoneda–RKHS Reduction of the Riemann Hypothesis

Volume VI. Hardy model-space rigidity and condensed-Hilbert admissibility, formalised in Lean 4.

Site: https://hott-riemann-hypothesis-vol6.vercel.app

## Status

This is a conditional reduction, not a proof of the Riemann Hypothesis.

In plain terms:

- The detector and admissibility predicates from the Burnol–Blaschke / Yoneda calculus are described but not built. They live as opaque declarations on the upstream surface, and nothing in Volume VI produces an object that satisfies them.
- The bridge from a hypothetical off-critical zero to a vector in the canonical Burnol–Blaschke model space currently collapses to *the carrier is nonempty*. That is much weaker than the actual zeta-to-Burnol transport theorem the proof needs.
- The contradiction the argument promises lives in Lean as a conditional theorem. Given the missing pieces as input, it derives the Riemann Hypothesis. Producing those pieces is the open work.

## The argument

If a non-trivial zero of ζ sat off the critical line, it would put a non-zero vector in the Burnol–Blaschke model space `K_B = H² / B · H²`. A rational-dilation Yoneda probe would see that vector. Admissibility of the defect in the condensed-Hilbert setting would then forbid the resulting phantom.

That is the geometry. Volume VI formalises it across seven Lean papers and isolates which steps actually go through and which still need to be built.

## What is and isn't proved

| # | Paper | Lean module | Status |
|---|---|---|---|
| 01 | Finite Blaschke Packet Model Spaces | `Vol6.FiniteBlaschkePacket` | proved |
| 02 | Finite-Rank RKHS Detector Completeness | `Vol6.FiniteRankDetector` | proved |
| 03 | Off-Critical Zero Defect Kernel | `Vol6.OffCriticalDefectKernel` | conditional. Bridge collapses to `Nonempty burnolBlaschkeFactor.modelSpaceCarrier`. |
| 04 | Rational-Dilation Yoneda Externalization | `Vol6.RationalDilationExternalization` | conditional. Detection field is gated on an opaque upstream predicate. |
| 05 | Quotient Orthogonality and Admissibility | `Vol6.QuotientOrthogonalityAdmissibility` | conditional. iff-bridge to upstream opaque atoms; no inhabitant produced. |
| 06 | Yoneda–Blaschke Detector Calculus | `Vol6.YonedaBlaschkeDetectorCalculus` | conditional. Assembles 02 / 04 / 05; inherits their conditionality. |
| 07 | Synthesis | `Vol6.RHClassicalNewLanguage` | derives `RH_classical` from a four-field input package. |

The four-field package is the open problem. It collects exactly the pieces papers 03–06 do not build.

## Build

```bash
cd lean
PATH="$HOME/.elan/bin:$PATH" lake build Vol6
```

Passes 2937 jobs. The `.lake` cache is symlinked to a sibling volume's `mathlib` build (~7 GB); the first build on a fresh tree will populate it.

```bash
cd lean
PATH="$HOME/.elan/bin:$PATH" lake env lean -e \
  'import Vol6.RHClassicalNewLanguage; #print axioms Vol6.RHClassicalNewLanguage.RH_classical_new_language_of_obstruction'
```

The dependency list is standard Lean foundations plus a small set of upstream infrastructure axioms (`DQHom`, `DQ_comp`, `HardySubmodule`, `NymanKernel`, `blaschkeHardyImage`, `burnolBlaschkeFactor`). It does not include RH, Nyman density, or the Beurling–Nyman criterion.

## Numerical sanity

Each math-bearing paper has a Haskell artifact under `haskell/<paper>/Main.hs`. They run under `runghc`, use only `base`, and check the underlying calculations on a small finite Blaschke packet — Cauchy/Pick determinant nondegeneracy, kernel-vector evaluation, fractional-part Mellin agreement, cokernel orthogonality, dualizable / polarized / regularized admissibility scores.

## Layout

```
lean/Vol6/                 Lean modules (7 papers, 6 obstruction modules, 4 closure characterisations)
papers/latex/              arXiv-style sources
papers/pdf/                compiled PDFs
haskell/<paper>/           runghc-runnable numerical artifacts
website/                   Next.js site (App Router, output: 'export')
posts/                     multi-platform announcement posts
sources/                   upstream source references
.knowledge-base.md         extracted definitions and cross-references from the upstream surface
```

## What it would take to close

Either (a) commit to concrete semantics for the upstream opaque predicates and prove the resulting theorems from the finite-rank machinery in papers 02 and 05, or (b) add upstream-side introduction rules that papers 03–06 can call. Both are real mathematical work, not formalisation work.

## License

MIT. Treat the contents as MIT-licensed if no `LICENSE` file is present.

## Citation

```
@misc{yoneda_rkhs_rh_vol6_2026,
  title  = {A Yoneda--RKHS Reduction of the Riemann Hypothesis},
  author = {Yoneda AI Research},
  year   = {2026},
  note   = {Volume VI. Hardy model-space rigidity and condensed-Hilbert admissibility, formalised in Lean 4. Conditional reduction.},
  url    = {https://hott-riemann-hypothesis-vol6.vercel.app}
}
```
