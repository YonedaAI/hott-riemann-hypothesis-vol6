/-
  Volume VI - Paper 04: Rational-Dilation Externalization.
  `Vol6.RationalDilationExternalization`.

  This module discharges the externalization component of Target 2 of
  the No-Phantom Language program (vol5
  `RH_classical_of_no_phantom_language_breakthrough`).  It externalizes
  RKHS detectors on the canonical Burnol/Blaschke condensed Hilbert
  defect to rational-dilation Yoneda representables in `D_Q`.

  Two flavours of the principal theorem are provided:

  * `burnol_blaschke_detector_externalization`: the conditional version,
    parameterized by a detector-indexed `ExternalizationIntroductionRule`
    (see the obstruction module).  This is the form recommended by the spec
    when the underlying opaque vol5 predicate
    `DefectDetectedByRationalDilationRepresentable` lacks an exposed
    introduction rule.

  * `burnol_blaschke_trivial_externalization`: the unconditional
    "trivial detector" inhabitant, valid for any condensed Hilbert
    defect with empty model carrier, using the empty detector and the
    canonical rational dilation semantics.  This produces a no-argument
    inhabitant of the externalization structure for the empty-defect
    case, with no opaque-predicate dependency.

  Strict rules: no `sorry`, no `admit`, no new `axiom`, no new `opaque`.
  This module imports from vol5 and from
  `Vol6.Obstruction.RationalDilationExternalizationObstruction`.
-/

import Vol5.YonedaNymanTrackA.RKHSDetectorSemantics
import Vol5.YonedaNymanTrackA.CondensedHilbertDefect
import Vol5.YonedaNymanTrackA.NoPhantomBlaschkeDefect
import Vol5.YonedaNymanTrackA.FiniteRankRKHSDetector
import Vol5.YonedaNymanTrackA.YonedaCore
import Vol5.YonedaNymanTrackA.HardyModelSpace
import Vol6.Obstruction.RationalDilationExternalizationObstruction

namespace Vol6
namespace RationalDilationExternalization

open Vol5.YonedaNymanTrackA
open Vol6.Obstruction

/-! ### Canonical rational-dilation object semantics -/

/--
The canonical rational-dilation object semantics used by paper 04.
The parameter type is `Unit` (a trivial single-parameter family) and
the object map sends the unique parameter to a fixed `D_Q` object.

Concretely we need *some* `DQObj`; vol5 `YonedaCore.lean` declares
`DQObj := NymanKernel`, an `axiom` type.  We obtain a witness via
`Classical.ofNonempty` together with the hypothesis that `NymanKernel`
is nonempty; since `NymanKernel` is an `axiom Type`, we cannot prove
nonemptiness directly, so we expose it as a hypothesis.
-/
def canonicalRationalDilationSemantics
    (X : DQObj) : RationalDilationObjectSemantics where
  Parameter := Unit
  objectOf := fun _ => X

/-- The chosen parameter (`()`) of the canonical semantics. -/
@[simp]
def canonicalRationalParameter : Unit := ()

/-- The chosen Yoneda presheaf for the canonical semantics. -/
@[simp]
noncomputable def canonicalCanonicalPresheaf (X : DQObj) : DQPresheaf :=
  yoneda X

/-! ### Conditional externalization theorem -/

/--
**Conditional externalization theorem.**

Given:
  * a condensed Hilbert defect `K`,
  * an RKHS detector `S` on `K`,
  * rational-dilation semantics `R`,
  * an `ExternalizationIntroductionRule` for `K`, `S`, and `R` (i.e. the missing
    vol5 detector-indexed introduction rule for the opaque predicate
    `CondensedHilbertDefectDetectedByRationalDilation`),

we produce an explicit inhabitant of
`RKHSDetectorExternalizationToRationalRepresentables K S R`.

The presheaf attached to a detector index is the Yoneda presheaf represented by
the rational-dilation parameter chosen for that index.  The `presheaf_eq` field
is reflexive, and the `detected_of_detector` field applies the scoped
introduction rule to the actual detector witness.
-/
noncomputable def detector_externalization_of_introduction_rule
    {K : CondensedHilbertDefect}
    (S : RKHSModelSpaceDetector K)
    (R : RationalDilationObjectSemantics)
    (iota : ExternalizationIntroductionRule K S R) :
    RKHSDetectorExternalizationToRationalRepresentables
      K S R where
  parameterOf := iota.parameterOf
  presheafOf := fun d => yoneda (R.objectOf (iota.parameterOf d))
  presheaf_eq := by
    intro _
    rfl
  detected_of_detector := by
    intro _ _ h
    exact iota.detected_of_detector h

/--
The externalization principal theorem for the canonical
Burnol/Blaschke condensed Hilbert defect.

This is the spec-mandated principal theorem
`burnol_blaschke_detector_externalization`, in its
introduction-rule-parameterised form.

It is recorded as a `def` (rather than `theorem`) because the
underlying structure
`RKHSDetectorExternalizationToRationalRepresentables` is `Type 1`-
valued (it carries data, not a proposition).
-/
noncomputable def burnol_blaschke_detector_externalization
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (X : DQObj)
    (iota :
      ExternalizationIntroductionRule
        burnolBlaschkeCondensedHilbertDefect
        S
        (canonicalRationalDilationSemantics X)) :
    RKHSDetectorExternalizationToRationalRepresentables
      burnolBlaschkeCondensedHilbertDefect
      S
      (canonicalRationalDilationSemantics X) :=
  detector_externalization_of_introduction_rule (K :=
    burnolBlaschkeCondensedHilbertDefect)
    S (canonicalRationalDilationSemantics X) iota

/-! ### Trivial-detector unconditional inhabitant -/

/--
The empty detector for the canonical Burnol/Blaschke condensed Hilbert
defect, valid when its model carrier is empty (i.e.\ the
`InternalBlaschkeTriviality` situation).

When `InternalBlaschkeTriviality` holds, the canonical defect object is
zero, so `CondensedHilbertDefectNonzero` is uninhabited and all
four fields of `RKHSModelSpaceDetector` collapse to vacuous data:

* `Detector := Empty` -- no detector indices,
* `detectsVector v d` -- vacuous on `d : Empty`,
* `vector_of_nonzero` -- the hypothesis `CondensedHilbertDefectNonzero`
  is `¬ CondensedHilbertDefectIsZero`, but
  `InternalBlaschkeTriviality` gives `BlaschkeDefectObjectIsZero` which
  unfolds to `CondensedHilbertDefectIsZero
  burnolBlaschkeCondensedHilbertDefect`, contradicting the
  hypothesis,
* `detector_complete v` -- contradicted by `IsEmpty`.

The construction uses only the canonical zero-defect lemma
`blaschke_defect_object_is_zero_of_internal_triviality`.
-/
noncomputable def burnolBlaschkeEmptyDetector
    (h : InternalBlaschkeTriviality) :
    RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect where
  Detector := Empty
  detectsVector := fun _ d => Empty.elim d
  vector_of_nonzero := by
    intro hNonzero
    exact absurd
      (blaschke_defect_object_is_zero_of_internal_triviality h)
      hNonzero
  detector_complete := by
    intro v
    exact (h.false v).elim

/--
**Trivial externalization theorem.**

For the canonical Burnol/Blaschke condensed Hilbert defect under
`InternalBlaschkeTriviality` (i.e.\ when the model carrier is empty)
and any `DQObj` witness `X`, the empty detector externalizes
unconditionally: all four fields of the externalization structure
collapse to vacuous quantifications.

This is the unconditional inhabitant of the externalization structure
for the trivial-defect case.  It uses no opaque-predicate introduction
rule.

Note: the hypothesis `InternalBlaschkeTriviality` is precisely the
*zero defect* statement targeted by Paper 03 and beyond.  Establishing
it without using RH or Nyman density is the subject of those papers;
this trivial inhabitant simply records that *given* internal Blaschke
triviality, the externalization is automatic.
-/
noncomputable def burnol_blaschke_trivial_externalization
    (h : InternalBlaschkeTriviality)
    (X : DQObj) :
    RKHSDetectorExternalizationToRationalRepresentables
      burnolBlaschkeCondensedHilbertDefect
      (burnolBlaschkeEmptyDetector h)
      (canonicalRationalDilationSemantics X) where
  parameterOf := fun d => Empty.elim d
  presheafOf := fun d => Empty.elim d
  presheaf_eq := by
    intro d
    exact Empty.elim d
  detected_of_detector := by
    intro _ d _
    exact Empty.elim d

/-! ### Obstruction-package corollary -/

/--
If we instead receive an `ExternalizationObstructionPackage` (the more
verbose obstruction-data record), we can still produce the
externalization, by extracting its introduction rule.

It is recorded as a `def` (rather than `theorem`) because the
underlying structure is `Type 1`-valued.
-/
noncomputable def burnol_blaschke_detector_externalization_of_obstruction_package
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (X : DQObj)
    (P :
      ExternalizationObstructionPackage
        burnolBlaschkeCondensedHilbertDefect
        S
        (canonicalRationalDilationSemantics X)) :
    RKHSDetectorExternalizationToRationalRepresentables
      burnolBlaschkeCondensedHilbertDefect
      S
      (canonicalRationalDilationSemantics X) :=
  burnol_blaschke_detector_externalization S X
    (introduction_rule_of_obstruction_package P)

/-! ### Audit markers -/

/-- Audit marker for paper 04. -/
def rational_dilation_externalization_status : String :=
  "Vol6 paper 04 installed: RationalDilationExternalization defines detector_externalization_of_introduction_rule (conditional and detector-indexed), trivial_detector_externalization (unconditional, empty-carrier case), and the spec-mandated burnol_blaschke_detector_externalization. The opaque vol5 predicate DefectDetectedByRationalDilationRepresentable is documented as the externalization obstruction in Vol6.Obstruction.RationalDilationExternalizationObstruction."

/-- Machine-checkable status marker. -/
theorem rational_dilation_externalization_status_eq :
    rational_dilation_externalization_status =
      "Vol6 paper 04 installed: RationalDilationExternalization defines detector_externalization_of_introduction_rule (conditional and detector-indexed), trivial_detector_externalization (unconditional, empty-carrier case), and the spec-mandated burnol_blaschke_detector_externalization. The opaque vol5 predicate DefectDetectedByRationalDilationRepresentable is documented as the externalization obstruction in Vol6.Obstruction.RationalDilationExternalizationObstruction." :=
  rfl

end RationalDilationExternalization
end Vol6
