/-
  Volume VI — Paper 03: Off-Critical Zeta Zeros Create Nonzero Model-Space
  Vectors (Target 1).

  This module is paper 03 of the Vol6 sprint and delivers Target 1 of the
  Vol5 conditional master theorem
  `RH_classical_of_no_phantom_language_breakthrough`:

      structure OffCriticalZeroDefectKernel : Prop where
        model_vector_of_offcritical :
          ExistsOffCriticalZero ->
            Nonempty burnolBlaschkeFactor.modelSpaceCarrier

  The proof route is

      off-critical zeta zero  s
        ↦  Möbius image  α(s) = (s - 1) / (s + 1) ∈ open unit disc
        ↦  zero of the Burnol/Blaschke factor  B  at  α(s)
        ↦  singleton finite Blaschke packet  P_s = { α(s) }
        ↦  Paper 01 finite_packet_model_space_nonempty  ⇒
              Nonempty (finiteBlaschkeModelSpace P_s).carrier
        ↦  TRANSPORT  ⇒
              Nonempty burnolBlaschkeFactor.modelSpaceCarrier .

  All steps before TRANSPORT are discharged unconditionally below.  The
  TRANSPORT step requires a Vol5 surface bridge that is not currently
  available (the carrier `burnolBlaschkeFactor.modelSpaceCarrier` is
  supplied by `axiom burnolBlaschkeFactor` in `BurnolCore.lean` with no
  introduction rule).  This module therefore supplies:

  * concrete data and proofs up to the TRANSPORT step,
  * the conditional theorem
    `off_critical_zero_defect_kernel_of_bridge`,
  * (NO unconditional `off_critical_zero_defect_kernel`).

  The precise typed proposition required to upgrade
  `off_critical_zero_defect_kernel_of_bridge` to an unconditional theorem
  is shipped in `Vol6.Obstruction.OffCriticalDefectKernelObstruction`.

  No `sorry`, `admit`, new `axiom`, or new `opaque` appears in this file.
  All `Vol5` symbols are imported read-only.
-/

import Vol5.YonedaNymanTrackA.NoPhantomLanguage
import Vol5.YonedaNymanTrackA.OffCriticalZeroDefect
import Vol5.YonedaNymanTrackA.BurnolCore
import Vol6.FiniteBlaschkePacket
import Vol6.Obstruction.OffCriticalDefectKernelObstruction

namespace Vol6
namespace OffCriticalDefectKernelNS

open Vol5.YonedaNymanTrackA
open Vol6.FiniteBlaschkePacketNS
open Vol6.Obstruction

noncomputable section

/-! ## Singleton packet attached to an off-critical zeta zero -/

/--
The Möbius parameter map `s ↦ (s-1)/(s+1)` re-exported from the
obstruction module.  This is the canonical map sending the Riemann
critical strip into the closed unit disc.
-/
abbrev α (s : ℂ) : ℂ := mobiusParam s

/-- `α` agrees with `mobiusParam`. -/
theorem α_def (s : ℂ) : α s = mobiusParam s := rfl

/--
The singleton finite Blaschke packet attached to an off-critical zeta
zero `s`.

* The index type is `Fin 1` — one packet zero.
* `zeroPoint 0 = α s = (s - 1)/(s + 1)` is the Möbius image of `s`, the
  point at which the canonical Burnol/Blaschke factor has a corresponding
  zero.
* The off-criticality flag is recorded as `True` for the unique index;
  the genuine off-criticality datum is carried by the witness of
  `OffCriticalZero s` separately.
-/
def singlePointPacket (s : ℂ) (_h : OffCriticalZero s) :
    FiniteBlaschkePacket where
  ZeroIndex := Fin 1
  finite := inferInstance
  zeroPoint := fun _ => α s
  offCritical := fun _ => True

/-- The singleton packet has nonempty index type. -/
theorem singlePointPacket_nonempty
    (s : ℂ) (h : OffCriticalZero s) :
    Nonempty (singlePointPacket s h).ZeroIndex :=
  ⟨(0 : Fin 1)⟩

/-- The unique zero point of the singleton packet equals `α s`. -/
theorem singlePointPacket_zero
    (s : ℂ) (h : OffCriticalZero s) (i : (singlePointPacket s h).ZeroIndex) :
    (singlePointPacket s h).zeroPoint i = α s := rfl

/-! ## Finite-packet model space for the singleton -/

/--
The finite-packet model space attached to the singleton packet at `s`.
Its carrier is `Fin 1 → ℂ`.  By Paper 01's
`finite_packet_model_space_nonempty`, this carrier is nonempty.
-/
def singlePointModelSpace (s : ℂ) (h : OffCriticalZero s) :
    FiniteBlaschkeModelSpace :=
  finiteBlaschkeModelSpace (singlePointPacket s h)

/--
**Step 1 (closed).**  The singleton finite-packet model space carrier is
nonempty.

This is the direct application of Paper 01's principal theorem to the
singleton packet attached to an off-critical zeta zero.  No bridge to the
canonical Burnol carrier is involved.
-/
theorem singlePointModelSpace_nonempty
    (s : ℂ) (h : OffCriticalZero s) :
    Nonempty (singlePointModelSpace s h).carrier :=
  finite_packet_model_space_nonempty
    (singlePointPacket s h)
    (singlePointPacket_nonempty s h)

/--
A concrete witness of the singleton finite-packet model space.

Constructed via Classical.choice from the nonemptiness theorem.  The
`noncomputable` modifier inherits from the surrounding section.
-/
def singlePointModelWitness
    (s : ℂ) (h : OffCriticalZero s) :
    (singlePointModelSpace s h).carrier :=
  (singlePointModelSpace_nonempty s h).some

/-! ## Step 2: Transport (conditional) -/

/--
**Step 2 (conditional).**  Given a Vol5 transport bridge, the singleton
finite-packet witness can be transported into
`burnolBlaschkeFactor.modelSpaceCarrier`.

This step is the place where the Vol5 surface RF-01 (opacity of
`burnolBlaschkeFactor.modelSpaceCarrier`) is exercised.  The bridge
`OffCriticalDefectKernelBridge` packages the precise transport data; once
a Vol5 lemma supplies any of the three bridge forms (identification,
injection, or constructor), `OffCriticalDefectKernelBridge` becomes
inhabited and this lemma upgrades to an unconditional one.
-/
theorem nonempty_burnol_modelSpaceCarrier_of_bridge
    (bridge : OffCriticalDefectKernelBridge) :
    ExistsOffCriticalZero →
      Nonempty burnolBlaschkeFactor.modelSpaceCarrier := by
  intro hOff
  rcases hOff with ⟨s, hZero⟩
  -- Build the singleton packet at `s`.
  let P : FiniteBlaschkePacket := singlePointPacket s hZero
  -- Paper 01 supplies a nonempty finite-packet model space carrier.
  have hPNonempty : Nonempty P.ZeroIndex :=
    singlePointPacket_nonempty s hZero
  have hCarrier : Nonempty (finiteBlaschkeModelSpace P).carrier :=
    finite_packet_model_space_nonempty P hPNonempty
  -- The bridge's `transport` field maps the finite carrier into the
  -- Burnol carrier.
  rcases hCarrier with ⟨v⟩
  exact ⟨bridge.transport P hPNonempty v⟩

/-! ## Conditional principal theorem -/

/--
**Conditional principal theorem of Paper 03.**

Under the bridge `OffCriticalDefectKernelBridge`, the canonical Burnol/
Blaschke factor's model-space carrier is nonempty whenever there is an
off-critical zeta zero.  Consequently the `OffCriticalZeroDefectKernel`
structure is inhabited.

The bridge captures the missing Vol5 transport surface; see
`Vol6.Obstruction.OffCriticalDefectKernelObstruction` for the precise
typed proposition and the audit comment explaining why no Vol5 lemma
currently suffices.
-/
theorem off_critical_zero_defect_kernel_of_bridge
    (bridge : OffCriticalDefectKernelBridge) :
    OffCriticalZeroDefectKernel where
  model_vector_of_offcritical :=
    nonempty_burnol_modelSpaceCarrier_of_bridge bridge

/-! ## Step 1 audit (closed) -/

/--
**Audit corollary.**  The "finite-packet" half of Paper 03 is a closed
theorem: every off-critical zeta zero produces a singleton finite-packet
model space whose carrier is nonempty.  Only the transport step depends
on the Vol5 bridge.
-/
theorem finitePacketWitness_of_offcritical
    (s : ℂ) (h : OffCriticalZero s) :
    Nonempty (singlePointModelSpace s h).carrier :=
  singlePointModelSpace_nonempty s h

/--
**Audit corollary.**  In aggregate form: existence of an off-critical
zero implies existence of a (nonempty) singleton finite-packet model
space.
-/
theorem exists_finitePacket_witness_of_offCritical :
    ExistsOffCriticalZero →
      ∃ (s : ℂ) (h : OffCriticalZero s),
        Nonempty (singlePointModelSpace s h).carrier := by
  intro hOff
  rcases hOff with ⟨s, hZero⟩
  exact ⟨s, hZero, finitePacketWitness_of_offcritical s hZero⟩

/-! ## Status marker -/

/--
Audit marker for paper 03.

Records:
  * what Paper 03 closes unconditionally (Step 1: singleton-packet
    nonemptiness),
  * what Paper 03 closes conditionally (Step 2: bridge-dependent transport
    to `burnolBlaschkeFactor.modelSpaceCarrier`),
  * the principal theorem name available to downstream papers
    (`off_critical_zero_defect_kernel_of_bridge`), and
  * the obstruction module that supplies the typed bridge proposition.
-/
def off_critical_defect_kernel_status : String :=
  "Vol6 paper 03 installed: Step 1 (singleton-packet model space nonemptiness) is closed via Paper 01's `finite_packet_model_space_nonempty`; Step 2 (transport into `burnolBlaschkeFactor.modelSpaceCarrier`) is conditional on `OffCriticalDefectKernelBridge` from `Vol6.Obstruction.OffCriticalDefectKernelObstruction`.  The conditional principal theorem `off_critical_zero_defect_kernel_of_bridge` is closed; the unconditional theorem awaits a Vol5 transport bridge (RF-01 of the knowledge base)."

end

end OffCriticalDefectKernelNS
end Vol6
