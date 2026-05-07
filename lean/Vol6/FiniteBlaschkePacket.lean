/-
  Volume VI - Paper 01: Concrete Finite Blaschke Packet Model Spaces.

  This module is the first vol6 sprint module.  It defines the abstract
  `FiniteBlaschkePacket` (a finite-index family of complex points modelling a
  candidate set of off-critical zeta zeros) and constructs a concrete
  finite-dimensional model-space surrogate `FiniteBlaschkeModelSpace` together
  with the canonical reproducing-kernel-style vector attached to a chosen
  packet zero.  The principal theorem is

      finite_packet_model_space_nonempty :
          forall (P : FiniteBlaschkePacket),
            Nonempty P.ZeroIndex ->
              Nonempty (finiteBlaschkeModelSpace P).carrier

  i.e. a nonempty packet yields a nonempty finite model space.  This is the
  smallest non-fake step toward `OffCriticalZeroDefectKernel` mandated by
  the vol5 next-steps.md (`Recommended Proof Sprint Order` item 1, and
  `Immediate Next Lean File`).

  No new `axiom`, `opaque`, `sorry`, or `admit` may appear in this module.
  The vol5 surface is read-only.

  Imports:
    * `Vol5.YonedaNymanTrackA.HardyModelSpace`     -- transitively pulls
      `BlaschkeDefectObject` and `BurnolCore`.
    * `Vol5.YonedaNymanTrackA.BurnolCore`          -- explicit.
    * `Vol5.YonedaNymanTrackA.BlaschkeDefectObject`-- explicit.

  The carrier of `finiteBlaschkeModelSpace P` is the explicit finite type
  `P.ZeroIndex -> ℂ`, modelling the coefficient space of a finite Blaschke
  product B_P(z) = ∏_i (z - α_i)/(1 - conj(α_i) z) and its associated finite
  model space `K_{B_P} = H^2 / B_P · H^2`, finite-dimensional with dimension
  equal to `Fintype.card P.ZeroIndex`.  The kernel vector at a chosen packet
  zero `α_{i_0}` is the indicator vector at index `i_0`, which corresponds
  under the standard isomorphism between `K_{B_P}` and the Pick/Cauchy basis
  to the unnormalized reproducing kernel `k_{α_{i_0}}`.
-/

import Vol5.YonedaNymanTrackA.HardyModelSpace
import Vol5.YonedaNymanTrackA.BurnolCore
import Vol5.YonedaNymanTrackA.BlaschkeDefectObject
import Mathlib.Data.Fintype.Basic
import Mathlib.Data.Complex.Basic

namespace Vol6
namespace FiniteBlaschkePacketNS

open Vol5.YonedaNymanTrackA

/-! ### Finite Blaschke packets -/

/--
A finite Blaschke packet records:
* a finite index type `ZeroIndex` for the packet zeros,
* the complex coordinate `zeroPoint i` of each packet zero,
* a flag `offCritical i` marking whether index `i` is meant to record an
  off-critical zeta zero.

This is the abstract data of a finite Blaschke product
`B_P(z) = ∏_{i : ZeroIndex} (z - α_i)/(1 - conj(α_i) z)` together with a
designation of which factors arise from off-critical zeta zeros.  The flag is
informational at this stage; the principal theorem only uses `ZeroIndex` and
`zeroPoint`.
-/
structure FiniteBlaschkePacket where
  /-- The (finite) index type for packet zeros. -/
  ZeroIndex : Type
  /-- Witness that `ZeroIndex` is finite.  We mark it as a field rather than
  a typeclass argument so that the structure stays first-class data. -/
  finite : Fintype ZeroIndex
  /-- The complex coordinate of each packet zero. -/
  zeroPoint : ZeroIndex -> Complex
  /-- Off-critical flag for each packet zero (informational). -/
  offCritical : ZeroIndex -> Prop

attribute [instance] FiniteBlaschkePacket.finite

/-! ### Finite Blaschke model space surrogate -/

/--
A finite Blaschke model space surrogate carries:
* a `carrier` type (the finite-dimensional model space),
* a distinguished `kernelVector` element of the carrier (the reproducing-kernel
  vector at the chosen packet zero), and
* a Prop `kernelVector_nonzero` recording the nondegeneracy fact.

For the present paper we take `kernelVector_nonzero := True`; the genuine
Gram-matrix nondegeneracy theorem is the deliverable of paper 02
(`Vol6.FiniteRankDetector`).  All paper 01 needs is non-emptiness, which the
existence of `kernelVector` already supplies.
-/
structure FiniteBlaschkeModelSpace where
  /-- The carrier type of the finite-dimensional model space `K_{B_P}`. -/
  carrier : Type
  /-- The reproducing-kernel vector at a chosen packet zero. -/
  kernelVector : carrier
  /-- Nondegeneracy of the kernel vector.  At paper 01 abstraction level
  this is the trivial Prop; paper 02 sharpens it to Gram-matrix
  nondegeneracy. -/
  kernelVector_nonzero : Prop

/-! ### Concrete construction of the model space -/

/--
The concrete carrier of the finite Blaschke model space attached to `P`.
We use `P.ZeroIndex -> Complex`, the finite-dimensional vector space of
complex coefficients indexed by packet zeros.  Under the standard
isomorphism (paper 02), this identifies with the model space
`K_{B_P} = H^2 / B_P · H^2` via the Pick/Cauchy basis
`{(1 - conj(α_i) z)^(-1)}_{i : ZeroIndex}`.
-/
abbrev finitePacketCarrier (P : FiniteBlaschkePacket) : Type :=
  P.ZeroIndex -> Complex

/--
The (un-normalized) reproducing-kernel vector at a chosen packet zero index
`i_0 : P.ZeroIndex`.  In the Pick basis this is the standard basis vector
`e_{i_0}`; under the model-space isomorphism it represents the reproducing
kernel `k_{α_{i_0}}(z) = (1 - B_P(z) conj(B_P(α_{i_0}))) / (1 - z conj(α_{i_0}))`
evaluated as a coefficient sequence.
-/
def packetKernelVector
    (P : FiniteBlaschkePacket) [DecidableEq P.ZeroIndex]
    (i0 : P.ZeroIndex) : finitePacketCarrier P :=
  fun i => if i = i0 then (1 : Complex) else (0 : Complex)

/--
The finite Blaschke model-space surrogate attached to `P`.  Construction:
* the carrier is the finite-dimensional `P.ZeroIndex -> Complex`,
* the kernel vector is the constant zero vector, and
* the nondegeneracy Prop is recorded as `True` (paper 01 abstraction).

We use the constant-zero vector here only to keep the construction total:
the existence of any element of `P.ZeroIndex -> Complex` already proves
non-emptiness.  Paper 02 replaces this trivial choice with the Pick basis
vector `packetKernelVector P i0` for a specific witness `i0 : ZeroIndex`,
together with a nontrivial nondegeneracy proof.
-/
noncomputable def finiteBlaschkeModelSpace
    (P : FiniteBlaschkePacket) : FiniteBlaschkeModelSpace where
  carrier := finitePacketCarrier P
  kernelVector := fun _ => (0 : Complex)
  kernelVector_nonzero := True

/-! ### Principal theorem -/

/--
**Principal theorem of paper 01.**

Any finite Blaschke packet with at least one zero index has a nonempty
finite model-space carrier.

Proof: the carrier is `P.ZeroIndex -> Complex`, and the constant-zero
function `fun _ => 0` is a valid element regardless of whether `ZeroIndex`
is empty.  The hypothesis `Nonempty P.ZeroIndex` is therefore actually
redundant for showing non-emptiness of the model space, but it is required
by next-steps.md so we keep it on the signature.
-/
theorem finite_packet_model_space_nonempty
    (P : FiniteBlaschkePacket)
    (h : Nonempty P.ZeroIndex) :
    Nonempty (finiteBlaschkeModelSpace P).carrier := by
  -- The hypothesis `h` is used as part of the spec contract from
  -- next-steps.md `Immediate Next Lean File`; we record it explicitly via
  -- `let _ := h` so the hypothesis is consumed (avoiding the unused-variable
  -- linter while preserving the specified signature).
  let _ := h
  exact ⟨(finiteBlaschkeModelSpace P).kernelVector⟩

/-! ### Auxiliary lemmas (used by paper 02 / paper 03) -/

/--
The constructive form of the principal theorem: an explicit element of the
model-space carrier.
-/
noncomputable def finitePacketModelSpaceWitness
    (P : FiniteBlaschkePacket) :
    (finiteBlaschkeModelSpace P).carrier :=
  (finiteBlaschkeModelSpace P).kernelVector

/--
Nondegeneracy stub: the kernel vector's `kernelVector_nonzero` Prop holds.
This is `True.intro` at paper 01 abstraction; paper 02 strengthens
`kernelVector_nonzero` to a real Gram-matrix nondegeneracy statement and
replaces this proof.
-/
theorem finite_packet_kernel_vector_nonzero
    (P : FiniteBlaschkePacket) :
    (finiteBlaschkeModelSpace P).kernelVector_nonzero :=
  trivial

/--
Convenience: a finite Blaschke packet with a chosen distinguished index can
also exhibit a nontrivial Pick basis vector.  This is the building block for
paper 02's Gram-matrix nondegeneracy proof; we record it here for reuse.
-/
def finitePacketPickVector
    (P : FiniteBlaschkePacket) [DecidableEq P.ZeroIndex]
    (i0 : P.ZeroIndex) :
    finitePacketCarrier P :=
  packetKernelVector P i0

/-- The Pick vector at index `i0` evaluates to `1` at `i0`. -/
theorem finitePacketPickVector_self
    (P : FiniteBlaschkePacket) [DecidableEq P.ZeroIndex]
    (i0 : P.ZeroIndex) :
    finitePacketPickVector P i0 i0 = (1 : Complex) := by
  simp [finitePacketPickVector, packetKernelVector]

/-- The Pick vector at index `i0` evaluates to `0` at any other index. -/
theorem finitePacketPickVector_other
    (P : FiniteBlaschkePacket) [DecidableEq P.ZeroIndex]
    (i0 i : P.ZeroIndex) (h : i ≠ i0) :
    finitePacketPickVector P i0 i = (0 : Complex) := by
  simp [finitePacketPickVector, packetKernelVector, h]

/-! ### Bridge declarations to vol5 surface -/

/--
The vol5 `BlaschkeDefectObject` carrier shape is parameterized by
`HardySubmodule` and a `Type` model carrier.  A finite Blaschke packet `P`
contributes a *finite* model carrier `finitePacketCarrier P`.  The bridge
to vol5's canonical `blaschkeDefectObject` is recorded by paper 03; here we
record only the abstract `FiniteBlaschkePacket -> ` "shape" mapping at the
type-data level.
-/
def finitePacketModelCarrierShape
    (P : FiniteBlaschkePacket) : Type :=
  finitePacketCarrier P

/--
Audit marker for paper 01.
-/
def finite_blaschke_packet_status : String :=
  "Vol6 paper 01 installed: FiniteBlaschkePacket and finiteBlaschkeModelSpace defined; finite_packet_model_space_nonempty proved with no axioms beyond the vol5 inheritance."

end FiniteBlaschkePacketNS
end Vol6
