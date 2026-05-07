import Vol6.RHClassicalNewLanguage
import Vol6.QuotientOrthogonalityAdmissibility
import Vol6.Vol5_5.RHAssembly

namespace Vol6
namespace Vol5_5

open Vol5.YonedaNymanTrackA
open Vol6.Obstruction

noncomputable section

/-!
# Vol5.5 closure adapters

This module repackages the existing Vol6 obstruction fields as the transparent
Vol5.5 proof package.  It does not produce an unconditional obstruction
inhabitant; it shows that once the named Vol6 fields are supplied, they have
exactly the shape needed by `TransparentNoPhantomPackage`.
-/

/--
Build transparent no-phantom inputs from explicit detector externalization,
quotient-invisibility, and admissibility introduction data.
-/
noncomputable def transparentNoPhantomInputs_of_introductionRules
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (R : RationalDilationObjectSemantics)
    (iota :
      ExternalizationIntroductionRule
        burnolBlaschkeCondensedHilbertDefect S R)
    (Q : QuotientOrthogonalityInvisibility blaschkeDefectObject)
    (A : CanonicalAdmissibilityIntroduction) :
    TransparentNoPhantomInputs where
  detector := S
  rational := R
  detection :=
    transparentDetectorRelation_of_externalizationIntroductionRule iota
  orthogonality := Q
  admissibility :=
    transparentAdmissibilityData_of_canonicalAdmissibilityIntroduction A

/--
The assembled Vol6 final obstruction repackages as a transparent no-phantom
package.
-/
noncomputable def transparentNoPhantomPackage_of_vol6FinalObstruction
    {S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect}
    {X : DQObj}
    (Ω : RHClassicalNewLanguage.Vol6FinalObstruction S X) :
    TransparentNoPhantomPackage where
  noPhantomInputs :=
    transparentNoPhantomInputs_of_introductionRules
      S
      (Vol6.RationalDilationExternalization.canonicalRationalDilationSemantics X)
      Ω.externalIntro
      (Vol6.QuotientOrthogonalityAdmissibility.burnol_blaschke_quotient_orthogonality_of_intro
        Ω.cokernelIntro)
      Ω.admissIntro
  offCriticalTransport :=
    offCriticalTransport_of_finitePacketTransportPackage
      (finitePacketTransportPackage_of_bridge Ω.bridgeRF01)

/--
Compatibility theorem: the Vol6 final obstruction proves RH through the
transparent Vol5.5 package route.
-/
theorem RH_classical_of_vol6FinalObstruction_via_transparentPackage
    {S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect}
    {X : DQObj}
    (Ω : RHClassicalNewLanguage.Vol6FinalObstruction S X) :
    Vol5.V5aTrackAFormulation.RH_classical :=
  RH_classical_of_transparent_no_phantom_package
    (transparentNoPhantomPackage_of_vol6FinalObstruction Ω)

/-- Audit marker for the Vol5.5 closure adapter. -/
def vol5_5ClosureStatus : String :=
  "Vol5.5 closure adapters installed: existing Vol6 final obstruction fields repackage into TransparentNoPhantomPackage, but no unconditional package inhabitant is constructed."

end

end Vol5_5
end Vol6
