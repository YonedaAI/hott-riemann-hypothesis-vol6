/-
  Volume VI - Paper 04 obstruction module:
  `Vol6.Obstruction.RationalDilationExternalizationObstruction`.

  Vol5 declares

      opaque DefectDetectedByRationalDilationRepresentable :
        BlaschkeDefectObject -> DQPresheaf -> Prop

  in `NoPhantomBlaschkeDefect.lean`.  Because the predicate is opaque
  in vol5, Lean cannot unfold it to produce inhabitants.  The vol5
  surface exposes no introduction rule, no characterization theorem,
  and no proof constructor for the predicate.  Consequently, the only
  way to inhabit
  `RKHSDetectorExternalizationToRationalRepresentables K S R` for an
  *honest* (non-vacuous) detector `S` is to receive a detector-indexed
  introduction rule for that opaque predicate as data.  The rule must be scoped
  to actual detector witnesses; it must not assert that every rational-dilation
  representable detects the defect.

  This module:

  * states the externalization-introduction-rule data as a
    transparent vol6 structure
    `ExternalizationIntroductionRule`,
  * states a more refined obstruction package
    `ExternalizationObstructionPackage` whose fields characterize
    *which* detector-indexed introduction rule is missing,
  * shows that any obstruction package supplies the introduction
    rule (`introduction_rule_of_obstruction_package`),
  * leaves no `sorry`, no `admit`, no new `axiom`, no new `opaque`.

  Downstream `Vol6.RationalDilationExternalization` consumes this
  module: its principal theorem is parameterised by an
  `ExternalizationIntroductionRule`, and its trivial-detector
  inhabitant uses no obstruction-package data at all.
-/

import Vol5.YonedaNymanTrackA.RKHSDetectorSemantics
import Vol5.YonedaNymanTrackA.CondensedHilbertDefect
import Vol5.YonedaNymanTrackA.NoPhantomBlaschkeDefect
import Vol5.YonedaNymanTrackA.FiniteRankRKHSDetector
import Vol5.YonedaNymanTrackA.YonedaCore

namespace Vol6
namespace Obstruction

open Vol5.YonedaNymanTrackA

/-! ### Externalization introduction rule -/

/--
An `ExternalizationIntroductionRule` for a condensed Hilbert defect `K`, an
RKHS detector `S`, and rational-dilation semantics `R` is the *missing* vol5
lemma supplying inhabitants of
`CondensedHilbertDefectDetectedByRationalDilation K F` only for the Yoneda
presheaves attached to detector indices that actually detect a vector.

Such a rule is precisely what would be needed to close paper 04's
externalization theorem unconditionally.  Its absence in vol5 is the
documented obstruction (vol5 declares the underlying predicate as
`opaque`, with no exposed introduction rule).
-/
structure ExternalizationIntroductionRule
    (K : CondensedHilbertDefect)
    (S : RKHSModelSpaceDetector K)
    (R : RationalDilationObjectSemantics) : Type 1 where
  /-- The rational-dilation parameter attached to a detector index. -/
  parameterOf : S.Detector -> R.Parameter
  /-- The detector-indexed introduction rule itself. -/
  detected_of_detector :
    forall {v : K.object.modelCarrier} {d : S.Detector},
      S.detectsVector v d ->
        CondensedHilbertDefectDetectedByRationalDilation K
          (yoneda (R.objectOf (parameterOf d)))

/-- The introduction rule for a condensed defect supplies the underlying
defect-object detection predicate for the detector-indexed Yoneda presheaf. -/
theorem defect_object_detection_of_introduction_rule
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics}
    (iota : ExternalizationIntroductionRule K S R)
    {v : K.object.modelCarrier} {d : S.Detector}
    (h : S.detectsVector v d) :
    DefectDetectedByRationalDilationRepresentable K.object
      (yoneda (R.objectOf (iota.parameterOf d))) :=
  iota.detected_of_detector h

/-! ### Externalization obstruction package -/

/--
An `ExternalizationObstructionPackage` for a condensed Hilbert defect
`K` is a more refined obstruction record: it exposes the detector-indexed
parameter map plus the corresponding opaque detection rule, and a status string
identifying the package as the documented obstruction.
-/
structure ExternalizationObstructionPackage
    (K : CondensedHilbertDefect)
    (S : RKHSModelSpaceDetector K)
    (R : RationalDilationObjectSemantics) : Type 1 where
  /-- The rational-dilation parameter attached to a detector index. -/
  parameterOf : S.Detector -> R.Parameter
  /-- The detector-indexed opaque detection clause. -/
  detector_detects :
    forall {v : K.object.modelCarrier} {d : S.Detector},
      S.detectsVector v d ->
        CondensedHilbertDefectDetectedByRationalDilation K
          (yoneda (R.objectOf (parameterOf d)))
  /-- An audit-readable status string. -/
  audit_status : String

/-- Any obstruction package supplies the externalization introduction
rule. -/
def introduction_rule_of_obstruction_package
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics}
    (P : ExternalizationObstructionPackage K S R) :
    ExternalizationIntroductionRule K S R where
  parameterOf := P.parameterOf
  detected_of_detector := P.detector_detects

/-- An audit-readable description of the obstruction. -/
def externalization_obstruction_status : String :=
  "Vol6 paper 04 obstruction: vol5 declares DefectDetectedByRationalDilationRepresentable as `opaque` with no exposed detector-indexed introduction rule, characterization, or proof constructor. The principal externalization theorem is therefore parameterized by an explicit ExternalizationIntroductionRule scoped to an RKHS detector and rational-dilation semantics, and the trivial-detector inhabitant uses none of this data."

/-- Machine-checkable status marker. -/
theorem externalization_obstruction_status_eq :
    externalization_obstruction_status =
      "Vol6 paper 04 obstruction: vol5 declares DefectDetectedByRationalDilationRepresentable as `opaque` with no exposed detector-indexed introduction rule, characterization, or proof constructor. The principal externalization theorem is therefore parameterized by an explicit ExternalizationIntroductionRule scoped to an RKHS detector and rational-dilation semantics, and the trivial-detector inhabitant uses none of this data." :=
  rfl

end Obstruction
end Vol6
