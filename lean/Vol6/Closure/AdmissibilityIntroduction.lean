/-
  Volume VI - Closure: Canonical admissibility introduction.

  This module records the Vol6-only closure status for the exact canonical
  field

      CanonicalAdmissibilityIntroduction

  without adding any additional proof primitive or placeholder.  The Vol5
  predicates `BlaschkeDefectDualizable`, `BlaschkeDefectPolarized`, and
  `BlaschkeDefectRegularized` are opaque atoms, so the canonical introduction
  package cannot be inhabited from the current Vol6-only surface.  The honest
  closure artifact is the characterization below: the canonical field is
  exactly those three atoms for `blaschkeDefectObject`, and equivalently the
  existing Vol5 admissibility wrappers.
-/

import Vol6.Obstruction.AdmissibilityObstruction

namespace Vol6
namespace Closure

open Vol5.YonedaNymanTrackA

/-! ### Canonical target and atoms -/

/-- Local closure alias for the admissibility introduction package. -/
abbrev AdmissibilityIntroduction (K : BlaschkeDefectObject) : Prop :=
  Vol6.Obstruction.AdmissibilityIntroduction K

/-- The dualizable opaque atom for the canonical Burnol/Blaschke defect. -/
abbrev CanonicalDualizableAtom : Prop :=
  BlaschkeDefectDualizable blaschkeDefectObject

/-- The polarized opaque atom for the canonical Burnol/Blaschke defect. -/
abbrev CanonicalPolarizedAtom : Prop :=
  BlaschkeDefectPolarized blaschkeDefectObject

/-- The regularized opaque atom for the canonical Burnol/Blaschke defect. -/
abbrev CanonicalRegularizedAtom : Prop :=
  BlaschkeDefectRegularized blaschkeDefectObject

/--
The exact canonical field requested by the closure roadmap.

It is an abbreviation for `AdmissibilityIntroduction blaschkeDefectObject`,
not a constructed inhabitant.
-/
abbrev CanonicalAdmissibilityIntroduction : Prop :=
  AdmissibilityIntroduction blaschkeDefectObject

/-! ### Projections from the canonical field -/

/-- The canonical introduction package exposes precisely the dualizable atom. -/
theorem canonical_dualizable_atom_of_introduction
    (A : CanonicalAdmissibilityIntroduction) :
    CanonicalDualizableAtom :=
  A.dualizable_of_finite_rank

/-- The canonical introduction package exposes precisely the polarized atom. -/
theorem canonical_polarized_atom_of_introduction
    (A : CanonicalAdmissibilityIntroduction) :
    CanonicalPolarizedAtom :=
  A.polarized_of_finite_rank

/-- The canonical introduction package exposes precisely the regularized atom. -/
theorem canonical_regularized_atom_of_introduction
    (A : CanonicalAdmissibilityIntroduction) :
    CanonicalRegularizedAtom :=
  A.regularized_of_finite_rank

/-! ### Characterization by the three opaque atoms -/

/-- The three canonical opaque atoms packaged as a conjunction. -/
abbrev CanonicalAdmissibilityAtoms : Prop :=
  CanonicalDualizableAtom /\ CanonicalPolarizedAtom /\ CanonicalRegularizedAtom

/-- The three canonical atoms are sufficient to build the introduction package. -/
theorem canonical_admissibility_introduction_of_atoms
    (h : CanonicalAdmissibilityAtoms) :
    CanonicalAdmissibilityIntroduction where
  dualizable_of_finite_rank := h.1
  polarized_of_finite_rank := h.2.1
  regularized_of_finite_rank := h.2.2

/--
No-go/characterization theorem: the canonical introduction field is exactly
the three opaque Vol5 atoms for `blaschkeDefectObject`.
-/
theorem canonical_admissibility_introduction_iff_atoms :
    CanonicalAdmissibilityIntroduction <-> CanonicalAdmissibilityAtoms := by
  constructor
  · intro A
    exact
      ⟨canonical_dualizable_atom_of_introduction A,
        canonical_polarized_atom_of_introduction A,
        canonical_regularized_atom_of_introduction A⟩
  · intro h
    exact canonical_admissibility_introduction_of_atoms h

/-! ### Equivalence with Vol5 admissibility wrappers -/

/--
The canonical introduction package is equivalent to Vol5's
`BlaschkeDefectAdmissible` wrapper for the canonical defect object.
-/
theorem canonical_admissibility_introduction_iff_blaschke_defect_admissible :
    CanonicalAdmissibilityIntroduction <->
      BlaschkeDefectAdmissible blaschkeDefectObject :=
  Vol6.Obstruction.admissibility_intro_iff blaschkeDefectObject

/--
The canonical introduction package is equivalent to the condensed
Burnol/Blaschke admissibility target.
-/
theorem canonical_admissibility_introduction_iff_burnol_blaschke_defect_is_admissible :
    CanonicalAdmissibilityIntroduction <->
      BurnolBlaschkeDefectIsAdmissible := by
  constructor
  · intro A
    exact Vol6.Obstruction.canonical_burnol_blaschke_admissible_of_intro A
  · intro h
    exact
      Vol6.Obstruction.intro_of_blaschkeDefectAdmissible
        (blaschke_defect_admissible_of_condensed h)

/--
Reverse-oriented form for downstream code that states the existing Vol5
condensed target first.
-/
theorem burnol_blaschke_defect_is_admissible_iff_canonical_admissibility_introduction :
    BurnolBlaschkeDefectIsAdmissible <->
      CanonicalAdmissibilityIntroduction :=
  Iff.symm
    canonical_admissibility_introduction_iff_burnol_blaschke_defect_is_admissible

/-! ### Audit marker -/

/-- Closure audit marker for the canonical admissibility introduction field. -/
def canonical_admissibility_introduction_status : String :=
  "Vol6 closure status for CanonicalAdmissibilityIntroduction: the field is definitionally AdmissibilityIntroduction blaschkeDefectObject and is constructively equivalent to exactly the three opaque Vol5 atoms BlaschkeDefectDualizable, BlaschkeDefectPolarized, and BlaschkeDefectRegularized at blaschkeDefectObject, hence also equivalent to BlaschkeDefectAdmissible blaschkeDefectObject and BurnolBlaschkeDefectIsAdmissible. Finite-rank model-space motivation explains why these atoms are mathematically expected, but it is not a proof of the opaque atoms from the current Vol6-only surface."

end Closure
end Vol6
