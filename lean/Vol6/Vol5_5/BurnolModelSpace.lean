import Vol5.YonedaNymanTrackA.NoPhantomLanguage

namespace Vol6
namespace Vol5_5

open Vol5.YonedaNymanTrackA

noncomputable section

/-!
# Transparent Burnol model-space interface

This module records the stronger interface that the next proof layer needs.
It is not enough to produce an arbitrary element of Vol5's Burnol carrier:
the transport data must also prove that the corresponding canonical condensed
Hilbert defect is nonzero.
-/

/--
A transparent model-space presentation for the Burnol/Blaschke defect.

The `Carrier` is the new semantic carrier.  The map to Vol5's existing carrier
keeps compatibility with `OffCriticalZeroDefectKernel`, while
`nonzeroDefectOf` is the extra datum that the old `Nonempty` bridge forgot.
-/
structure BurnolModelSpace : Type 1 where
  Carrier : Type
  toVol5Carrier : Carrier -> burnolBlaschkeFactor.modelSpaceCarrier

/-- A named nonzero vector in a transparent Burnol model-space presentation. -/
structure NonzeroBurnolDefectVector (M : BurnolModelSpace) : Type where
  vector : M.Carrier
  nonzeroDefect :
    CondensedHilbertDefectNonzero burnolBlaschkeCondensedHilbertDefect

namespace NonzeroBurnolDefectVector

/-- The Vol5-compatible carrier vector underlying a transparent nonzero vector. -/
def toVol5Carrier
    {M : BurnolModelSpace}
    (v : NonzeroBurnolDefectVector M) :
    burnolBlaschkeFactor.modelSpaceCarrier :=
  M.toVol5Carrier v.vector

end NonzeroBurnolDefectVector

/--
An off-critical-zero transport theorem into a transparent Burnol model space.

This is intentionally stronger than Vol5's `OffCriticalZeroDefectKernel`:
it chooses a semantic vector from an off-critical zero, and the model-space
presentation proves that this vector is a nonzero canonical defect.
-/
structure OffCriticalBurnolTransport : Type 1 where
  modelSpace : BurnolModelSpace
  vectorOfOffCritical :
    ExistsOffCriticalZero -> NonzeroBurnolDefectVector modelSpace

/--
The strengthened transport theorem implies the exact Vol5 hard bridge:
off-critical zeros create nonzero canonical Burnol/Blaschke defects.
-/
theorem offCriticalZeroCreatesDefect_of_transport
    (T : OffCriticalBurnolTransport) :
    OffCriticalZeroCreatesDefect where
  nonzero_defect_of_offcritical := by
    intro hOff
    exact (T.vectorOfOffCritical hOff).nonzeroDefect

/--
Compatibility with the older Vol5 kernel payload.  This theorem deliberately
forgets the nonzero-defect proof and keeps only Vol5 carrier nonemptiness.
-/
theorem offCriticalZeroDefectKernel_of_transport
    (T : OffCriticalBurnolTransport) :
    OffCriticalZeroDefectKernel where
  model_vector_of_offcritical := by
    intro hOff
    exact ⟨(T.vectorOfOffCritical hOff).toVol5Carrier⟩

/-- Bundled compatibility statement for downstream assembly modules. -/
theorem transport_supplies_old_kernel_and_nonzero_defect
    (T : OffCriticalBurnolTransport) :
    OffCriticalZeroDefectKernel /\ OffCriticalZeroCreatesDefect :=
  ⟨offCriticalZeroDefectKernel_of_transport T,
   offCriticalZeroCreatesDefect_of_transport T⟩

/-- Audit marker for the transparent Burnol model-space layer. -/
def burnolModelSpaceStatus : String :=
  "Vol5.5 Burnol model-space interface installed: off-critical transport now targets transparent nonzero defect vectors and only then forgets to the older carrier-nonempty kernel."

end

end Vol5_5
end Vol6
