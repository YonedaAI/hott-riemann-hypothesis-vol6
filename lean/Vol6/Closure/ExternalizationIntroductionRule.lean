/-
  Volume VI closure artifact:
  `Vol6.Closure.ExternalizationIntroductionRule`.

  This module isolates the exact Paper 04 closure condition for the field
  `Vol6.Obstruction.ExternalizationIntroductionRule`.

  The condition is deliberately detector-indexed.  It does not assert that
  every rational-dilation representable detects a defect; it only packages the
  parameter map and detection clause for detector witnesses that actually occur
  in the chosen RKHS detector.
-/

import Vol6.RationalDilationExternalization

namespace Vol6
namespace Closure
namespace ExternalizationIntroductionRule

open Vol5.YonedaNymanTrackA
open Vol6.Obstruction

/-! ## Detector-indexed closure condition -/

/--
The transparent detector-indexed detection rule needed to close the Paper 04
externalization field.

For each detector index it chooses a rational-dilation parameter, then proves
the Vol5 detection predicate only for Yoneda presheaves attached to detector
witnesses of actual vectors.
-/
structure DetectorIndexedDetectionRule
    (K : CondensedHilbertDefect)
    (S : RKHSModelSpaceDetector K)
    (R : RationalDilationObjectSemantics) : Type 1 where
  /-- The rational-dilation parameter attached to a detector index. -/
  parameterOf : S.Detector -> R.Parameter
  /-- The required detector-indexed detection theorem. -/
  detected_of_detector :
    forall {v : K.object.modelCarrier} {d : S.Detector},
      S.detectsVector v d ->
        CondensedHilbertDefectDetectedByRationalDilation K
          (yoneda (R.objectOf (parameterOf d)))

/--
The proposition that the exact detector-indexed closure condition is available.
-/
abbrev DetectorIndexedDetectionTheorem
    (K : CondensedHilbertDefect)
    (S : RKHSModelSpaceDetector K)
    (R : RationalDilationObjectSemantics) : Prop :=
  Nonempty (DetectorIndexedDetectionRule K S R)

/--
Convert the closure characterization into the obstruction-module field.
-/
def externalizationIntroductionRule_of_detectorIndexedDetectionRule
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics}
    (rule : DetectorIndexedDetectionRule K S R) :
    Vol6.Obstruction.ExternalizationIntroductionRule K S R where
  parameterOf := rule.parameterOf
  detected_of_detector := rule.detected_of_detector

/--
Convert the obstruction-module field back into the transparent closure
characterization.
-/
def detectorIndexedDetectionRule_of_externalizationIntroductionRule
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics}
    (iota : Vol6.Obstruction.ExternalizationIntroductionRule K S R) :
    DetectorIndexedDetectionRule K S R where
  parameterOf := iota.parameterOf
  detected_of_detector := iota.detected_of_detector

/--
The transparent closure theorem is equivalent to inhabiting the exact
`Vol6.Obstruction.ExternalizationIntroductionRule` field.
-/
theorem detectorIndexedDetectionTheorem_iff_nonempty_externalizationIntroductionRule
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics} :
    DetectorIndexedDetectionTheorem K S R <->
      Nonempty (Vol6.Obstruction.ExternalizationIntroductionRule K S R) := by
  constructor
  · rintro ⟨rule⟩
    exact ⟨externalizationIntroductionRule_of_detectorIndexedDetectionRule rule⟩
  · rintro ⟨iota⟩
    exact ⟨detectorIndexedDetectionRule_of_externalizationIntroductionRule iota⟩

/-! ## Honest vacuous inhabitant for empty detector index types -/

/--
If the chosen detector has no detector indices, the detector-indexed closure
condition is vacuous and therefore inhabited.
-/
def detectorIndexedDetectionRule_of_isEmptyDetector
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics}
    [IsEmpty S.Detector] :
    DetectorIndexedDetectionRule K S R where
  parameterOf := fun d => (IsEmpty.false d).elim
  detected_of_detector := by
    intro _ d _
    exact (IsEmpty.false d).elim

/--
The corresponding exact `ExternalizationIntroductionRule` inhabitant for an
empty detector index type.
-/
def externalizationIntroductionRule_of_isEmptyDetector
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics}
    [IsEmpty S.Detector] :
    Vol6.Obstruction.ExternalizationIntroductionRule K S R :=
  externalizationIntroductionRule_of_detectorIndexedDetectionRule
    (detectorIndexedDetectionRule_of_isEmptyDetector (K := K) (S := S) (R := R))

/-! ## Burnol/Blaschke canonical specialization -/

/--
Detector-indexed closure condition for the canonical Burnol/Blaschke defect,
a scoped detector `S`, and the canonical rational-dilation semantics at `X`.
-/
abbrev BurnolBlaschkeCanonicalDetectorIndexedDetectionRule
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (X : DQObj) : Type 1 :=
  DetectorIndexedDetectionRule
    burnolBlaschkeCondensedHilbertDefect
    S
    (Vol6.RationalDilationExternalization.canonicalRationalDilationSemantics X)

/--
The exact canonical Paper 04 theorem that remains to be supplied for a scoped
detector `S` and rational-dilation object `X`.
-/
abbrev BurnolBlaschkeCanonicalDetectorIndexedDetectionTheorem
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (X : DQObj) : Prop :=
  Nonempty (BurnolBlaschkeCanonicalDetectorIndexedDetectionRule S X)

/--
Canonical specialization of the obstruction-module field.
-/
abbrev BurnolBlaschkeCanonicalExternalizationIntroductionRule
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (X : DQObj) : Type 1 :=
  Vol6.Obstruction.ExternalizationIntroductionRule
    burnolBlaschkeCondensedHilbertDefect
    S
    (Vol6.RationalDilationExternalization.canonicalRationalDilationSemantics X)

/--
The Burnol/Blaschke canonical closure theorem is exactly nonemptiness of the
target `ExternalizationIntroductionRule` field.
-/
theorem burnolBlaschkeCanonicalDetectorIndexedDetectionTheorem_iff
    {S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect}
    {X : DQObj} :
    BurnolBlaschkeCanonicalDetectorIndexedDetectionTheorem S X <->
      Nonempty (BurnolBlaschkeCanonicalExternalizationIntroductionRule S X) :=
  detectorIndexedDetectionTheorem_iff_nonempty_externalizationIntroductionRule
    (K := burnolBlaschkeCondensedHilbertDefect)
    (S := S)
    (R :=
      Vol6.RationalDilationExternalization.canonicalRationalDilationSemantics X)

/--
Under internal Blaschke triviality, the existing empty detector gives a real
vacuous inhabitant of the canonical detector-indexed closure condition.
-/
noncomputable def burnolBlaschkeEmptyDetectorIndexedDetectionRule
    (h : InternalBlaschkeTriviality)
    (X : DQObj) :
    BurnolBlaschkeCanonicalDetectorIndexedDetectionRule
      (Vol6.RationalDilationExternalization.burnolBlaschkeEmptyDetector h)
      X where
  parameterOf := fun d => Empty.elim d
  detected_of_detector := by
    intro _ d _
    exact Empty.elim d

/--
The same vacuous inhabitant, packaged as the exact obstruction-module field.
-/
noncomputable def burnolBlaschkeEmptyDetectorExternalizationIntroductionRule
    (h : InternalBlaschkeTriviality)
    (X : DQObj) :
    BurnolBlaschkeCanonicalExternalizationIntroductionRule
      (Vol6.RationalDilationExternalization.burnolBlaschkeEmptyDetector h)
      X :=
  externalizationIntroductionRule_of_detectorIndexedDetectionRule
    (burnolBlaschkeEmptyDetectorIndexedDetectionRule h X)

/-! ## Audit marker -/

/--
Audit-readable status for the remaining non-vacuous closure theorem.
-/
def externalizationIntroductionRuleClosureStatus : String :=
  "Vol6 closure status for ExternalizationIntroductionRule: the exact remaining theorem is a detector-indexed parameter map plus detection clause for burnolBlaschkeCondensedHilbertDefect, a scoped RKHSModelSpaceDetector S, and canonicalRationalDilationSemantics X; this module proves equivalence with Nonempty ExternalizationIntroductionRule and constructs only the vacuous empty-detector inhabitant, not a global all-representables detection rule."

/-- Machine-checkable audit marker. -/
theorem externalizationIntroductionRuleClosureStatus_eq :
    externalizationIntroductionRuleClosureStatus =
      "Vol6 closure status for ExternalizationIntroductionRule: the exact remaining theorem is a detector-indexed parameter map plus detection clause for burnolBlaschkeCondensedHilbertDefect, a scoped RKHSModelSpaceDetector S, and canonicalRationalDilationSemantics X; this module proves equivalence with Nonempty ExternalizationIntroductionRule and constructs only the vacuous empty-detector inhabitant, not a global all-representables detection rule." :=
  rfl

end ExternalizationIntroductionRule
end Closure
end Vol6
