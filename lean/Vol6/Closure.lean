import Vol6.RHClassicalNewLanguage
import Vol6.Closure.OffCriticalDefectKernelBridge
import Vol6.Closure.ExternalizationIntroductionRule
import Vol6.Closure.QuotientOrthogonalityIntroduction
import Vol6.Closure.AdmissibilityIntroduction

/-!
# Vol6 closure roadmap integration

This module integrates the four Vol6-only closure/no-go artifacts for the exact
fields of `RHClassicalNewLanguage.Vol6FinalObstruction`.
-/

namespace Vol6
namespace Closure

open Vol5.YonedaNymanTrackA

/-! ## Integrated closure inputs -/

/--
The exact four inputs identified by the Vol6 closure teams, specialized to the
detector `S` and rational-dilation object `X` used by the final obstruction.
-/
abbrev FinalObstructionClosureInputs
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (X : DQObj) : Prop :=
  Nonempty burnolBlaschkeFactor.modelSpaceCarrier /\
    ExternalizationIntroductionRule.BurnolBlaschkeCanonicalDetectorIndexedDetectionTheorem S X /\
      CanonicalYonedaImageNotDetected /\
        CanonicalAdmissibilityAtoms

/--
The four closure inputs build the exact `Vol6FinalObstruction S X` record.
-/
noncomputable def vol6FinalObstruction_of_closureInputs
    {S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect}
    {X : DQObj}
    (h : FinalObstructionClosureInputs S X) :
    RHClassicalNewLanguage.Vol6FinalObstruction S X := by
  rcases h with ⟨hCarrier, hExternal, hQuotient, hAdmiss⟩
  let externalRule :=
    Classical.choice hExternal
  exact
    { bridgeRF01 := bridge_of_burnol_model_nonempty hCarrier
      externalIntro :=
        ExternalizationIntroductionRule.externalizationIntroductionRule_of_detectorIndexedDetectionRule
          externalRule
      cokernelIntro :=
        canonical_intro_of_yoneda_image_not_detected hQuotient
      admissIntro :=
        canonical_admissibility_introduction_of_atoms hAdmiss }

/--
Any exact `Vol6FinalObstruction S X` record yields the four closure-team inputs.
-/
noncomputable def closureInputs_of_vol6FinalObstruction
    {S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect}
    {X : DQObj}
    (Ω : RHClassicalNewLanguage.Vol6FinalObstruction S X) :
    FinalObstructionClosureInputs S X :=
  ⟨ burnol_model_nonempty_of_bridge Ω.bridgeRF01
  , ⟨ExternalizationIntroductionRule.detectorIndexedDetectionRule_of_externalizationIntroductionRule
      Ω.externalIntro⟩
  , canonical_yoneda_image_not_detected_of_intro Ω.cokernelIntro
  , (canonical_admissibility_introduction_iff_atoms.mp Ω.admissIntro) ⟩

/--
Integrated closure theorem: inhabiting the final obstruction is exactly the
same as supplying the four team-characterized inputs.
-/
theorem nonempty_vol6FinalObstruction_iff_closureInputs
    {S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect}
    {X : DQObj} :
    Nonempty (RHClassicalNewLanguage.Vol6FinalObstruction S X) <->
      FinalObstructionClosureInputs S X := by
  constructor
  · rintro ⟨Ω⟩
    exact closureInputs_of_vol6FinalObstruction Ω
  · intro h
    exact ⟨vol6FinalObstruction_of_closureInputs h⟩

/-! ## Audit marker -/

/--
Audit-readable integrated closure status.
-/
def vol6_closure_roadmap_status : String :=
  "Vol6 closure roadmap integrated: Vol6FinalObstruction S X is equivalent to exactly four inputs: Nonempty burnolBlaschkeFactor.modelSpaceCarrier, detector-indexed ExternalizationIntroductionRule data for S and canonicalRationalDilationSemantics X, CanonicalYonedaImageNotDetected, and the three CanonicalAdmissibilityAtoms. No unconditional RH theorem is added by this module."

end Closure
end Vol6
