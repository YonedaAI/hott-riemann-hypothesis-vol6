import Vol5.YonedaNymanTrackA.CondensedHilbertDefect
import Vol6.Obstruction.AdmissibilityObstruction

namespace Vol6
namespace Vol5_5

open Vol5.YonedaNymanTrackA

noncomputable section

/-!
# Transparent admissibility certificates

This module packages the three admissibility certificates as actual data and
then maps those certificates into the Vol5 admissibility fields.
-/

/--
Transparent admissibility data for a Blaschke defect object.

Each certificate type is explicit data.  The final three maps are the theorem
obligations that connect those certificates to Vol5's admissibility fields.
-/
structure TransparentAdmissibilityData
    (K : BlaschkeDefectObject) : Type 1 where
  DualizableCertificate : Type
  PolarizedCertificate : Type
  RegularizedCertificate : Type
  dualizableCertificate : DualizableCertificate
  polarizedCertificate : PolarizedCertificate
  regularizedCertificate : RegularizedCertificate
  dualizable_of_certificate :
    DualizableCertificate -> BlaschkeDefectDualizable K
  polarized_of_certificate :
    PolarizedCertificate -> BlaschkeDefectPolarized K
  regularized_of_certificate :
    RegularizedCertificate -> BlaschkeDefectRegularized K

/-- Transparent admissibility data supplies Vol5 Blaschke admissibility. -/
theorem blaschkeDefectAdmissible_of_transparentAdmissibilityData
    {K : BlaschkeDefectObject}
    (A : TransparentAdmissibilityData K) :
    BlaschkeDefectAdmissible K where
  dualizable := A.dualizable_of_certificate A.dualizableCertificate
  polarized := A.polarized_of_certificate A.polarizedCertificate
  regularized := A.regularized_of_certificate A.regularizedCertificate

/--
Transparent admissibility data supplies the exact Vol6 admissibility
introduction package.  The maps into Vol5's three predicates remain the real
proof obligations.
-/
theorem admissibilityIntroduction_of_transparentAdmissibilityData
    {K : BlaschkeDefectObject}
    (A : TransparentAdmissibilityData K) :
    Vol6.Obstruction.AdmissibilityIntroduction K where
  dualizable_of_finite_rank :=
    A.dualizable_of_certificate A.dualizableCertificate
  polarized_of_finite_rank :=
    A.polarized_of_certificate A.polarizedCertificate
  regularized_of_finite_rank :=
    A.regularized_of_certificate A.regularizedCertificate

/-- Transparent admissibility data supplies condensed Hilbert admissibility. -/
theorem admissibleCondensedHilbertDefect_of_transparentAdmissibilityData
    {K : CondensedHilbertDefect}
    (A : TransparentAdmissibilityData K.object) :
    AdmissibleCondensedHilbertDefect K :=
  condensed_admissible_of_blaschke_defect
    (blaschkeDefectAdmissible_of_transparentAdmissibilityData A)

/-- Canonical Burnol/Blaschke specialization. -/
abbrev BurnolBlaschkeTransparentAdmissibilityData : Type 1 :=
  TransparentAdmissibilityData blaschkeDefectObject

/-- Canonical transparent admissibility data supplies the Vol5 target. -/
theorem burnolBlaschkeDefectIsAdmissible_of_transparentAdmissibilityData
    (A : BurnolBlaschkeTransparentAdmissibilityData) :
    BurnolBlaschkeDefectIsAdmissible :=
  admissibleCondensedHilbertDefect_of_transparentAdmissibilityData A

/-- Canonical transparent data supplies Vol6's canonical introduction package. -/
theorem canonicalAdmissibilityIntroduction_of_transparentAdmissibilityData
    (A : BurnolBlaschkeTransparentAdmissibilityData) :
    Vol6.Obstruction.CanonicalAdmissibilityIntroduction :=
  admissibilityIntroduction_of_transparentAdmissibilityData A

/-- Audit marker for the transparent admissibility layer. -/
def transparentAdmissibilityStatus : String :=
  "Vol5.5 admissibility interface installed: dualizable, polarized, and regularized certificates are explicit data before being mapped into the Vol5 admissibility fields."

end

end Vol5_5
end Vol6
