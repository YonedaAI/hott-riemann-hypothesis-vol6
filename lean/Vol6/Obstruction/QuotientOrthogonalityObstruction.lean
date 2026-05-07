/-
  Volume VI - Paper 05 - Obstruction: Quotient Orthogonality.

  This module isolates the *exact* missing introduction rule needed to inhabit
  the vol5 structure `QuotientOrthogonalityInvisibility blaschkeDefectObject`
  using nothing more than the cokernel/orthogonal-complement semantics
  permitted by the brief.  No new axiom, opaque, sorry, or admit is introduced.

  Why an obstruction module is necessary.
  ----------------------------------------

  The vol5 surface declares

      opaque DefectDetectedByRationalDilationRepresentable :
          BlaschkeDefectObject -> DQPresheaf -> Prop

  with no introduction or elimination rule.  The structure
  `QuotientOrthogonalityInvisibility K` packages a predicate
  `OrthogonalToRepresentable : DQPresheaf -> Prop` with the field

      no_detection_of_orthogonal :
          forall F, OrthogonalToRepresentable F ->
              not (DefectDetectedByRationalDilationRepresentable K F)

  Composing the two structure fields gives a function
  `forall F, YonedaNymanRepresentableImage F ->
      not (DefectDetectedByRationalDilationRepresentable K F)`,
  which is precisely `DefectInvisibleToNymanYonedaRepresentables K`.  So the
  *only* honest way to inhabit `QuotientOrthogonalityInvisibility K` from
  inside vol6, without supplying a new axiom or an opaque introduction rule,
  is to quotient under an explicit `Yoneda-image-implies-not-detected`
  package that vol6 supplies as data.

  This module records that package as `QuotientOrthogonalityIntroduction` and
  proves that it is *both* sufficient and necessary to construct
  `QuotientOrthogonalityInvisibility blaschkeDefectObject`.  The downstream
  `Vol6.QuotientOrthogonalityAdmissibility` module then accepts the
  introduction package as an explicit parameter (rather than smuggling it in
  via a new axiom).

  The cokernel/orthogonal-complement semantics rule.
  --------------------------------------------------

  Mathematically, the cokernel construction `K_B = H^2 / B H^2` immediately
  implies that any element of `B H^2` (and hence of the Nyman/Yoneda image
  realisation) is annihilated by the projection onto `K_B`, i.e. detection
  by such a representable is impossible.  This is the *cokernel rule* the
  brief permits.  In vol5's purely opaque formalisation of detection, the
  rule cannot be proved internally; it must be supplied as a single named
  introduction package, made explicit here so that auditors can confirm the
  package contains nothing more than the cokernel rule.
-/

import Vol5.YonedaNymanTrackA.NoPhantomBlaschkeDefect
import Vol5.YonedaNymanTrackA.FiniteRankRKHSDetector
import Vol5.YonedaNymanTrackA.BlaschkeDefectObject

namespace Vol6
namespace Obstruction

open Vol5.YonedaNymanTrackA

/-! ### The cokernel introduction package -/

/--
The *minimal* introduction package required to construct
`QuotientOrthogonalityInvisibility K` from cokernel semantics alone.

A single field is required: presheaves in the Nyman/Yoneda image fail to
detect the defect.  This is precisely the cokernel-orthogonality statement
"`B H^2`-realised representables are annihilated by the projection onto
`H^2 / B H^2`", phrased at the vol5 opaque-detection layer.

The package is closed under no-phantom rigidity (proved in vol5 as
`no_phantom_blaschke_defect_rigidity`): the converse direction (detection of
admissible defect implies Yoneda image) is *already* a vol5 theorem, so this
package only needs to express the *forward* direction.
-/
structure QuotientOrthogonalityIntroduction
    (K : BlaschkeDefectObject) : Prop where
  /-- Yoneda/Nyman-image presheaves are not detected by `K`. -/
  yoneda_image_not_detected :
    forall F : DQPresheaf,
      YonedaNymanRepresentableImage F ->
        ¬ DefectDetectedByRationalDilationRepresentable K F

/-! ### Sufficiency: the package builds the full structure -/

/--
The cokernel introduction package is *sufficient* to construct the full
`QuotientOrthogonalityInvisibility K` structure.

Choice of `OrthogonalToRepresentable`: we take it to be exactly
`YonedaNymanRepresentableImage`.  This is the maximally natural choice for
the cokernel reading: a presheaf is "orthogonal to the defect" precisely
when it is in the Nyman/Yoneda image, i.e. realised in the Hardy submodule
`B H^2 = blaschkeHardyImage`.
-/
def quotientOrthogonalityInvisibility_of_intro
    {K : BlaschkeDefectObject}
    (Q : QuotientOrthogonalityIntroduction K) :
    QuotientOrthogonalityInvisibility K where
  OrthogonalToRepresentable F := YonedaNymanRepresentableImage F
  orthogonal_of_yoneda_image := fun _ hF => hF
  no_detection_of_orthogonal := Q.yoneda_image_not_detected

/-! ### Necessity: any inhabitant entails the introduction package -/

/--
Conversely, any inhabitant of `QuotientOrthogonalityInvisibility K` already
supplies the introduction package.  This shows the package is *exactly*
what is needed: not stronger, not weaker than the structure it builds.
-/
theorem intro_of_quotientOrthogonalityInvisibility
    {K : BlaschkeDefectObject}
    (Q : QuotientOrthogonalityInvisibility K) :
    QuotientOrthogonalityIntroduction K where
  yoneda_image_not_detected := by
    intro F hF
    exact Q.no_detection_of_orthogonal F (Q.orthogonal_of_yoneda_image F hF)

/-! ### Equivalence audit -/

/--
The introduction package and the full structure have the same content
(modulo prop-equality of the orthogonal predicate, which is up to the
caller's choice).  This theorem is the obstruction's main *audit* output:
it shows that no information is gained or lost by reducing
`QuotientOrthogonalityInvisibility` to `QuotientOrthogonalityIntroduction`.
-/
theorem quotient_orthogonality_invisibility_iff_introduction
    (K : BlaschkeDefectObject) :
    Nonempty (QuotientOrthogonalityInvisibility K) <->
      QuotientOrthogonalityIntroduction K := by
  constructor
  · rintro ⟨Q⟩
    exact intro_of_quotientOrthogonalityInvisibility Q
  · intro Q
    exact ⟨quotientOrthogonalityInvisibility_of_intro Q⟩

/-! ### Concrete cokernel package for the canonical defect -/

/--
The canonical Burnol/Blaschke instantiation of the introduction package.
This is exactly the data we need supplied (or derived) to discharge
sub-target 2.3 for the canonical defect `blaschkeDefectObject`.
-/
abbrev CanonicalQuotientOrthogonalityIntroduction : Prop :=
  QuotientOrthogonalityIntroduction blaschkeDefectObject

/-- Audit marker for the quotient-orthogonality obstruction. -/
def quotient_orthogonality_obstruction_status : String :=
  "Vol6 paper 05 obstruction: QuotientOrthogonalityInvisibility K is constructively equivalent to QuotientOrthogonalityIntroduction K, the single-field package recording cokernel-orthogonality (Yoneda-image presheaves are not detected). Sufficiency and necessity are both proved here without new axioms."

end Obstruction
end Vol6
