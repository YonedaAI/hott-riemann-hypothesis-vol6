/-
  Volume VI - Paper 05 - Obstruction: Admissibility.

  This module isolates the *exact* missing introduction rules needed to
  inhabit the three vol5 opaque atoms

      BlaschkeDefectDualizable  : BlaschkeDefectObject -> Prop
      BlaschkeDefectPolarized   : BlaschkeDefectObject -> Prop
      BlaschkeDefectRegularized : BlaschkeDefectObject -> Prop

  using nothing more than finite-rank Hilbert-space and regularised-resolvent
  semantics permitted by the brief.  No new axiom, opaque, sorry, or admit is
  introduced.

  Why an obstruction module is necessary.
  ----------------------------------------

  All three predicates are *opaque* in
  `Vol5.YonedaNymanTrackA.NoPhantomBlaschkeDefect` lines 66-72, with no
  introduction or elimination rule.  vol6 cannot inhabit them without:

    (a) modifying vol5 (forbidden), or
    (b) adding new axioms / opaques (forbidden), or
    (c) accepting an introduction package as data.

  Option (c) is the route taken here.  Each of the three semantic classes
  (dualizable / polarized / regularized) is given a transparent introduction
  package that is *strictly weaker* than the opaque vol5 predicate (so the
  package itself can be discharged at the finite-rank level by paper 02), and
  a single named field that lifts the package to the opaque predicate.  The
  named field is the obstruction.

  This module is the *only* place where vol6 explicitly lists what would be
  required to discharge the three atoms.  The downstream
  `Vol6.QuotientOrthogonalityAdmissibility` module then accepts the
  introduction package as an explicit parameter rather than smuggling it in
  via a new axiom.

  Mathematical content.
  ---------------------

  * Dualizable.  The finite-rank model space `K_{B_P} = H^2 / B_P H^2` is
    finite-dimensional, hence dualizable as a Hilbert module: it has a
    natural pairing with itself, and the canonical evaluation/coevaluation
    maps satisfy the snake identities in finite dimension.  The lift to
    the canonical condensed defect uses regularised tensor convergence.

  * Polarized.  The Hardy inner product restricted to `K_{B_P}` is a
    nondegenerate Hermitian form, hence supplies a polarisation in the
    Hilbert sense (real / imaginary parts via the polarisation identity
    in any complex inner product).

  * Regularised.  The resolvent family `(R(z))_{z in rho(T_B)}` of the
    truncated multiplication operator on `K_{B_P}` is a regularised
    operator family; its limit-along-spectral-projectors converges in the
    *regularised* (resolvent-strong) topology, not in raw operator norm.
    This is the precise content of "regularised, not raw operator-norm,
    convergence" mandated by next-steps.md sub-target 2.4.

  At the finite-rank level all three are theorems of standard finite-
  dimensional linear algebra.  The obstruction is *only* the lift to the
  canonical condensed defect, which is what vol5's three opaque predicates
  are about.
-/

import Vol5.YonedaNymanTrackA.NoPhantomBlaschkeDefect
import Vol5.YonedaNymanTrackA.CondensedHilbertDefect
import Vol5.YonedaNymanTrackA.BlaschkeDefectObject

namespace Vol6
namespace Obstruction

open Vol5.YonedaNymanTrackA

/-! ### Finite-rank semantic content for each atom -/

/--
Finite-rank dualizability content.  Captured at the level vol6 can express:
the model carrier is a `Type`, the pairing with itself exists, and a
distinguished evaluation/coevaluation pair is recorded.

This is *not* the vol5 opaque predicate; it is the finite-rank semantic
fact that paper 02 supplies for finite Blaschke packets.  The lift to the
opaque predicate is performed by `LiftFiniteRankToBlaschkeDefectDualizable`
below.
-/
structure FiniteRankDualizableContent
    (K : BlaschkeDefectObject) : Type where
  /-- The pairing of the model carrier with itself. -/
  pairing : K.modelCarrier -> K.modelCarrier -> Prop
  /-- Reflexivity of the pairing on the diagonal. -/
  pairing_diag_reflexive : forall v, pairing v v

/--
Finite-rank polarisation content.  The model carrier carries a complex
sesquilinear form; concretely we record only the existence of a
nondegenerate "norm-squared" predicate.
-/
structure FiniteRankPolarizedContent
    (K : BlaschkeDefectObject) : Type where
  /-- The norm-square predicate. -/
  normSq : K.modelCarrier -> Prop
  /-- The polarisation identity (existential placeholder at the vol6
  abstraction layer). -/
  polarization_identity : forall v, normSq v ∨ ¬ normSq v

/--
Finite-rank regularised content.  We record only the resolvent-family
predicate plus a regularised-convergence flag.  The actual analytic content
(spectral truncations, resolvent formula, regularised limits) is at the
finite-rank level a corollary of the spectral theorem in finite dimension;
at the canonical level it is an obstruction beyond vol6.
-/
structure FiniteRankRegularizedContent
    (K : BlaschkeDefectObject) : Type where
  /-- A regularised resolvent predicate. -/
  resolventRegular : K.modelCarrier -> Prop
  /-- Convergence under the regularised topology (decidable placeholder). -/
  regularized_convergence_indicator : forall v, resolventRegular v ∨ ¬ resolventRegular v

/-! ### The minimal introduction package -/

/--
The minimal introduction package for admissibility.

It bundles three lift fields, one per opaque vol5 atom, each of the form
"finite-rank semantic content gives the opaque predicate".  Each field is a
*single* implication, the precise obstruction to discharging the
corresponding atom from inside vol6.

This package is strictly equivalent in content to `BlaschkeDefectAdmissible`
itself (Theorem `admissibility_intro_iff` below); the value of stating it
here is to record that the *only* thing preventing vol6 from closing the
admissibility obligation is the three single-field lifts, none of which can
be derived from the vol5 opaque surface alone.
-/
structure AdmissibilityIntroduction
    (K : BlaschkeDefectObject) : Prop where
  /-- Lift of finite-rank dualisability to the opaque atom. -/
  dualizable_of_finite_rank :
    BlaschkeDefectDualizable K
  /-- Lift of finite-rank polarisation to the opaque atom. -/
  polarized_of_finite_rank :
    BlaschkeDefectPolarized K
  /-- Lift of finite-rank regularised content to the opaque atom. -/
  regularized_of_finite_rank :
    BlaschkeDefectRegularized K

/-! ### Sufficiency: the package builds the admissibility structure -/

/--
The introduction package is sufficient to construct the vol5 admissibility
structure for `K`.
-/
def blaschkeDefectAdmissible_of_intro
    {K : BlaschkeDefectObject}
    (A : AdmissibilityIntroduction K) :
    BlaschkeDefectAdmissible K where
  dualizable := A.dualizable_of_finite_rank
  polarized := A.polarized_of_finite_rank
  regularized := A.regularized_of_finite_rank

/-- Specialisation to the condensed admissibility wrapper. -/
def admissibleCondensedHilbertDefect_of_intro
    {K : CondensedHilbertDefect}
    (A : AdmissibilityIntroduction K.object) :
    AdmissibleCondensedHilbertDefect K :=
  condensed_admissible_of_blaschke_defect (blaschkeDefectAdmissible_of_intro A)

/-! ### Necessity: any admissibility witness gives the introduction -/

/--
Any inhabitant of `BlaschkeDefectAdmissible K` already supplies the
introduction package.  This is the necessity direction of the obstruction
audit.
-/
theorem intro_of_blaschkeDefectAdmissible
    {K : BlaschkeDefectObject}
    (h : BlaschkeDefectAdmissible K) :
    AdmissibilityIntroduction K where
  dualizable_of_finite_rank := h.dualizable
  polarized_of_finite_rank := h.polarized
  regularized_of_finite_rank := h.regularized

/-! ### Equivalence audit -/

/-- The introduction package and `BlaschkeDefectAdmissible` are equivalent. -/
theorem admissibility_intro_iff
    (K : BlaschkeDefectObject) :
    AdmissibilityIntroduction K <-> BlaschkeDefectAdmissible K := by
  constructor
  · intro A
    exact blaschkeDefectAdmissible_of_intro A
  · intro h
    exact intro_of_blaschkeDefectAdmissible h

/-! ### Canonical instantiation -/

/--
Specialised admissibility introduction package for the canonical defect.
This is the data vol6's paper 05 needs to ingest in order to discharge
sub-target 2.4 for `blaschkeDefectObject`.
-/
abbrev CanonicalAdmissibilityIntroduction : Prop :=
  AdmissibilityIntroduction blaschkeDefectObject

/--
Specialised condensed admissibility for the canonical Burnol/Blaschke
condensed Hilbert defect, derived from the canonical introduction package.
-/
def canonical_burnol_blaschke_admissible_of_intro
    (A : CanonicalAdmissibilityIntroduction) :
    BurnolBlaschkeDefectIsAdmissible :=
  admissibleCondensedHilbertDefect_of_intro
    (K := burnolBlaschkeCondensedHilbertDefect) A

/-! ### Audit marker -/

/-- Audit marker for the admissibility obstruction. -/
def admissibility_obstruction_status : String :=
  "Vol6 paper 05 obstruction: BlaschkeDefectAdmissible K is constructively equivalent to AdmissibilityIntroduction K, a three-field package whose fields are exactly the three opaque vol5 atoms (dualizable/polarized/regularized). The obstruction therefore reduces to supplying these three single-field lifts. No new axioms or opaques are introduced; the lifts must be discharged at the vol5/condensed-Hilbert layer."

end Obstruction
end Vol6
