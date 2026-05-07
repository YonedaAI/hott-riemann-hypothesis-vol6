import Vol5.YonedaNymanTrackA.NoPhantomLanguage
import Vol6.Vol5_5.NoPhantomAssembly
import Vol6.Vol5_5.OffCriticalTransport

namespace Vol6
namespace Vol5_5

open Vol5.YonedaNymanTrackA
open Vol5.V5aTrackAFormulation

noncomputable section

/-!
# Vol5.5 RH assembly

The final package in this layer combines the two genuine proof obligations:
transparent no-phantom data and strengthened off-critical transport data.
-/

/--
The transparent package that is strong enough to feed Vol5's no-phantom route.
-/
structure TransparentNoPhantomPackage : Type 1 where
  noPhantomInputs : TransparentNoPhantomInputs
  offCriticalTransport : OffCriticalTransport

/-- The package proves the direct Vol5 no-phantom language. -/
theorem burnolBlaschkeNoPhantomLanguage_of_transparentNoPhantomPackage
    (P : TransparentNoPhantomPackage) :
    BurnolBlaschkeNoPhantomLanguage where
  noPhantom :=
    noPhantomDefect_of_transparentNoPhantomInputs P.noPhantomInputs
  offCriticalCreatesDefect :=
    offCriticalZeroCreatesDefect_of_offCriticalTransport
      P.offCriticalTransport

/-- The package also supplies the older Vol5 breakthrough record. -/
noncomputable def noPhantomLanguageBreakthrough_of_transparentNoPhantomPackage
    (P : TransparentNoPhantomPackage) :
    NoPhantomLanguageBreakthrough where
  detectorCalculus :=
    yonedaBlaschkeDetectorCalculus_of_transparentNoPhantomInputs
      P.noPhantomInputs
  offCriticalKernel :=
    offCriticalZeroDefectKernel_of_offCriticalTransport
      P.offCriticalTransport

/-- The package closes exactly the two Vol5 semantic payloads. -/
theorem transparentNoPhantomPackage_closes_payloads
    (P : TransparentNoPhantomPackage) :
    NoPhantomDefect /\ OffCriticalZeroCreatesDefect :=
  ⟨ noPhantomDefect_of_transparentNoPhantomInputs P.noPhantomInputs
  , offCriticalZeroCreatesDefect_of_offCriticalTransport
      P.offCriticalTransport ⟩

/--
Final Vol5.5 theorem: a transparent no-phantom package proves classical RH
through the direct Vol5 no-phantom route.
-/
theorem RH_classical_of_transparent_no_phantom_package
    (P : TransparentNoPhantomPackage) :
    RH_classical :=
  RH_classical_of_burnol_blaschke_no_phantom_language
    (burnolBlaschkeNoPhantomLanguage_of_transparentNoPhantomPackage P)

/--
Compatibility theorem: the same package proves RH through the older Vol5
breakthrough wrapper as well.
-/
theorem RH_classical_of_transparent_breakthrough_package
    (P : TransparentNoPhantomPackage) :
    RH_classical :=
  RH_classical_of_no_phantom_language_breakthrough
    (noPhantomLanguageBreakthrough_of_transparentNoPhantomPackage P)

/-- Audit marker for Vol5.5 assembly. -/
def transparentRHAssemblyStatus : String :=
  "Vol5.5 RH assembly installed: a TransparentNoPhantomPackage proves NoPhantomDefect, OffCriticalZeroCreatesDefect, the older breakthrough payload, and RH_classical conditionally on those transparent data."

end

end Vol5_5
end Vol6
