/-
  Volume VI — Paper 06: assembly of `YonedaBlaschkeDetectorCalculus`.

  This module assembles the canonical RKHS detector payload Vol5 names
  `BurnolBlaschkeRKHSDetectorSemantics` from four sub-targets:

    * detector completeness (paper 02)
    * rational-dilation externalization (paper 04)
    * quotient orthogonality (paper 05A)
    * condensed-Hilbert admissibility (paper 05B)

  The Vol5 structure (with the abbrev expansion from
  `Vol5.YonedaNymanTrackA.RKHSDetectorSemantics`) is

      structure ConcreteRKHSDetectorSemantics
          (K : CondensedHilbertDefect) : Type 1 where
        detector       : RKHSModelSpaceDetector K
        rational       : RationalDilationObjectSemantics
        externalization : RKHSDetectorExternalizationToRationalRepresentables
                            K detector rational
        orthogonality  : QuotientOrthogonalityInvisibility K.object
        admissibility  : AdmissibleCondensedHilbertDefect K

  Once papers 02/04/05 are theorem-closed, the assembly is a single record
  literal of these four fields.  This module exposes that assembly as a
  parameterised constructor `assembleYonedaBlaschkeDetectorCalculus`, which is
  proved unconditionally; the principal theorem
  `yoneda_blaschke_detector_calculus : YonedaBlaschkeDetectorCalculus` is then
  recovered from any inhabitant of the four-component bundle.

  At present, papers 02, 04, 05 have not shipped their principal theorems,
  so the bundle has no inhabitant and the principal theorem cannot be
  discharged without `sorry`.  The barrier is propagated through the paired
  obstruction module
  `Vol6.Obstruction.YonedaBlaschkeDetectorCalculusObstruction`, in compliance
  with the worker contract.

  Hard rules respected:
    * no `sorry`
    * no `admit`
    * no new `axiom`
    * no new `opaque`
    * no Nyman density / Beurling–Nyman / RH-equivalents
-/

import Vol5.YonedaNymanTrackA.NoPhantomLanguage
import Vol5.YonedaNymanTrackA.RKHSDetectorSemantics
import Vol5.YonedaNymanTrackA.CondensedHilbertDefect
import Vol5.YonedaNymanTrackA.FiniteRankRKHSDetector
import Vol6.Obstruction.YonedaBlaschkeDetectorCalculusObstruction

namespace Vol6

open Vol5 YonedaNymanTrackA

noncomputable section

/-! ## Sub-target type abbreviations

These are the precise types of the four sub-targets papers 02/04/05 must
produce for the canonical Burnol/Blaschke condensed Hilbert defect. -/

/-- Sub-target of paper 02: a general RKHS model-space detector for the
canonical Burnol/Blaschke condensed Hilbert defect. -/
abbrev BurnolBlaschkeDetectorComponent : Type 1 :=
  RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect

/-- Sub-target of paper 04 (parameter half): the rational-dilation object
semantics that pair with the detector to externalize it.  This is shared data
between papers 02 and 04 in the Vol5 structure layout. -/
abbrev BurnolBlaschkeRationalDilationComponent : Type 1 :=
  RationalDilationObjectSemantics

/-- Sub-target of paper 04 (externalization half), parameterised over the
detector and rational semantics produced by papers 02 + 04. -/
abbrev BurnolBlaschkeExternalizationComponent
    (detector : BurnolBlaschkeDetectorComponent)
    (rational : BurnolBlaschkeRationalDilationComponent) : Type 1 :=
  RKHSDetectorExternalizationToRationalRepresentables
    burnolBlaschkeCondensedHilbertDefect detector rational

/-- Sub-target of paper 05A: the cokernel-style quotient orthogonality
witness for the canonical Burnol/Blaschke defect object. -/
abbrev BurnolBlaschkeOrthogonalityComponent : Type 1 :=
  QuotientOrthogonalityInvisibility blaschkeDefectObject

/-- Sub-target of paper 05B: the canonical Burnol/Blaschke defect is an
admissible condensed Hilbert defect. -/
abbrev BurnolBlaschkeAdmissibilityComponent : Prop :=
  BurnolBlaschkeDefectIsAdmissible

/-! ## Bundle of the four sub-targets

We package the sub-targets as a single record so the principal assembly takes
one named hypothesis.  This is purely organisational: a term of `BundledSubTargets`
contains exactly the data one obtains by pulling each field from the four
upstream papers' principal theorems. -/

/-- The four sub-targets paper 06 receives from papers 02, 04, 05.

When papers 02/04/05 ship their principal theorems, the canonical inhabitant
of this bundle is

    { detector := burnol_blaschke_rkhs_detector_complete
      rational := canonicalRationalDilationSemantics
      externalization := burnol_blaschke_detector_externalization
      orthogonality := burnol_blaschke_quotient_orthogonality
      admissibility := burnol_blaschke_defect_is_admissible } -/
structure BundledSubTargets : Type 1 where
  detector       : BurnolBlaschkeDetectorComponent
  rational       : BurnolBlaschkeRationalDilationComponent
  externalization : BurnolBlaschkeExternalizationComponent detector rational
  orthogonality  : BurnolBlaschkeOrthogonalityComponent
  admissibility  : BurnolBlaschkeAdmissibilityComponent

/-! ## The assembly map

Given the four sub-targets, the calculus is assembled by a single record
literal.  This map is total and proof-free; no upstream lemma is required. -/

/-- Assemble `BurnolBlaschkeRKHSDetectorSemantics` from the four sub-targets. -/
def assembleRKHSDetectorSemantics
    (B : BundledSubTargets) :
    BurnolBlaschkeRKHSDetectorSemantics where
  detector := B.detector
  rational := B.rational
  externalization := B.externalization
  orthogonality := B.orthogonality
  admissibility := B.admissibility

/-- Assemble `YonedaBlaschkeDetectorCalculus` (target 2) from the four
sub-targets.  This is the `Type 1`-level wrapper. -/
def assembleYonedaBlaschkeDetectorCalculus
    (B : BundledSubTargets) :
    YonedaBlaschkeDetectorCalculus where
  rkhs := assembleRKHSDetectorSemantics B

/-- The conditional principal definition.  It states exactly what paper 06 is
contracted to deliver: given the four sub-target witnesses produced by papers
02, 04, 05, the assembly yields the target-2 calculus.

(`YonedaBlaschkeDetectorCalculus` lives in `Type 1`, not `Prop`, so this is a
`def`, not a `theorem`.  When papers 02/04/05 are theorem-closed and supply a
canonical `BundledSubTargets`, `yoneda_blaschke_detector_calculus :
YonedaBlaschkeDetectorCalculus` is recovered by application.  Because those
papers are currently obstruction-only, the unconditional definition is
propagated through `Vol6.Obstruction.YonedaBlaschkeDetectorCalculusObstruction`
— see status string below.) -/
def yoneda_blaschke_detector_calculus_of_subtargets
    (B : BundledSubTargets) :
    YonedaBlaschkeDetectorCalculus :=
  assembleYonedaBlaschkeDetectorCalculus B

/-! ## Composition with paper 03 to recover RH_classical

Paper 03 (`Vol6.OffCriticalDefectKernel`) supplies the second payload field
of `NoPhantomLanguageBreakthrough`.  Combined with paper 06 it yields a
complete inhabitant of `NoPhantomLanguageBreakthrough` and hence
`RH_classical` via the Vol5 master theorem.  The composition lemma below is
parameterised over both sub-target bundles so paper 07 (synthesis) can apply
it once both are available. -/

/-- Conditional master theorem in paper-06 form.  Given the four paper-06
sub-targets and the paper-03 off-critical defect kernel, classical RH follows
through the Vol5 master theorem
`RH_classical_of_no_phantom_language_breakthrough`. -/
theorem RH_classical_of_subtargets_and_off_critical_kernel
    (B : BundledSubTargets)
    (K : OffCriticalZeroDefectKernel) :
    Vol5.V5aTrackAFormulation.RH_classical :=
  RH_classical_of_no_phantom_language_breakthrough
    { detectorCalculus := assembleYonedaBlaschkeDetectorCalculus B
      offCriticalKernel := K }

/-! ## Obstruction status

The unconditional theorem `yoneda_blaschke_detector_calculus :
YonedaBlaschkeDetectorCalculus` is not delivered as a direct term in this
module because papers 02, 04, 05 have not yet shipped their principal
theorems.  The barrier is recorded in
`Vol6.Obstruction.YonedaBlaschkeDetectorCalculusObstruction`. -/

/-- The canonical paper-06 obstruction, re-exported here so consumers of paper
06 can inspect the precise upstream barrier without importing the obstruction
module directly. -/
def detectorCalculusObstruction :
    Obstruction.DetectorCalculusBarrier :=
  Obstruction.yonedaBlaschkeDetectorCalculusObstruction

/-- Audit marker.  `lake build Vol6.YonedaBlaschkeDetectorCalculus` should
print this string in the diagnostics produced by paper 06. -/
def assembly_status : String :=
  "Paper 06 (YonedaBlaschkeDetectorCalculus) ships the conditional assembly "
  ++ "yoneda_blaschke_detector_calculus_of_subtargets : BundledSubTargets -> "
  ++ "YonedaBlaschkeDetectorCalculus, the bundled sub-target type "
  ++ "BundledSubTargets, and the composition with paper 03 "
  ++ "RH_classical_of_subtargets_and_off_critical_kernel. The unconditional "
  ++ "principal theorem is gated on papers 02, 04, 05 (see "
  ++ "Vol6.Obstruction.YonedaBlaschkeDetectorCalculusObstruction)."

end

end Vol6
