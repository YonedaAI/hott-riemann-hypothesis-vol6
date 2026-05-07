/-
  Volume VI closure artifact for the Paper 03 off-critical defect-kernel
  bridge.

  The target field is

      Vol6.Obstruction.OffCriticalDefectKernelBridge

  from `Vol6.Obstruction.OffCriticalDefectKernelObstruction`.  The bridge is
  data-valued: it transports every nonempty finite-packet model-space carrier
  into the canonical Burnol/Blaschke model-space carrier.  With the current
  Vol6-only surface, that data is exactly equivalent to having one element of
  the canonical carrier itself.
-/

import Vol6.Obstruction.OffCriticalDefectKernelObstruction

namespace Vol6
namespace Closure

open Vol5.YonedaNymanTrackA
open Vol6.FiniteBlaschkePacketNS
open Vol6.Obstruction

/-! ## A fixed nonempty packet used for the reverse direction -/

/--
A concrete singleton packet.  It is only used to test a bridge on one
nonempty finite model-space carrier.
-/
def offCriticalDefectKernelBridgeTestPacket : FiniteBlaschkePacket where
  ZeroIndex := Fin 1
  finite := inferInstance
  zeroPoint := fun _ => (0 : Complex)
  offCritical := fun _ => True

/-- The singleton test packet has a nonempty zero-index type. -/
theorem offCriticalDefectKernelBridgeTestPacket_nonempty :
    Nonempty offCriticalDefectKernelBridgeTestPacket.ZeroIndex :=
  ⟨(0 : Fin 1)⟩

/--
The singleton test packet has a nonempty finite-packet model-space carrier,
by Paper 01's Vol6 construction.
-/
theorem offCriticalDefectKernelBridgeTestCarrier_nonempty :
    Nonempty
      (finiteBlaschkeModelSpace offCriticalDefectKernelBridgeTestPacket).carrier :=
  finite_packet_model_space_nonempty
    offCriticalDefectKernelBridgeTestPacket
    offCriticalDefectKernelBridgeTestPacket_nonempty

/-! ## Exact reduction to the Burnol/Blaschke carrier nonemptiness -/

/--
Any element of the canonical Burnol/Blaschke model-space carrier gives the
Paper 03 bridge, by using the constant transport map.
-/
noncomputable def bridge_of_burnol_model_nonempty
    (h : Nonempty burnolBlaschkeFactor.modelSpaceCarrier) :
    OffCriticalDefectKernelBridge where
  transport := fun _P _hP _v => h.some

/--
Any Paper 03 bridge produces an element of the canonical Burnol/Blaschke
model-space carrier by applying it to the fixed singleton packet.
-/
theorem burnol_model_nonempty_of_bridge
    (bridge : OffCriticalDefectKernelBridge) :
    Nonempty burnolBlaschkeFactor.modelSpaceCarrier := by
  rcases offCriticalDefectKernelBridgeTestCarrier_nonempty with ⟨v⟩
  exact
    ⟨bridge.transport
      offCriticalDefectKernelBridgeTestPacket
      offCriticalDefectKernelBridgeTestPacket_nonempty
      v⟩

/--
The closure/no-go characterization: inhabiting the Paper 03 bridge is
exactly the same remaining input as inhabiting the canonical Burnol/Blaschke
model-space carrier.
-/
theorem nonempty_bridge_iff_burnol_model_nonempty :
    Nonempty OffCriticalDefectKernelBridge ↔
      Nonempty burnolBlaschkeFactor.modelSpaceCarrier := by
  constructor
  · intro hBridge
    rcases hBridge with ⟨bridge⟩
    exact burnol_model_nonempty_of_bridge bridge
  · intro hModel
    exact ⟨bridge_of_burnol_model_nonempty hModel⟩

/--
Alias with a more explicit audit name for downstream closure checks.
-/
theorem offCriticalDefectKernelBridge_exact_remaining_input :
    Nonempty OffCriticalDefectKernelBridge ↔
      Nonempty burnolBlaschkeFactor.modelSpaceCarrier :=
  nonempty_bridge_iff_burnol_model_nonempty

/-! ## Audit marker -/

/--
Status marker for the Vol6-only closure artifact.
-/
def offCriticalDefectKernelBridge_closure_status : String :=
  "Vol6 closure/no-go artifact for OffCriticalDefectKernelBridge: no unconditional bridge is supplied here; the exact minimal remaining input is Nonempty burnolBlaschkeFactor.modelSpaceCarrier, as proved by nonempty_bridge_iff_burnol_model_nonempty."

end Closure
end Vol6
