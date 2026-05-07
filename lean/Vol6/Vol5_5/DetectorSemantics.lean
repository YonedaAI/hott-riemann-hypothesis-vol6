import Vol5.YonedaNymanTrackA.RKHSDetectorSemantics

namespace Vol6
namespace Vol5_5

open Vol5.YonedaNymanTrackA

noncomputable section

/-!
# Transparent detector semantics

The detector relation below separates the proof-facing detector predicate from
the existing Vol5 rational-dilation detection target.  Closing the bridge now
means giving a relation, showing actual detector witnesses land in it, and
then proving those related witnesses produce the Vol5 detection target.
-/

/--
A detector-indexed semantic relation together with its realization as a
rational-dilation detection theorem.
-/
structure TransparentDetectorRelation
    (K : CondensedHilbertDefect)
    (S : RKHSModelSpaceDetector K)
    (R : RationalDilationObjectSemantics) : Type 1 where
  parameterOf : S.Detector -> R.Parameter
  Detects : K.object.modelCarrier -> S.Detector -> Prop
  detects_of_model_detector :
    forall {v : K.object.modelCarrier} {d : S.Detector},
      S.detectsVector v d -> Detects v d
  vol5_detected_of_detects :
    forall {v : K.object.modelCarrier} {d : S.Detector},
      Detects v d ->
        CondensedHilbertDefectDetectedByRationalDilation K
          (yoneda (R.objectOf (parameterOf d)))

/--
The transparent detector relation supplies the externalization structure used
by Vol5's RKHS detector semantics.
-/
noncomputable def externalization_of_transparentDetectorRelation
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics}
    (H : TransparentDetectorRelation K S R) :
    RKHSDetectorExternalizationToRationalRepresentables K S R where
  parameterOf := H.parameterOf
  presheafOf := fun d => yoneda (R.objectOf (H.parameterOf d))
  presheaf_eq := by
    intro _
    rfl
  detected_of_detector := by
    intro _ _ hDetector
    exact H.vol5_detected_of_detects
      (H.detects_of_model_detector hDetector)

/--
The same transparent relation gives Yoneda detection of nonzero condensed
Hilbert defects through Vol5's existing detector theorem.
-/
theorem yonedaDetectsNonzero_of_transparentDetectorRelation
    {K : CondensedHilbertDefect}
    {S : RKHSModelSpaceDetector K}
    {R : RationalDilationObjectSemantics}
    (H : TransparentDetectorRelation K S R) :
    YonedaDetectsNonzeroDefect K :=
  yoneda_detects_nonzero_defect_of_rkhs_detector
    (externalization_of_transparentDetectorRelation H)

/-- Canonical Burnol/Blaschke specialization of the transparent relation. -/
abbrev BurnolBlaschkeTransparentDetectorRelation
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (R : RationalDilationObjectSemantics) : Type 1 :=
  TransparentDetectorRelation
    burnolBlaschkeCondensedHilbertDefect S R

/-- Audit marker for the transparent detector layer. -/
def transparentDetectorSemanticsStatus : String :=
  "Vol5.5 detector interface installed: detector witnesses pass through a transparent relation before yielding the Vol5 rational-dilation detection target."

end

end Vol5_5
end Vol6
