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
  *honest* (non-vacuous) detector S is to receive an introduction rule
  for that opaque predicate as data.

  This module:

  * states the externalization-introduction-rule data as a
    transparent vol6 structure
    `ExternalizationIntroductionRule`,
  * states a more refined obstruction package
    `ExternalizationObstructionPackage` whose fields characterize
    *which* introduction rule is missing,
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
An `ExternalizationIntroductionRule` for a condensed Hilbert defect
`K` is the *missing* vol5 lemma supplying inhabitants of
`CondensedHilbertDefectDetectedByRationalDilation K F` from a witness
that `F` is a `D_Q` Yoneda representable.

Such a rule is precisely what would be needed to close paper 04's
externalization theorem unconditionally.  Its absence in vol5 is the
documented obstruction (vol5 declares the underlying predicate as
`opaque`, with no exposed introduction rule).
-/
structure ExternalizationIntroductionRule
    (K : CondensedHilbertDefect) : Type 1 where
  /-- The introduction rule itself: any rational-dilation
  representable presheaf detects the defect. -/
  intro :
    forall F : DQPresheaf,
      RationalDilationRepresentable F ->
        CondensedHilbertDefectDetectedByRationalDilation K F

/-- The introduction rule for a condensed defect supplies the
underlying defect-object introduction rule. -/
theorem defect_object_introduction_of_condensed
    {K : CondensedHilbertDefect}
    (iota : ExternalizationIntroductionRule K) :
    forall F : DQPresheaf,
      RationalDilationRepresentable F ->
        DefectDetectedByRationalDilationRepresentable K.object F := by
  intro F hRep
  exact iota.intro F hRep

/-! ### Externalization obstruction package -/

/--
An `ExternalizationObstructionPackage` for a condensed Hilbert defect
`K` is a more refined obstruction record: it exposes both the
introduction rule for *Yoneda representables* and a separate clause
for the more general *Yoneda Nyman representables* image, and a status
string identifying the package as the documented obstruction.
-/
structure ExternalizationObstructionPackage
    (K : CondensedHilbertDefect) : Type 1 where
  /-- The Yoneda-representable detection clause. -/
  representable_detects :
    forall F : DQPresheaf,
      RationalDilationRepresentable F ->
        CondensedHilbertDefectDetectedByRationalDilation K F
  /-- The Nyman-representable detection clause (a special case of
  Yoneda-representable detection, exposed for downstream readability). -/
  nyman_representable_detects :
    forall F : DQPresheaf,
      YonedaNymanRepresentableImage F ->
        CondensedHilbertDefectDetectedByRationalDilation K F
  /-- An audit-readable status string. -/
  audit_status : String

/-- Any obstruction package supplies the externalization introduction
rule. -/
def introduction_rule_of_obstruction_package
    {K : CondensedHilbertDefect}
    (P : ExternalizationObstructionPackage K) :
    ExternalizationIntroductionRule K where
  intro := P.representable_detects

/-- The Nyman-representable clause is recoverable from the
representable clause, since every Nyman representable is a Yoneda
representable. -/
theorem nyman_representable_detects_of_representable_detects
    {K : CondensedHilbertDefect}
    (h :
      forall F : DQPresheaf,
        RationalDilationRepresentable F ->
          CondensedHilbertDefectDetectedByRationalDilation K F) :
    forall F : DQPresheaf,
      YonedaNymanRepresentableImage F ->
        CondensedHilbertDefectDetectedByRationalDilation K F := by
  intro F hF
  exact h F (rational_dilation_representable_of_yoneda_nyman_image hF)

/-- An audit-readable description of the obstruction. -/
def externalization_obstruction_status : String :=
  "Vol6 paper 04 obstruction: vol5 declares DefectDetectedByRationalDilationRepresentable as `opaque` with no exposed introduction rule, characterization, or proof constructor. The principal externalization theorem is therefore parameterized by an explicit ExternalizationIntroductionRule, and the trivial-detector inhabitant uses none of this data."

/-- Machine-checkable status marker. -/
theorem externalization_obstruction_status_eq :
    externalization_obstruction_status =
      "Vol6 paper 04 obstruction: vol5 declares DefectDetectedByRationalDilationRepresentable as `opaque` with no exposed introduction rule, characterization, or proof constructor. The principal externalization theorem is therefore parameterized by an explicit ExternalizationIntroductionRule, and the trivial-detector inhabitant uses none of this data." :=
  rfl

end Obstruction
end Vol6
