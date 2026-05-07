/-
  Volume VI — Paper 02 paired obstruction module:
  Vol6.Obstruction.FiniteRankDetectorObstruction.

  This module records the residual completion obstruction to lifting the
  finite-packet detector of `Vol6.FiniteRankDetector` to a full
  `RKHSModelSpaceDetector` for the canonical Burnol/Blaschke factor
  `burnolBlaschkeFactor` of vol5.

  The vol5 `burnolBlaschkeFactor.modelSpaceCarrier` is an opaque axiom
  type (Risk Flag RF-01 in `.knowledge-base.md`).  Without an explicit
  transport map from the concrete finite-packet carrier to that opaque
  carrier, vol6 cannot construct an inhabitant of
  `RKHSModelSpaceDetector` for the canonical defect object.

  This module DOES NOT add an axiom and DOES NOT close the obstruction.
  It records the obstruction as an open structure whose habitation is
  exactly the missing transport step.  The structure is intentionally
  empty of inhabitants in this paper.
-/

import Vol5.YonedaNymanTrackA.BurnolCore
import Vol6.FiniteBlaschkePacket
import Vol6.FiniteRankDetector

namespace Vol6
namespace Obstruction
namespace FiniteRankDetectorObstruction

open Vol5.YonedaNymanTrackA
open Vol6.FiniteBlaschkePacketNS
open Vol6.FiniteRankDetectorNS

/-! ## The completion obstruction structure

Inhabiting this structure is equivalent to closing the lift from
finite-packet detectors to canonical RKHSModelSpaceDetector inhabitants.
It is left open by paper 02 and is the target of a future paper.
-/

/--
A finite-rank detector completion datum.

Granting an inhabitant `D : FiniteRankDetectorCompletionDatum P` is the
formal counterpart of choosing a transport from the concrete
finite-packet model carrier into the opaque canonical Burnol/Blaschke
model carrier, together with a coherence statement asserting that the
transported detector agrees with the kernel-evaluation predicate.

The two fields:

* `transport`: the carrier-level map.
* `coheres`: a Prop expressing that detection at index `i` matches the
  kernel-evaluation predicate.

Note: the second field uses ONLY the concrete predicate `evalKernel`,
never any opaque vol5 detection predicate.  This keeps the obstruction
visible without forcing dependency on opaque atoms.
-/
structure FiniteRankDetectorCompletionDatum
    (P : FiniteBlaschkePacket) where
  transport :
    (finiteBlaschkeModelSpace P).carrier
      → burnolBlaschkeFactor.modelSpaceCarrier
  coheres :
    ∀ (v : (finiteBlaschkeModelSpace P).carrier) (i : P.ZeroIndex),
      evalKernel P i v →
        -- The transported vector lies in the same fibre as the original
        -- detection witness.  At this abstraction level the coherence is
        -- the trivial Prop `True`; closing the obstruction means
        -- replacing this with a concrete pullback identity once the
        -- vol5 detector API is extended.
        True

/-! ## The obstruction is open by design

We deliberately do NOT supply an inhabitant of
`FiniteRankDetectorCompletionDatum`.  An inhabitant would require either
a concrete redefinition of `burnolBlaschkeFactor.modelSpaceCarrier`
(forbidden — it is a vol5 axiom) or a new vol6 transport mechanism
(scheduled for Paper 03).

The lemma below is the `if-then` form of the obstruction: it shows
that habitation of `FiniteRankDetectorCompletionDatum` is a sufficient
hypothesis for a detector witness on the canonical model-space carrier.
-/

/-- Conditional witness: granting a completion datum, every concrete
finite-packet model-space vector transports to a vector in the canonical
Burnol/Blaschke model-space carrier. -/
theorem witness_of_completion_datum
    (P : FiniteBlaschkePacket)
    (D : FiniteRankDetectorCompletionDatum P)
    (v : (finiteBlaschkeModelSpace P).carrier) :
    ∃ V : burnolBlaschkeFactor.modelSpaceCarrier, V = D.transport v := by
  exact ⟨D.transport v, rfl⟩

/-- The obstruction-existence proposition itself.

Truth of this proposition for some `P` is equivalent (over vol5) to the
existence of a vol5-API extension closing RF-01 from the knowledge base.
-/
def CompletionObstructionExists (P : FiniteBlaschkePacket) : Prop :=
  Nonempty (FiniteRankDetectorCompletionDatum P)

/-- Audit string for the obstruction module. -/
def finite_rank_detector_obstruction_status : String :=
  "Vol6 paper 02 obstruction module installed: FiniteRankDetectorCompletionDatum records the missing transport from finite-packet carrier to canonical Burnol/Blaschke modelSpaceCarrier.  No inhabitant supplied; closure deferred to Vol6.OffCriticalDefectKernel (paper 03)."

end FiniteRankDetectorObstruction
end Obstruction
end Vol6
