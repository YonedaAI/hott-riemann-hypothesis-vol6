/-
  Volume VI — Paper 03 obstruction module.

  Paper 03 (`Vol6.OffCriticalDefectKernel`) targets

      theorem off_critical_zero_defect_kernel : OffCriticalZeroDefectKernel

  whose underlying field demands

      ExistsOffCriticalZero ->
        Nonempty burnolBlaschkeFactor.modelSpaceCarrier .

  The intended mathematical proof route is

      off-critical zeta zero  s
        ↦  Möbius image  α(s) = (s - 1) / (s + 1)  ∈ closed unit disc
        ↦  zero of the Burnol/Blaschke factor  B  at  α(s)
        ↦  singleton finite Blaschke packet  P_s = { α(s) }
        ↦  Paper 01 finite_packet_model_space_nonempty  ⇒
              Nonempty (finiteBlaschkeModelSpace P_s).carrier
        ↦  TRANSPORT  ⇒
              Nonempty burnolBlaschkeFactor.modelSpaceCarrier .

  The TRANSPORT step requires Vol5 to expose at least one of

      (a)  an explicit identification

              (finiteBlaschkeModelSpace P).carrier
                = burnolBlaschkeFactor.modelSpaceCarrier ;

      (b)  an injection

              (finiteBlaschkeModelSpace P).carrier
                ↪ burnolBlaschkeFactor.modelSpaceCarrier ;

      (c)  a constructor / introduction rule

              (finiteBlaschkeModelSpace P).carrier
                → burnolBlaschkeFactor.modelSpaceCarrier .

  A direct survey of the Vol5 surface
  (`BurnolCore.lean`, `BurnolFactorization.lean`, `BlaschkeDefectObject.lean`,
  `NoPhantomLanguage.lean`, etc.) shows that Vol5 declares

      axiom burnolBlaschkeFactor : BurnolBlaschkeFactor

  with the field `modelSpaceCarrier : Type` opaquely supplied by the axiom,
  and provides NO theorem, function, or instance whose conclusion is any of

      (X = burnolBlaschkeFactor.modelSpaceCarrier)
      (X ↪ burnolBlaschkeFactor.modelSpaceCarrier)
      (X → burnolBlaschkeFactor.modelSpaceCarrier)

  for any concrete `X`.  This is risk flag RF-01 of the Vol6 knowledge base
  (.knowledge-base.md §8): the carrier is opaque and currently uninhabitable.

  This module therefore states the precise required bridge as a typed
  proposition, in compliance with the worker contract:

      "If NONE of these exist in vol5, you MUST ship
       `Vol6/Obstruction/OffCriticalDefectKernelObstruction.lean` that states
       the precise required bridge as a typed proposition."

  No `sorry`, `admit`, new `axiom`, or new `opaque` is introduced.  The
  obstruction is a plain `Prop`-valued bridge whose inhabitation is the
  remaining mathematical content; once any of the three Vol5 bridges (a),
  (b), or (c) becomes available, the bridge can be inhabited and Paper 03's
  conditional theorem (`off_critical_zero_defect_kernel_of_bridge`,
  declared in `Vol6.OffCriticalDefectKernel`) discharges the principal
  theorem unconditionally.
-/

import Vol5.YonedaNymanTrackA.NoPhantomLanguage
import Vol5.YonedaNymanTrackA.OffCriticalZeroDefect
import Vol5.YonedaNymanTrackA.BurnolCore
import Vol6.FiniteBlaschkePacket

namespace Vol6
namespace Obstruction

open Vol5.YonedaNymanTrackA
open Vol6.FiniteBlaschkePacketNS

/-! ## Möbius parameter map -/

/--
The Möbius transformation that sends the right half-plane `{s : ℂ | s.re > 0}`
to the open unit disc, normalized so that `s = 1` (the trivial pole of zeta)
maps to `0` and the critical line `s.re = 1/2` maps to the unit circle.

Concretely, `mobiusParam s = (s - 1) / (s + 1)`.  For an off-critical zeta
zero `s` (so `0 < s.re < 1` and `s.re ≠ 1/2`), the image `mobiusParam s` is
in the open unit disc `|α| < 1`, and *off* the unit circle and *off* zero.
This is the parameter at which the Burnol/Blaschke factor `B(α)` is meant to
have a zero matching the original zeta zero.
-/
noncomputable def mobiusParam (s : ℂ) : ℂ :=
  (s - 1) / (s + 1)

/-- `mobiusParam` sends `s = 1` to `0`. -/
theorem mobiusParam_one : mobiusParam (1 : ℂ) = 0 := by
  simp [mobiusParam]

/-! ## The required transport bridge -/

/--
**The precise Vol5 transport bridge required by Paper 03.**

This `Type 1` family states that for every nonempty finite Blaschke packet
`P`, there is a function from the finite-packet model-space carrier
`(finiteBlaschkeModelSpace P).carrier` into the canonical Burnol/Blaschke
model-space carrier `burnolBlaschkeFactor.modelSpaceCarrier`.

The hypothesis `Nonempty P.ZeroIndex` is the same nonemptiness witness used
by Paper 01's `finite_packet_model_space_nonempty`.  Inhabiting this type
amounts to providing one of the three Vol5 bridges (a)–(c) above.  Because
the carrier types are arbitrary `Type`s, the transport is genuinely data
(not just a proposition); the bridge therefore lives one universe up.

Note: we do *not* require the function to be injective, an isomorphism, or
otherwise structured.  Mere existence of a function is sufficient to
transport the Paper-01 nonemptiness witness, since `Nonempty` is preserved
by arbitrary functions.
-/
def FiniteBlaschkePacketCarrierTransport : Type 1 :=
  ∀ (P : FiniteBlaschkePacket), Nonempty P.ZeroIndex →
    ((finiteBlaschkeModelSpace P).carrier →
      burnolBlaschkeFactor.modelSpaceCarrier)

/--
The Paper 03 obstruction: a typed structure whose inhabitation is exactly
the missing Vol5 transport bridge.  This is the *minimal* additional input
required to discharge `off_critical_zero_defect_kernel` as a closed
theorem.

The structure is intentionally weak: it asks only for a function producing
elements of `burnolBlaschkeFactor.modelSpaceCarrier` from nonempty finite
packets.  Stronger forms (an isomorphism, an injection, equality of
carriers) would also suffice, but are not necessary for Paper 03.

`Type 1` rather than `Prop` because the underlying data is genuinely
type-level (a function between `Type`s).
-/
structure OffCriticalDefectKernelBridge : Type 1 where
  /-- The required transport: every nonempty finite Blaschke packet model
  space maps into `burnolBlaschkeFactor.modelSpaceCarrier`. -/
  transport : FiniteBlaschkePacketCarrierTransport

/-! ## Reduction lemmas -/

/--
A weaker but equivalent formulation: it suffices to provide a bridge for
*singleton* packets, i.e. those with `Fin 1` index type.  Paper 03 only
ever instantiates the singleton packet attached to the off-critical zero
provided by `ExistsOffCriticalZero`.
-/
def SingletonBlaschkePacketCarrierTransport : Type 1 :=
  ∀ (P : FiniteBlaschkePacket),
    P.ZeroIndex = (Fin 1) →
      ((finiteBlaschkeModelSpace P).carrier →
        burnolBlaschkeFactor.modelSpaceCarrier)

/--
The full transport bridge yields the singleton bridge.  This is immediate;
we record it for downstream use.
-/
def singleton_transport_of_full_transport
    (h : FiniteBlaschkePacketCarrierTransport) :
    SingletonBlaschkePacketCarrierTransport :=
  fun P hEq =>
    -- Use the equality `P.ZeroIndex = Fin 1` to derive `Nonempty P.ZeroIndex`.
    h P (hEq ▸ (⟨(0 : Fin 1)⟩ : Nonempty (Fin 1)))

/-! ## Audit marker -/

/--
Audit marker for the Paper 03 obstruction.  Captures (i) what Paper 03
needed, (ii) why Vol5 cannot provide it directly, and (iii) the precise
typed proposition that, once inhabited, closes the obstruction.
-/
def off_critical_defect_kernel_obstruction_status : String :=
  "Vol6 paper 03 obstruction installed: `burnolBlaschkeFactor.modelSpaceCarrier` is supplied by `axiom burnolBlaschkeFactor` in Vol5 (BurnolCore.lean line 42) with no introduction rule, so the transport from `(finiteBlaschkeModelSpace P).carrier` to `burnolBlaschkeFactor.modelSpaceCarrier` cannot be proved internally.  The required bridge is the typed proposition `OffCriticalDefectKernelBridge`, whose inhabitant is the missing Vol5 surface lemma (RF-01 in the knowledge base)."

end Obstruction
end Vol6
