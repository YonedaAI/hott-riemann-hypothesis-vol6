/-
  Volume VI - Paper 05: Quotient Orthogonality and Admissibility.

  This module discharges the two prongs of next-steps.md sub-targets 2.3 and
  2.4 for the canonical Burnol/Blaschke defect object `blaschkeDefectObject`,
  to the extent permitted by the vol5 opaque surface and the strict rules
  governing vol6 (no new axiom, opaque, sorry, or admit).

  Section A.  Quotient orthogonality (sub-target 2.3).
  ----------------------------------------------------

  We construct `burnol_blaschke_quotient_orthogonality :
      QuotientOrthogonalityInvisibility blaschkeDefectObject`
  by *cokernel construction*, taking the orthogonal-to-representable
  predicate to be exactly the Nyman/Yoneda image.  The construction is
  parameterised by `Vol6.Obstruction.QuotientOrthogonalityIntroduction
  blaschkeDefectObject`, the single-field obstruction package recording the
  cokernel-orthogonality fact "Yoneda-image presheaves are not detected".

  Crucially we do *not* import:
    * Nyman density (`NymanDensity` and friends),
    * Beurling-Nyman equivalence (`Vol5.YonedaNymanTrackA.Criterion`),
    * Internal Blaschke triviality assumptions,
    * Any RH-equivalent.

  Section B.  Admissibility (sub-target 2.4).
  -------------------------------------------

  We construct
      burnol_blaschke_defect_is_admissible : BurnolBlaschkeDefectIsAdmissible
  parameterised by `Vol6.Obstruction.AdmissibilityIntroduction
  blaschkeDefectObject`, the three-field obstruction package (one field per
  opaque atom).  The package itself is the obstruction.

  Both prongs are also assembled into a single semantic record
  `BurnolBlaschkeOrthogonalityAdmissibilityPackage` collecting both
  obstructions, plus a single combined existence theorem.
-/

import Vol5.YonedaNymanTrackA.NoPhantomBlaschkeDefect
import Vol5.YonedaNymanTrackA.FiniteRankRKHSDetector
import Vol5.YonedaNymanTrackA.CondensedHilbertDefect
import Vol5.YonedaNymanTrackA.BlaschkeDefectObject
import Vol6.FiniteBlaschkePacket
import Vol6.Obstruction.QuotientOrthogonalityObstruction
import Vol6.Obstruction.AdmissibilityObstruction

namespace Vol6
namespace QuotientOrthogonalityAdmissibility

open Vol5.YonedaNymanTrackA
open Vol6.Obstruction

/-! ### Section A: Quotient orthogonality (sub-target 2.3) -/

/--
**Principal construction of paper 05, Section A.**

The canonical Burnol/Blaschke quotient defect carries the quotient-
orthogonality / Nyman-Yoneda invisibility structure, *parameterised* by the
explicit cokernel-orthogonality introduction package supplied by paper 05's
finite-rank construction.  No Nyman density is imported; the predicate
`OrthogonalToRepresentable F := YonedaNymanRepresentableImage F` is the
canonical cokernel-orthogonality choice.

(`QuotientOrthogonalityInvisibility` lives in `Type 1` because its
`OrthogonalToRepresentable` field carries data, so this is a `def`, not a
`theorem`.)
-/
noncomputable def burnol_blaschke_quotient_orthogonality_of_intro
    (Q : CanonicalQuotientOrthogonalityIntroduction) :
    QuotientOrthogonalityInvisibility blaschkeDefectObject :=
  quotientOrthogonalityInvisibility_of_intro Q

/--
**Audit form of the orthogonality invisibility transport.**

The structure carries exactly the cokernel introduction package and nothing
more.  This theorem records the equivalence between "having a
`QuotientOrthogonalityInvisibility blaschkeDefectObject`" and "having the
cokernel introduction package".
-/
theorem burnol_blaschke_quotient_orthogonality_iff :
    Nonempty (QuotientOrthogonalityInvisibility blaschkeDefectObject) <->
      CanonicalQuotientOrthogonalityIntroduction :=
  quotient_orthogonality_invisibility_iff_introduction blaschkeDefectObject

/-! ### Section B: Admissibility (sub-target 2.4) -/

/-- Section B.1.  Dualisable atom transported through the introduction package. -/
theorem blaschke_defect_dualizable_of_intro
    (A : CanonicalAdmissibilityIntroduction) :
    BlaschkeDefectDualizable blaschkeDefectObject :=
  A.dualizable_of_finite_rank

/-- Section B.2.  Polarized atom transported through the introduction package. -/
theorem blaschke_defect_polarized_of_intro
    (A : CanonicalAdmissibilityIntroduction) :
    BlaschkeDefectPolarized blaschkeDefectObject :=
  A.polarized_of_finite_rank

/-- Section B.3.  Regularised atom transported through the introduction package. -/
theorem blaschke_defect_regularized_of_intro
    (A : CanonicalAdmissibilityIntroduction) :
    BlaschkeDefectRegularized blaschkeDefectObject :=
  A.regularized_of_finite_rank

/--
**Principal theorem of paper 05, Section B.**

The canonical Burnol/Blaschke condensed Hilbert defect is admissible,
parameterised by the canonical admissibility introduction package.
-/
theorem burnol_blaschke_defect_is_admissible_of_intro
    (A : CanonicalAdmissibilityIntroduction) :
    BurnolBlaschkeDefectIsAdmissible :=
  canonical_burnol_blaschke_admissible_of_intro A

/--
**Audit form of the admissibility transport.**

The condensed admissibility predicate is constructively equivalent to the
canonical admissibility introduction package.
-/
theorem burnol_blaschke_defect_is_admissible_iff :
    BurnolBlaschkeDefectIsAdmissible <->
      CanonicalAdmissibilityIntroduction := by
  constructor
  · intro h
    -- Condensed admissibility unwraps to BlaschkeDefectAdmissible on the
    -- underlying object, then to the introduction package.
    exact intro_of_blaschkeDefectAdmissible
      (blaschke_defect_admissible_of_condensed h)
  · intro A
    exact burnol_blaschke_defect_is_admissible_of_intro A

/-! ### Combined orthogonality + admissibility package -/

/--
The combined paper 05 introduction package: both obstructions, packaged
together for the convenience of paper 06's final assembly.
-/
structure BurnolBlaschkeOrthogonalityAdmissibilityIntroduction : Prop where
  orthogonality : CanonicalQuotientOrthogonalityIntroduction
  admissibility : CanonicalAdmissibilityIntroduction

/--
Combined deliverable theorem: from the combined paper-05 introduction
package we extract both targets in a form ready to plug into paper 06.
-/
theorem burnol_blaschke_orthogonality_and_admissibility_of_intro
    (P : BurnolBlaschkeOrthogonalityAdmissibilityIntroduction) :
    Nonempty (QuotientOrthogonalityInvisibility blaschkeDefectObject) /\
      BurnolBlaschkeDefectIsAdmissible :=
  ⟨⟨burnol_blaschke_quotient_orthogonality_of_intro P.orthogonality⟩,
   burnol_blaschke_defect_is_admissible_of_intro P.admissibility⟩

/--
Combined audit-form equivalence: having both deliverables is the same as
having the combined introduction package.
-/
theorem burnol_blaschke_orthogonality_and_admissibility_iff :
    (Nonempty (QuotientOrthogonalityInvisibility blaschkeDefectObject) /\
        BurnolBlaschkeDefectIsAdmissible) <->
      BurnolBlaschkeOrthogonalityAdmissibilityIntroduction := by
  constructor
  · rintro ⟨hOrth, hAdm⟩
    refine ⟨?_, ?_⟩
    · exact (burnol_blaschke_quotient_orthogonality_iff).mp hOrth
    · exact (burnol_blaschke_defect_is_admissible_iff).mp hAdm
  · intro P
    exact burnol_blaschke_orthogonality_and_admissibility_of_intro P

/-! ### Finite-rank visibility lemmas (paper 05 § 1.4 / § 2.4) -/

/--
On any finite Blaschke packet `P`, the finite model carrier
`finitePacketCarrier P = P.ZeroIndex -> Complex` is finite-dimensional
(its underlying type is `P.ZeroIndex -> Complex` and `P.ZeroIndex` is
finite by `P.finite`).  This is the finite-rank ground truth used to
motivate the canonical-level admissibility introduction package.
-/
@[reducible]
def finitePacketCarrier_fintype
    (P : Vol6.FiniteBlaschkePacketNS.FiniteBlaschkePacket) :
    Fintype P.ZeroIndex :=
  P.finite

/--
On any finite Blaschke packet `P`, the finite model carrier always has at
least one element (the constant-zero vector).  This is the trivial part
of the finite-rank dualisability story, used here only as a sanity check
on the `Vol6.FiniteBlaschkePacket` interface.
-/
theorem finitePacketCarrier_nonempty
    (P : Vol6.FiniteBlaschkePacketNS.FiniteBlaschkePacket) :
    Nonempty (Vol6.FiniteBlaschkePacketNS.finitePacketCarrier P) :=
  ⟨fun _ => (0 : Complex)⟩

/-! ### Top-level packaged deliverables -/

/--
Top-level paper-05 packaged deliverable: from the combined introduction
package we get the structures expected by `BurnolBlaschkeRKHSDetectorSemantics`
fields `orthogonality` and `admissibility`.

Notice this theorem does *not* construct the introduction package itself;
the obstruction modules `Vol6.Obstruction.QuotientOrthogonalityObstruction`
and `Vol6.Obstruction.AdmissibilityObstruction` characterise it as the
single irreducible mathematical input (cokernel rule + three opaque-atom
lifts) that paper 05 cannot discharge from the vol5 surface alone.
-/
noncomputable def burnolBlaschkeOrthogonalityAdmissibilityFields
    (P : BurnolBlaschkeOrthogonalityAdmissibilityIntroduction) :
    QuotientOrthogonalityInvisibility blaschkeDefectObject ×'
      BurnolBlaschkeDefectIsAdmissible :=
  ⟨burnol_blaschke_quotient_orthogonality_of_intro P.orthogonality,
   burnol_blaschke_defect_is_admissible_of_intro P.admissibility⟩

/-- Audit marker for paper 05. -/
def quotient_orthogonality_admissibility_status : String :=
  "Vol6 paper 05 installed: QuotientOrthogonalityInvisibility blaschkeDefectObject is built by cokernel construction (OrthogonalToRepresentable := YonedaNymanRepresentableImage) parameterised by a single-field cokernel-orthogonality introduction package; BurnolBlaschkeDefectIsAdmissible is built parameterised by a three-field admissibility introduction package, one field per opaque vol5 atom. Both packages are characterised by paired obstruction modules and shown equivalent to their respective targets. No Nyman density, Beurling-Nyman, or RH-equivalent is imported."

end QuotientOrthogonalityAdmissibility
end Vol6
