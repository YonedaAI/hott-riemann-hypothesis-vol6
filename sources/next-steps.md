# Vol6 Next Steps

## Current Status

Vol6 now has a verified transparent Vol5.5 adapter layer:

- `TransparentNoPhantomPackage -> RH_classical`
- `Vol6FinalObstruction -> TransparentNoPhantomPackage`
- `StrengthenedFinitePacketTransportPackage` is equivalent to the existing
  `OffCriticalDefectKernelBridge`
- no new `sorry`, `admit`, `axiom`, or `opaque` in the Vol5.5 layer
- `lake build Vol6` passes

This is not yet an unconditional proof of RH.  The current Lean result is an
exact repackaging theorem: the Vol6 obstruction fields have the right shape to
feed the transparent no-phantom route.

## What Is Solved

### 1. No-phantom route shape

The Vol5.5 layer proves that explicit transparent no-phantom inputs produce:

- `NoPhantomDefect`
- `OffCriticalZeroCreatesDefect`
- `NoPhantomLanguageBreakthrough`
- `RH_classical`

The assembly target is:

```lean
TransparentNoPhantomPackage
```

and the final route is:

```lean
RH_classical_of_transparent_no_phantom_package
```

### 2. Strengthened transport bookkeeping

The nonzero-defect part of `StrengthenedFinitePacketTransportPackage` is no
longer an extra Lean obstruction once a real transport into the canonical
Burnol carrier is available.

Reason: Vol5 currently defines zero defect through emptiness of the canonical
model carrier.  Therefore any transported vector in that carrier contradicts
zero defect.

The exact audit theorem is:

```lean
nonempty_strengthenedFinitePacketTransportPackage_iff_nonempty_bridge
```

So the remaining transport problem is still the old hard bridge:

```lean
OffCriticalDefectKernelBridge
```

### 3. Vol6 obstruction repackaging

The theorem:

```lean
transparentNoPhantomPackage_of_vol6FinalObstruction
```

shows that the four fields of `Vol6FinalObstruction` repackage into the
transparent package.

## What Remains

### A. Real finite-packet-to-canonical transport

Construct an inhabitant of:

```lean
OffCriticalDefectKernelBridge
```

without using a constant map from arbitrary carrier nonemptiness.

The transport must come from actual mathematics:

1. off-critical zeta zero
2. singleton finite Blaschke packet
3. finite model-space vector
4. canonical Burnol/Blaschke model-space vector

The bridge must explain why the finite packet model embeds, maps, or limits
into the canonical Burnol carrier.

### B. Non-vacuous detector relation

Construct a real detector package for:

```lean
TransparentNoPhantomInputs.detector
TransparentNoPhantomInputs.detection
```

Do not use the empty detector.  The empty detector assumes
`InternalBlaschkeTriviality`, which is downstream of the contradiction.

The detector relation must produce the existing Vol6 field:

```lean
ExternalizationIntroductionRule
```

### C. Quotient invisibility

Construct:

```lean
QuotientOrthogonalityInvisibility blaschkeDefectObject
```

or equivalently the current canonical introduction package:

```lean
CanonicalQuotientOrthogonalityIntroduction
```

This is the cokernel rule: Yoneda/Nyman image representables must fail to
detect the quotient defect.

### D. Admissibility certificates

Construct:

```lean
BurnolBlaschkeTransparentAdmissibilityData
```

or equivalently:

```lean
CanonicalAdmissibilityIntroduction
```

The three real obligations are:

- `BlaschkeDefectDualizable blaschkeDefectObject`
- `BlaschkeDefectPolarized blaschkeDefectObject`
- `BlaschkeDefectRegularized blaschkeDefectObject`

## Recommended Sprint Order

1. **Transport sprint**
   - Target: `OffCriticalDefectKernelBridge`
   - Output: actual nonconstant transport from finite packet model spaces into
     the canonical Burnol carrier
   - Gate: `lake build Vol6` and axiom audit

2. **Cokernel invisibility sprint**
   - Target: `CanonicalQuotientOrthogonalityIntroduction`
   - Output: Yoneda/Nyman image representables are not detected by the quotient
     defect
   - Gate: no Nyman density, no Beurling-Nyman, no RH assumption

3. **Detector externalization sprint**
   - Target: `ExternalizationIntroductionRule`
   - Output: non-vacuous detector-indexed rational-dilation detection
   - Gate: no empty-detector shortcut

4. **Admissibility sprint**
   - Target: `CanonicalAdmissibilityIntroduction`
   - Output: dualizable, polarized, and regularized certificates
   - Gate: certificates map into the existing Vol5 predicates without new
     axioms

5. **Final assembly sprint**
   - Target: inhabit `TransparentNoPhantomPackage`
   - Output: apply `RH_classical_of_transparent_no_phantom_package`
   - Gate: final `#print axioms` contains no RH, Nyman density, or
     Beurling-Nyman assumptions

## Audit Commands

Run after every proof sprint:

```bash
cd lean
lake build Vol6
rg -n "^\\s*(axiom|opaque)\\b|\\bsorry\\b|\\badmit\\b" \
  Vol6/Vol5_5 Vol6/Vol5_5.lean
```

For final theorem audits:

```bash
cd lean
lake env lean <(printf '%s\n' \
  'import Vol6.Vol5_5' \
  '#print axioms Vol6.Vol5_5.RH_classical_of_transparent_no_phantom_package')
```

## Claim Discipline

Do not claim an unconditional no-phantom RH proof until Lean contains an
inhabitant of:

```lean
TransparentNoPhantomPackage
```

with no new `axiom`, no new `opaque`, no `sorry`, and no `admit`.

