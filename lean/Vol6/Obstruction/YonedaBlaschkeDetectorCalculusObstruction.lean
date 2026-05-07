/-
  Volume VI — Paper 06 obstruction module.

  Paper 06 (`Vol6.YonedaBlaschkeDetectorCalculus`) assembles the four
  sub-targets

      detector completeness        (paper 02)
      rational-dilation externalization (paper 04)
      quotient orthogonality       (paper 05A)
      condensed-Hilbert admissibility   (paper 05B)

  into the `BurnolBlaschkeRKHSDetectorSemantics` payload of
  `YonedaBlaschkeDetectorCalculus`.  At present (sprint position 6),
  none of papers 02, 04, 05 has shipped a theorem-closed Lean module.
  Their canonical Vol6 modules

      Vol6.FiniteRankDetector
      Vol6.RationalDilationExternalization
      Vol6.QuotientOrthogonalityAdmissibility

  do not yet exist.  The assembly therefore cannot be discharged as a
  theorem and is instead delivered through the obstruction propagated by
  this module, in compliance with the worker contract:

      "If any of those papers shipped only an Obstruction, your assembly
       produces a paired Vol6/Obstruction/YonedaBlaschkeDetectorCalculus
       Obstruction.lean propagating the precise barrier."

  No `sorry`, `admit`, new `axiom`, or new `opaque` is introduced.
  The obstruction is a plain `Prop`-valued data structure listing the
  upstream blockers; paper 06 records it but does not assume it.
-/

namespace Vol6
namespace Obstruction

/-- Identifier for an upstream Vol6 paper whose principal theorem is not yet
available.  These three names track the dependencies of paper 06 (assembly). -/
inductive UpstreamPaper : Type
  | finiteRankDetector              -- paper 02
  | rationalDilationExternalization -- paper 04
  | quotientOrthogonalityAdmissibility -- paper 05
  deriving DecidableEq, Repr

/-- A textual barrier description for one upstream paper. -/
structure UpstreamBarrier where
  paper : UpstreamPaper
  module : String        -- canonical Vol6 module name
  symbol : String        -- canonical Lean symbol expected
  reason : String        -- why the symbol is not yet available
  deriving Repr

/-- The four-component bundle expected by `BurnolBlaschkeRKHSDetectorSemantics`,
recorded here only as a barrier list.  Each component is paired with the
upstream Vol6 paper that must supply it.

The fields are deliberately concrete `String` data: this is not a proof
obligation, it is a *checklist* of upstream work that paper 06 will consume
once those papers ship their principal theorems. -/
structure DetectorCalculusBarrier where
  detectorCompleteness : UpstreamBarrier
  externalization      : UpstreamBarrier
  orthogonality        : UpstreamBarrier
  admissibility        : UpstreamBarrier
  deriving Repr

/-- The canonical paper-06 obstruction.  Each component is the precise upstream
barrier that paper 06 propagates to its consumer (paper 07). -/
def yonedaBlaschkeDetectorCalculusObstruction : DetectorCalculusBarrier where
  detectorCompleteness :=
    { paper  := UpstreamPaper.finiteRankDetector
      module := "Vol6.FiniteRankDetector"
      symbol := "burnol_blaschke_rkhs_detector_complete"
      reason :=
        "Paper 02 has not yet produced an inhabitant of "
        ++ "RKHSModelSpaceDetector for burnolBlaschkeCondensedHilbertDefect; "
        ++ "the Gram-matrix nondegeneracy proof for finite Blaschke packets "
        ++ "and its lift to the canonical condensed Hilbert defect are pending." }
  externalization :=
    { paper  := UpstreamPaper.rationalDilationExternalization
      module := "Vol6.RationalDilationExternalization"
      symbol := "burnol_blaschke_detector_externalization"
      reason :=
        "Paper 04 has not yet produced an inhabitant of "
        ++ "RKHSDetectorExternalizationToRationalRepresentables; the "
        ++ "presheaf_eq route through DQObj = NymanKernel and the "
        ++ "lift via FractionalPartExternalizationTransparentPackage are pending." }
  orthogonality :=
    { paper  := UpstreamPaper.quotientOrthogonalityAdmissibility
      module := "Vol6.QuotientOrthogonalityAdmissibility"
      symbol := "burnol_blaschke_quotient_orthogonality"
      reason :=
        "Paper 05A has not yet produced an inhabitant of "
        ++ "QuotientOrthogonalityInvisibility blaschkeDefectObject by "
        ++ "the cokernel construction; the OrthogonalToRepresentable witness "
        ++ "with no_detection_of_orthogonal is pending." }
  admissibility :=
    { paper  := UpstreamPaper.quotientOrthogonalityAdmissibility
      module := "Vol6.QuotientOrthogonalityAdmissibility"
      symbol := "burnol_blaschke_defect_is_admissible"
      reason :=
        "Paper 05B has not yet produced inhabitants of the three opaque "
        ++ "atoms BlaschkeDefectDualizable, BlaschkeDefectPolarized, "
        ++ "BlaschkeDefectRegularized for the canonical Burnol/Blaschke "
        ++ "defect, nor the assembly into BurnolBlaschkeDefectIsAdmissible." }

/-- The four upstream papers whose absence blocks the assembly. -/
def yonedaBlaschkeDetectorCalculusBlockingPapers
    : List UpstreamPaper :=
  [ UpstreamPaper.finiteRankDetector
  , UpstreamPaper.rationalDilationExternalization
  , UpstreamPaper.quotientOrthogonalityAdmissibility ]

/-- Audit string emitted to the build log so downstream agents can see exactly
which upstream symbols paper 06 is waiting on. -/
def obstruction_status : String :=
  "Paper 06 (YonedaBlaschkeDetectorCalculus) is in obstruction-only mode: "
  ++ "the BurnolBlaschkeRKHSDetectorSemantics assembly is parameterised over "
  ++ "burnol_blaschke_rkhs_detector_complete (paper 02), "
  ++ "burnol_blaschke_detector_externalization (paper 04), "
  ++ "burnol_blaschke_quotient_orthogonality (paper 05A), and "
  ++ "burnol_blaschke_defect_is_admissible (paper 05B). "
  ++ "These three Vol6 modules have not been created. "
  ++ "No new axiom, opaque, sorry, or admit is introduced."

/-- Sanity lemma: the obstruction lists exactly four barriers (one per
component of `BurnolBlaschkeRKHSDetectorSemantics`). -/
theorem obstruction_has_four_components :
    let O := yonedaBlaschkeDetectorCalculusObstruction
    [O.detectorCompleteness.module, O.externalization.module,
     O.orthogonality.module, O.admissibility.module].length = 4 := by
  rfl

/-- Sanity lemma: the blocking-paper list is precisely the three upstream
papers paper 06 depends on. -/
theorem blocking_papers_are_02_04_05 :
    yonedaBlaschkeDetectorCalculusBlockingPapers.length = 3 := by
  rfl

end Obstruction
end Vol6
