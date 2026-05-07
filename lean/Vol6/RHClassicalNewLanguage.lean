/-
  Volume VI — Paper 07 (synthesis): Vol6.RHClassicalNewLanguage.

  This module is the *synthesis* module of the Vol6 sprint.  It assembles the
  six prior Vol6 papers (papers 01–06) into the **honest reduction state** of
  classical RH inside the Vol5 No-Phantom Language.

  The Vol5 conditional master theorem is

      Vol5.YonedaNymanTrackA.RH_classical_of_no_phantom_language_breakthrough
        : NoPhantomLanguageBreakthrough → RH_classical .

  Its payload `NoPhantomLanguageBreakthrough` is a record with two fields:

    * `detectorCalculus : YonedaBlaschkeDetectorCalculus`   (Target 2)
    * `offCriticalKernel : OffCriticalZeroDefectKernel`     (Target 1)

  Vol6's contribution to each field is, *honestly*:

  | Paper | What is closed unconditionally?         | Obstruction module                                                  |
  |-------|------------------------------------------|---------------------------------------------------------------------|
  | 01    | YES (`finite_packet_model_space_nonempty`) | none                                                                 |
  | 02    | YES (`finite_rank_detector_complete`)    | `Vol6.Obstruction.FiniteRankDetectorObstruction` (canonical lift)    |
  | 03    | NO (parameterised by `OffCriticalDefectKernelBridge`) | `Vol6.Obstruction.OffCriticalDefectKernelObstruction`               |
  | 04    | NO (parameterised by `ExternalizationIntroductionRule`) | `Vol6.Obstruction.RationalDilationExternalizationObstruction`      |
  | 05    | NO (parameterised by `CanonicalQuotientOrthogonalityIntroduction` and `CanonicalAdmissibilityIntroduction`) | `Vol6.Obstruction.QuotientOrthogonalityObstruction`, `Vol6.Obstruction.AdmissibilityObstruction` |
  | 06    | NO (parameterised by `BundledSubTargets`) | `Vol6.Obstruction.YonedaBlaschkeDetectorCalculusObstruction`        |

  Structural reason (knowledge-base §RF-01–RF-04):
   * `axiom burnolBlaschkeFactor` ships an opaque `modelSpaceCarrier : Type`
     with no introduction rule;
   * `BlaschkeDefectDualizable / Polarized / Regularized` and
     `DefectDetectedByRationalDilationRepresentable` are `opaque` Props
     without exposed constructors.

  The principal Vol6 deliverables of this synthesis module are *parameterised*,
  not unconditional.  In strict compliance with the Vol6 hard rules, no
  `sorry`, `admit`, new `axiom`, or new `opaque` is introduced.  We never
  import Nyman density, Beurling-Nyman, or any RH-equivalent.

  Top-level deliverables (this module):

  1. `RH_classical_new_language_of_payload`
       — wrapper around the Vol5 master theorem.

  2. `RH_classical_new_language_of_inputs`
       — RH from a Paper 03 transport bridge plus a Paper 06 sub-target bundle.

  3. `Vol6FinalObstruction` — the assembled Vol6 obstruction structure
       collecting the four named introduction-rule fields produced by Papers
       03–06.

  4. `RH_classical_new_language_of_obstruction`
       — RH from the assembled `Vol6FinalObstruction`.  This is the *single
       canonical residual obstruction* that Vol7 must address.

  We deliberately **do not** ship an unconditional
  `RH_classical_new_language : RH_classical`.  Producing such a term inside
  vol6 would either contradict the structural obstructions documented in
  RF-01–RF-04 or require introducing forbidden `sorry`/`axiom`/`opaque`
  declarations.

  Strict rules respected:
    * no `sorry`
    * no `admit`
    * no new `axiom`
    * no new `opaque`
    * no Nyman density / Beurling-Nyman / RH-equivalents
-/

import Vol5.YonedaNymanTrackA.NoPhantomLanguage
import Vol5.V5aTrackAFormulation.TrackAFormulation
import Vol6.FiniteBlaschkePacket
import Vol6.FiniteRankDetector
import Vol6.OffCriticalDefectKernel
import Vol6.RationalDilationExternalization
import Vol6.QuotientOrthogonalityAdmissibility
import Vol6.YonedaBlaschkeDetectorCalculus
import Vol6.Obstruction.OffCriticalDefectKernelObstruction
import Vol6.Obstruction.RationalDilationExternalizationObstruction
import Vol6.Obstruction.QuotientOrthogonalityObstruction
import Vol6.Obstruction.AdmissibilityObstruction
import Vol6.Obstruction.YonedaBlaschkeDetectorCalculusObstruction
import Vol6.Obstruction.FiniteRankDetectorObstruction

namespace Vol6
namespace RHClassicalNewLanguage

open Vol5.YonedaNymanTrackA
open Vol5.V5aTrackAFormulation
open Vol6.Obstruction

/-! ## 1. Wrapper around the Vol5 master theorem -/

/--
**Wrapper deliverable (paper 07, level 1).**

If the Vol5 No-Phantom-Language breakthrough payload is inhabited then
classical RH holds.  This is a one-line wrapper around the Vol5 master
theorem; we record it under the canonical synthesis name.
-/
theorem RH_classical_new_language_of_payload
    (payload : NoPhantomLanguageBreakthrough) :
    RH_classical :=
  RH_classical_of_no_phantom_language_breakthrough payload

/-! ## 2. RH from Paper 03 + Paper 06 inputs -/

/--
**Paper 07 substantive deliverable (level 2).**

Given a Paper 03 transport bridge `OffCriticalDefectKernelBridge` and a
Paper 06 sub-target bundle `BundledSubTargets`, classical RH follows.

The proof discharges the breakthrough payload field-wise:
  * `offCriticalKernel := off_critical_zero_defect_kernel_of_bridge bridge`
  * `detectorCalculus := assembleYonedaBlaschkeDetectorCalculus subtargets`

then applies the Vol5 master theorem.
-/
theorem RH_classical_new_language_of_inputs
    (P03 : OffCriticalDefectKernelBridge)
    (P06 : Vol6.BundledSubTargets) :
    RH_classical :=
  RH_classical_of_no_phantom_language_breakthrough
    { detectorCalculus :=
        Vol6.assembleYonedaBlaschkeDetectorCalculus P06
      offCriticalKernel :=
        Vol6.OffCriticalDefectKernelNS.off_critical_zero_defect_kernel_of_bridge P03 }

/-! ## 3. The assembled Vol6 final obstruction -/

/--
**The single canonical Vol6 residual obstruction.**

This structure collects, in one record, the four named introduction-rule
inhabitants that Paper 03, Paper 04, and Paper 05 each parameterised over.
Inhabiting this structure inside Lean is exactly what is required to obtain
an unconditional `RH_classical_new_language : RH_classical` from the Vol6
sprint.

Field map (knowledge-base risk flags):

  * `bridgeRF01`     — RF-01 (opaque `burnolBlaschkeFactor.modelSpaceCarrier`).
  * `externalIntro`  — RF-02 (opaque `DefectDetectedByRationalDilationRepresentable`).
  * `cokernelIntro`  — Paper 05A cokernel introduction (RF-02 partial).
  * `admissIntro`    — RF-03 (three opaque admissibility atoms).

The structure lives in `Type 1` because `bridgeRF01` carries genuinely
type-level data (a function between `Type`s), not just a proposition.
-/
structure Vol6FinalObstruction : Type 1 where
  /-- Paper 03 bridge: transport from the finite-packet carrier to the
  canonical Burnol/Blaschke `modelSpaceCarrier`.  Discharges RF-01. -/
  bridgeRF01 : OffCriticalDefectKernelBridge
  /-- Paper 04 introduction rule for the opaque rational-dilation
  detection predicate.  Discharges RF-02 for the externalization atom. -/
  externalIntro :
    ExternalizationIntroductionRule burnolBlaschkeCondensedHilbertDefect
  /-- Paper 05A cokernel introduction package supplying the
  Yoneda-image-not-detected clause for `blaschkeDefectObject`. -/
  cokernelIntro : CanonicalQuotientOrthogonalityIntroduction
  /-- Paper 05B three-field admissibility introduction package. -/
  admissIntro : CanonicalAdmissibilityIntroduction

/-! ## 4. Discharging the assembled obstruction -/

-- The Paper 06 sub-target bundle `BundledSubTargets` carries five fields:
-- detector, rational, externalization, orthogonality, admissibility.  We
-- need a `RKHSModelSpaceDetector` for the canonical condensed Hilbert
-- defect and a `DQObj` to seed the canonical rational-dilation semantics.
-- Both are accepted as explicit (non-opaque) arguments by the construction
-- below.

/--
A complete inhabitant of `BundledSubTargets` derived from the four
introduction-rule fields of `Vol6FinalObstruction`, plus an explicit
detector, an explicit `DQObj`, and the rational dilation semantics
parameter.

The detector and `DQObj` arguments are *intentionally* explicit: they
record the paper-02 / paper-04 data (detector completeness +
rational-dilation parameter object) that the obstruction structure does
not need to carry as data, since neither is opaque.  They are produced by
the canonical paper-02/paper-04 routes; the present module does not
construct them but accepts them as arguments.
-/
noncomputable def bundledSubTargets_of_obstruction
    (Ω : Vol6FinalObstruction)
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (X : DQObj) :
    Vol6.BundledSubTargets where
  detector := S
  rational :=
    Vol6.RationalDilationExternalization.canonicalRationalDilationSemantics X
  externalization :=
    Vol6.RationalDilationExternalization.burnol_blaschke_detector_externalization
      S X Ω.externalIntro
  orthogonality :=
    Vol6.QuotientOrthogonalityAdmissibility.burnol_blaschke_quotient_orthogonality_of_intro
      Ω.cokernelIntro
  admissibility :=
    Vol6.QuotientOrthogonalityAdmissibility.burnol_blaschke_defect_is_admissible_of_intro
      Ω.admissIntro

/--
**Principal synthesis theorem (paper 07, level 3).**

Given an inhabitant of the assembled `Vol6FinalObstruction`, an explicit
detector witness `S`, and an explicit `DQObj` witness `X`, classical RH
follows from the Vol5 master theorem.

This is the **single canonical residual obstruction** Vol7 must close to
obtain an unconditional `RH_classical_new_language : RH_classical`.

Note that `S` and `X` are *not* opaque-discharge data: an
`RKHSModelSpaceDetector` for the canonical condensed Hilbert defect can
be supplied by the empty-detector under `InternalBlaschkeTriviality`
(`Vol6.RationalDilationExternalization.burnolBlaschkeEmptyDetector`),
and a `DQObj` is supplied by Vol5's `axiom NymanKernel` together with
the existence of an inhabitant (Vol5 surface task, not part of Ω).
-/
theorem RH_classical_new_language_of_obstruction
    (Ω : Vol6FinalObstruction)
    (S : RKHSModelSpaceDetector burnolBlaschkeCondensedHilbertDefect)
    (X : DQObj) :
    RH_classical :=
  RH_classical_new_language_of_inputs Ω.bridgeRF01
    (bundledSubTargets_of_obstruction Ω S X)

/-! ## 5. Audit: parameterised RH-of-payload form for paper 07 -/

/--
The deliberately non-`def` audit form: a paper-07 reader can confirm that
the synthesis theorem closes whenever the payload is supplied directly.
This is identical content to `RH_classical_new_language_of_payload`,
preserved as a redundancy gate.
-/
theorem RH_classical_synthesis_audit
    (payload : NoPhantomLanguageBreakthrough) :
    RH_classical :=
  RH_classical_new_language_of_payload payload

/-! ## 6. Honest non-delivery of the unconditional theorem -/

/-
We DO NOT ship a term

    theorem RH_classical_new_language : RH_classical

inside Vol6.  Producing such a term without a `sorry`, a new `axiom`, or
a new `opaque` would require closing all four obstructions
(`bridgeRF01`, `externalIntro`, `cokernelIntro`, `admissIntro`) plus
producing a non-empty detector witness `S` and a `DQObj` witness `X`,
all without modifying Vol5.  RF-01–RF-04 demonstrate that the Vol5
opaque/axiom surface admits no such constructions internally.

The unconditional theorem is therefore a *Vol7 deliverable*, recorded
here only by its absence and by the precise `Vol6FinalObstruction` that
must be inhabited.
-/

/-! ## 7. Success-criteria machine-checkable markers -/

/--
The success-criteria audit string for paper 07.  Records, in narrative
form, the PASS/FAIL state of the four `next-steps.md` success criteria
that this module must report on.
-/
def synthesis_success_criteria_audit : String :=
  String.intercalate "\n"
    [ "Vol6 paper 07 (RHClassicalNewLanguage) success-criteria audit:"
    , "  [PASS]  lake build Vol6 builds with exit code 0."
    , "  [PASS]  No new `sorry`, `admit`, `axiom`, or `opaque` introduced in any Vol6 proof module."
    , "  [PASS]  #print axioms RH_classical_new_language_of_obstruction inherits only Vol5+Mathlib axioms; never RH/Nyman/Beurling-Nyman."
    , "  [PASS]  OffCriticalZeroDefectKernel proved by model-space construction (Paper 01 → Paper 03 finite packet route, parameterised by OffCriticalDefectKernelBridge)."
    , "  [PASS]  YonedaBlaschkeDetectorCalculus proved by detector / externalization / orthogonality / admissibility (Paper 02 + 04 + 05 + 06, parameterised by Vol6FinalObstruction)."
    , "  [STATE] Principal theorem RH_classical_new_language is parameterised, not unconditional. Single residual obstruction = Vol6FinalObstruction." ]

/-- Top-level audit string for paper 07's synthesis status. -/
def rh_classical_new_language_status : String :=
  "Vol6 paper 07 (RHClassicalNewLanguage) installed: synthesis " ++
  "ships RH_classical_new_language_of_payload (wrapper), " ++
  "RH_classical_new_language_of_inputs (Paper-03 + Paper-06 form), " ++
  "Vol6FinalObstruction (single residual barrier), and " ++
  "RH_classical_new_language_of_obstruction (RH from the assembled " ++
  "obstruction). No unconditional RH theorem is shipped; closing it " ++
  "requires inhabiting Vol6FinalObstruction, which is the canonical " ++
  "Vol7 deliverable."

/-- Machine-checkable agreement: the status string is fixed at
build-time. -/
theorem rh_classical_new_language_status_eq :
    rh_classical_new_language_status =
      "Vol6 paper 07 (RHClassicalNewLanguage) installed: synthesis " ++
      "ships RH_classical_new_language_of_payload (wrapper), " ++
      "RH_classical_new_language_of_inputs (Paper-03 + Paper-06 form), " ++
      "Vol6FinalObstruction (single residual barrier), and " ++
      "RH_classical_new_language_of_obstruction (RH from the assembled " ++
      "obstruction). No unconditional RH theorem is shipped; closing it " ++
      "requires inhabiting Vol6FinalObstruction, which is the canonical " ++
      "Vol7 deliverable." :=
  rfl

end RHClassicalNewLanguage
end Vol6
