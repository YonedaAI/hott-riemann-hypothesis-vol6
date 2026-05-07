# Vol5 HoTT/Yoneda RH Route: Next Steps

## Current Formal Status

The Vol5 Lean development now has a formal no-phantom language for the RH route.

The key conditional theorem is:

```lean
theorem RH_classical_of_no_phantom_language_breakthrough
    (h : NoPhantomLanguageBreakthrough) :
    RH_classical
```

This proves that RH follows from the named breakthrough payload:

```lean
structure NoPhantomLanguageBreakthrough : Type 1 where
  detectorCalculus : YonedaBlaschkeDetectorCalculus
  offCriticalKernel : OffCriticalZeroDefectKernel
```

This is not yet an unconditional RH proof. It is a verified reduction of RH to
two precise nonclassical payloads.

## New Mathematical Reframing

The route is:

```text
off-critical zero
-> nonzero Burnol/Blaschke defect
-> admissible condensed Hilbert defect
-> Yoneda/RKHS detector sees it
-> no admissible Yoneda-invisible phantom exists
-> contradiction
-> no off-critical zero
-> RH
```

In short:

```text
RH becomes a no-phantom theorem for admissible condensed Hilbert/Blaschke
defect objects.
```

The point is not to improve analytic estimates for zeta. The point is to move
the contradiction into HoTT/Yoneda visibility: a nonzero admissible defect
cannot be invisible to the rational-dilation probes.

## Target 1: OffCriticalZeroDefectKernel

Lean target:

```lean
structure OffCriticalZeroDefectKernel : Prop where
  model_vector_of_offcritical :
    ExistsOffCriticalZero ->
      Nonempty burnolBlaschkeFactor.modelSpaceCarrier
```

Mathematical meaning:

```text
an off-critical zeta zero creates a nonzero vector in K_B = H^2 / B H^2
```

Expected proof route:

```text
off-critical zero
-> corresponding zero in the Burnol Blaschke factor
-> Blaschke factor B is nontrivial
-> model space K_B = H^2 minus B H^2 is nonzero
-> construct a reproducing kernel vector in K_B
```

Why this may be easier than RH:

- It does not prove no off-critical zero exists.
- It proves only that such a zero would create a defect.
- This is standard Hardy/model-space direction once the Burnol factor is made concrete.

Lean work needed:

- Replace the opaque `burnolBlaschkeFactor.modelSpaceCarrier` with a concrete
  model-space carrier.
- Define the zero packet attached to an off-critical zero.
- Prove a nonzero reproducing kernel or quotient class belongs to the model
  space.
- Produce:

```lean
theorem off_critical_zero_defect_kernel :
    OffCriticalZeroDefectKernel
```

## Target 2: YonedaBlaschkeDetectorCalculus

Lean target:

```lean
structure YonedaBlaschkeDetectorCalculus : Type 1 where
  rkhs : BurnolBlaschkeRKHSDetectorSemantics
```

This expands to the canonical RKHS detector payload:

```text
detector
+ rational-dilation externalization
+ quotient orthogonality/invisibility
+ admissibility
```

The mathematical content is:

```text
any nonzero vector in the Burnol/Blaschke defect is detected by a Yoneda
rational-dilation probe, and the defect object is admissible in the condensed
Hilbert setting.
```

Break this into four subtargets.

### 2.1 Detector Completeness

Prove:

```text
nonzero v in K_B
-> some RKHS kernel/jet functional detects v
```

Likely method:

- Use reproducing kernels in Hardy model spaces.
- Start with finite Blaschke packets.
- Prove kernel separation by Gram matrix nondegeneracy.
- Generalize by localization or filtered colimits.

Lean target shape:

```lean
theorem burnol_blaschke_rkhs_detector_complete :
    -- field needed by RKHSModelSpaceDetector
```

### 2.2 Rational-Dilation Externalization

Prove:

```text
each RKHS detector corresponds to a rational-dilation Yoneda representable
```

Likely method:

- Identify rational dilation probes with fractional-part kernels.
- Prove that the detector functional is represented by a `D_Q` object.
- Use the existing `yoneda` and `DQPresheaf` surface.

Lean target shape:

```lean
theorem burnol_blaschke_detector_externalization :
    RKHSDetectorExternalizationToRationalRepresentables ...
```

### 2.3 Quotient Orthogonality and Invisibility

Prove:

```text
the quotient defect is orthogonal to the Nyman/Yoneda image
```

This is where circularity risk is highest.

Allowed:

- Orthogonality by construction of the quotient/model-space object.
- Formal cokernel or orthogonal-complement semantics.

Not allowed:

- Importing Nyman density.
- Using Beurling-Nyman equivalence.
- Assuming RH or internal Blaschke triviality.

Lean target shape:

```lean
theorem burnol_blaschke_quotient_orthogonality :
    QuotientOrthogonalityInvisibility blaschkeDefectObject
```

### 2.4 Admissibility

Prove the three current atoms:

```lean
BlaschkeDefectDualizable blaschkeDefectObject
BlaschkeDefectPolarized blaschkeDefectObject
BlaschkeDefectRegularized blaschkeDefectObject
```

Then assemble:

```lean
theorem burnol_blaschke_defect_is_admissible :
    BurnolBlaschkeDefectIsAdmissible
```

Likely method:

- First prove finite-rank admissibility for finite Blaschke packets.
- Prove stability under the completion/filtered-colimit process used by the
  condensed Hilbert object.
- Use regularized, not raw operator-norm, convergence.

## Recommended Proof Sprint Order

1. Concrete finite-packet model spaces

   Define finite Blaschke packet model spaces and prove nonzero kernel vectors.

2. Finite-rank detector theorem

   Prove a concrete inhabitant of the finite-rank detector semantics for finite
   packets.

3. Finite-packet off-critical defect kernel

   Show an off-critical zero creates a nonzero finite-packet model-space vector.

4. Externalization to rational dilations

   Prove finite packet detectors externalize to rational-dilation Yoneda
   representables.

5. Completion/localization step

   Lift finite-packet semantics to the canonical Burnol/Blaschke defect object.

6. Final assembly

   Prove:

```lean
theorem yoneda_blaschke_detector_calculus :
    YonedaBlaschkeDetectorCalculus

theorem off_critical_zero_defect_kernel :
    OffCriticalZeroDefectKernel

theorem RH_classical_new_language :
    RH_classical :=
  RH_classical_of_no_phantom_language_breakthrough
    { detectorCalculus := yoneda_blaschke_detector_calculus
      offCriticalKernel := off_critical_zero_defect_kernel }
```

## Success Criteria

A real proof must satisfy all of the following:

- `lake build Vol5` passes.
- No new `axiom`, `opaque`, `sorry`, or `admit` appears in the concrete proof
  modules.
- `#print axioms RH_classical_new_language` does not include RH, Nyman density,
  Beurling-Nyman equivalence, or a hidden theorem equivalent to RH.
- `OffCriticalZeroDefectKernel` is proved by model-space construction, not by
  contradiction from RH.
- `YonedaBlaschkeDetectorCalculus` is proved by detector/externalization/
  admissibility semantics, not by assuming `NoPhantomDefect`.

## Immediate Next Lean File

The highest-value next file is:

```text
lean/Vol5/YonedaNymanTrackA/FiniteBlaschkePacket.lean
```

Initial contents should define:

```lean
structure FiniteBlaschkePacket where
  ZeroIndex : Type
  finite : Fintype ZeroIndex
  zeroPoint : ZeroIndex -> ℂ
  offCritical : ZeroIndex -> Prop

structure FiniteBlaschkeModelSpace where
  carrier : Type
  kernelVector : carrier
  kernelVector_nonzero : Prop
```

The first concrete theorem should be:

```lean
theorem finite_packet_model_space_nonempty
    (P : FiniteBlaschkePacket)
    (h : Nonempty P.ZeroIndex) :
    Nonempty (finiteBlaschkeModelSpace P).carrier
```

That is the smallest nonfake step toward `OffCriticalZeroDefectKernel`.
