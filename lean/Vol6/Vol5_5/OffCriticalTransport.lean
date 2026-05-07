import Vol6.OffCriticalDefectKernel
import Vol6.Vol5_5.BurnolModelSpace

namespace Vol6
namespace Vol5_5

open Vol5.YonedaNymanTrackA
open Vol6.FiniteBlaschkePacketNS
open Vol6.Obstruction

noncomputable section

/-!
# Off-critical transport assembly

This module keeps the strengthened off-critical bridge in its own import path
so downstream code can depend on the nonzero-defect theorem without reopening
the model-space interface.
-/

/-- Canonical name for the strengthened off-critical bridge. -/
abbrev OffCriticalTransport : Type 1 :=
  OffCriticalBurnolTransport

/-! ## Thin finite-packet adapter for the existing Vol6 route -/

/--
The finite-packet model-space carrier for a packet `P`, exposed under the
Vol5.5 namespace for the transport package below.
-/
abbrev FinitePacketBurnolModelSpace
    (P : FiniteBlaschkePacket) : Type :=
  (finiteBlaschkeModelSpace P).carrier

/--
The legacy finite-packet transport package.  This is a transparent adapter
over the existing Vol6 paper-03 bridge, not a no-argument inhabitant.
-/
structure FinitePacketTransportPackage : Type 1 where
  transport :
    ∀ (P : FiniteBlaschkePacket), Nonempty P.ZeroIndex ->
      FinitePacketBurnolModelSpace P ->
        burnolBlaschkeFactor.modelSpaceCarrier

/-- The legacy package is exactly an `OffCriticalDefectKernelBridge`. -/
def bridge_of_finitePacketTransportPackage
    (P : FinitePacketTransportPackage) :
    OffCriticalDefectKernelBridge where
  transport := P.transport

/-- The legacy package proves Vol5's older carrier-nonempty kernel payload. -/
theorem offCriticalZeroDefectKernel_of_finitePacketTransportPackage
    (P : FinitePacketTransportPackage) :
    OffCriticalZeroDefectKernel :=
  Vol6.OffCriticalDefectKernelNS.off_critical_zero_defect_kernel_of_bridge
    (bridge_of_finitePacketTransportPackage P)

/--
The legacy package also proves Vol5's current `OffCriticalZeroCreatesDefect`
target by using Vol5's existing kernel-to-defect theorem.
-/
theorem offCriticalZeroCreatesDefect_of_finitePacketTransportPackage
    (P : FinitePacketTransportPackage) :
    OffCriticalZeroCreatesDefect :=
  off_critical_zero_creates_defect_of_kernel
    (offCriticalZeroDefectKernel_of_finitePacketTransportPackage P)

/-! ## Strengthened finite-packet package for the proof-facing layer -/

/--
A strengthened finite-packet package.  In addition to transporting finite
packet vectors into Vol5's canonical carrier, it proves that every transported
finite-packet vector yields a nonzero canonical condensed Hilbert defect.
-/
structure StrengthenedFinitePacketTransportPackage : Type 1 where
  transport :
    ∀ (P : FiniteBlaschkePacket), Nonempty P.ZeroIndex ->
      FinitePacketBurnolModelSpace P ->
        burnolBlaschkeFactor.modelSpaceCarrier
  nonzero_defect_of_transport :
    ∀ (P : FiniteBlaschkePacket)
      (_hP : Nonempty P.ZeroIndex)
      (_v : FinitePacketBurnolModelSpace P),
        CondensedHilbertDefectNonzero
          burnolBlaschkeCondensedHilbertDefect

/-- Forget the strengthened package to the legacy finite-packet transport. -/
def finitePacketTransportPackage_of_strengthened
    (P : StrengthenedFinitePacketTransportPackage) :
    FinitePacketTransportPackage where
  transport := P.transport

/--
Turn a strengthened finite-packet transport package into the proof-facing
transparent off-critical transport package.
-/
noncomputable def offCriticalTransport_of_strengthenedFinitePacketTransportPackage
    (P : StrengthenedFinitePacketTransportPackage) :
    OffCriticalTransport where
  modelSpace :=
    { Carrier := burnolBlaschkeFactor.modelSpaceCarrier
      toVol5Carrier := id }
  vectorOfOffCritical := by
    intro hOff
    let s : ℂ := Classical.choose hOff
    let hZero : OffCriticalZero s := Classical.choose_spec hOff
    let Q : FiniteBlaschkePacket :=
      Vol6.OffCriticalDefectKernelNS.singlePointPacket s hZero
    let hQ : Nonempty Q.ZeroIndex :=
      Vol6.OffCriticalDefectKernelNS.singlePointPacket_nonempty s hZero
    let v : FinitePacketBurnolModelSpace Q :=
      Vol6.OffCriticalDefectKernelNS.singlePointModelWitness s hZero
    exact
      { vector := P.transport Q hQ v
        nonzeroDefect := P.nonzero_defect_of_transport Q hQ v }

/-- The strengthened package proves the direct Vol5 creation target. -/
theorem offCriticalZeroCreatesDefect_of_strengthenedFinitePacketTransportPackage
    (P : StrengthenedFinitePacketTransportPackage) :
    OffCriticalZeroCreatesDefect :=
  offCriticalZeroCreatesDefect_of_transport
    (offCriticalTransport_of_strengthenedFinitePacketTransportPackage P)

/-- The strengthened package also proves the older Vol5 kernel target. -/
theorem offCriticalZeroDefectKernel_of_strengthenedFinitePacketTransportPackage
    (P : StrengthenedFinitePacketTransportPackage) :
    OffCriticalZeroDefectKernel :=
  offCriticalZeroDefectKernel_of_transport
    (offCriticalTransport_of_strengthenedFinitePacketTransportPackage P)

/-- The strengthened bridge proves the direct Vol5 creation target. -/
theorem offCriticalZeroCreatesDefect_of_offCriticalTransport
    (T : OffCriticalTransport) :
    OffCriticalZeroCreatesDefect :=
  offCriticalZeroCreatesDefect_of_transport T

/--
The strengthened bridge also supplies the older Vol5 kernel target, by
forgetting the nonzero-defect proof.
-/
theorem offCriticalZeroDefectKernel_of_offCriticalTransport
    (T : OffCriticalTransport) :
    OffCriticalZeroDefectKernel :=
  offCriticalZeroDefectKernel_of_transport T

/-- Audit marker for the strengthened off-critical transport module. -/
def offCriticalTransportStatus : String :=
  "Vol5.5 off-critical transport installed: FinitePacketTransportPackage is the thin adapter over the existing Vol6 bridge; StrengthenedFinitePacketTransportPackage and OffCriticalTransport add the proof-facing nonzero-defect data."

end

end Vol5_5
end Vol6
