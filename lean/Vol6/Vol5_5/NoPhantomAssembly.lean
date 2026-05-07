import Vol5.YonedaNymanTrackA.NoPhantomLanguage
import Vol6.Vol5_5.DetectorSemantics
import Vol6.Vol5_5.AdmissibilitySemantics

namespace Vol6
namespace Vol5_5

open Vol5.YonedaNymanTrackA

noncomputable section

/-!
# Transparent no-phantom assembly

This module assembles detection, invisibility, and admissibility from explicit
Vol5.5 data and then feeds the result into Vol5's no-phantom language.
-/

/--
The transparent inputs needed to prove `NoPhantomDefect` for the canonical
Burnol/Blaschke condensed Hilbert defect.
-/
structure TransparentNoPhantomInputs : Type 1 where
  detector : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect
  rational : RationalDilationObjectSemantics
  detection :
    BurnolBlaschkeTransparentDetectorRelation detector rational
  orthogonality :
    QuotientOrthogonalityInvisibility blaschkeDefectObject
  admissibility :
    BurnolBlaschkeTransparentAdmissibilityData

/-- The transparent inputs assemble Vol5's RKHS detector semantics. -/
noncomputable def rkhsSemantics_of_transparentNoPhantomInputs
    (P : TransparentNoPhantomInputs) :
    BurnolBlaschkeRKHSDetectorSemantics where
  detector := P.detector
  rational := P.rational
  externalization :=
    externalization_of_transparentDetectorRelation P.detection
  orthogonality := P.orthogonality
  admissibility :=
    burnolBlaschkeDefectIsAdmissible_of_transparentAdmissibilityData
      P.admissibility

/-- The transparent inputs assemble Vol5's detector-calculus payload. -/
noncomputable def yonedaBlaschkeDetectorCalculus_of_transparentNoPhantomInputs
    (P : TransparentNoPhantomInputs) :
    YonedaBlaschkeDetectorCalculus where
  rkhs := rkhsSemantics_of_transparentNoPhantomInputs P

/-- The transparent inputs prove the direct `NoPhantomDefect` payload. -/
theorem noPhantomDefect_of_transparentNoPhantomInputs
    (P : TransparentNoPhantomInputs) :
    NoPhantomDefect :=
  no_phantom_defect_of_yoneda_blaschke_detector_calculus
    (yonedaBlaschkeDetectorCalculus_of_transparentNoPhantomInputs P)

/--
Expanded audit theorem: the transparent inputs supply exactly the three fields
of `NoPhantomDefect`.
-/
theorem transparentNoPhantomInputs_supplies_fields
    (P : TransparentNoPhantomInputs) :
    BurnolBlaschkeDefectYonedaDetection /\
      BurnolBlaschkeDefectYonedaInvisibility /\
        BurnolBlaschkeDefectIsAdmissible := by
  exact no_phantom_defect_expanded.mp
    (noPhantomDefect_of_transparentNoPhantomInputs P)

/-- Audit marker for no-phantom assembly. -/
def transparentNoPhantomAssemblyStatus : String :=
  "Vol5.5 no-phantom assembly installed: transparent detector, quotient-invisibility, and admissibility data produce NoPhantomDefect."

end

end Vol5_5
end Vol6
