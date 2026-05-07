# Next Steps — Volume V

> *The final volume: prove the Riemann Hypothesis categorically, inside the elementary $(\infty,1)$-topos $\mathcal{E}_{\mathrm{cond}}$ established in Volume IV. Single volume, AI-driven, all teams concurrent from day 1, both formal-proof routes pursued in parallel.*

## What Volume IV did, and where it stopped

Volume IV ("From Formulation to Formal Proof") moved the programme from precise formulations to machine-checked content. The end-of-volume verdict matrix:

| | Valid | Invalid | Incomplete |
|---|---:|---:|---:|
| Total (Lean) | **62** | **0** | **29** |

Volume IV's actual deliverables:

- **OQ1** — coinductive $\zeta(2k)$ formalised as a Cubical Agda starter (with explicit boundary postulates `B1`–`B4` gated on `Cubical.HITs.CauchyReals`) plus a Lean shadow proving the $k=1$ contractibility theorem with `sorry`-count zero.
- **OQ3** — a structural *no-go theorem* (the GWB four-step pattern cannot be lifted to the Segal universe within `TTT` alone) and a *half-reduction* (DU-Seg ⇒ closure of $K_{\mathsf{CSS}}$ under the lax pullback). The reverse direction was sharpened to the *cosmos-internal Yoneda conjecture*, exposed in `lean/Oq3DirectedUnivalence.lean` as `axiom half_reduction`.
- **OQ5** — the candidate $(\infty,1)$-topos $\mathcal{E}_{\mathrm{cond}}$ was settled to be elementary in the *universe-stratified* Rasekh sense at every $\kappa\geq\aleph_1$. The actual Volume III gap was sharpened from "is $\mathcal{E}_{\mathrm{cond}}$ elementary?" (yes) to the *Universe-Coherence Question* (UCQ): which cardinal $\kappa$ houses adeles + $\mathrm{GL}$ + smooth reps + automorphic reps + $L$-function map simultaneously? Conjectured tight bound: $\kappa=\aleph_\omega$.
- **Cross-cutting infrastructure**:
  1. `infra-mathlib-cache` — empirically validated: `lake build` clean in 4.8s with 8020 cached oleans against `mathlib4` commit `0f9072d` on `leanprover/lean4:v4.30.0-rc2`.
  2. `infra-cauchy-reals` — 7 of 9 Booij–Mörtberg gaps in `Cubical.HITs.CauchyReals` closed by direct constructive proof; 2 conditional (Markov / propositional closeness).
  3. `infra-comparison-lemmas` — Lean library exposing 9 sorry-free named theorems (`TheoremA_forward`, `TheoremA_reverse`, `TheoremB_forward`, six corollaries including `corollary_zeta_free_RH_substatements`) parameterised over an interpretation functor. `ConjectureC_reverse` exposed as a single explicit `axiom`.

So Volume IV closed Volume III's research-grade questions to the extent the existing tooling allows, and produced the substrate (working Lean+Mathlib pipeline, Codex `gpt-5.5` `xhigh` proof verification, Gemini peer review) on which Volume V runs.

---

## Volume V's mission

**Prove the Riemann Hypothesis** — the original target of the programme — using the categorical machinery that Volume V *itself builds* alongside the proof attempt.

Volume V is the **final volume and a single AI-driven concurrent run**. It does not gate proof attempts on infrastructure completion. Infrastructure libraries, deferred deliverables, formulations, and proof attempts all run in **13 parallel agent teams from day 1**, syncing through shared Lean libraries and Codex verification. Proof teams refine continuously against whatever infrastructure is current at the moment.

Both formal-proof routes are pursued in parallel:

- **Track A — Langlands-categorical.** RH for $\zeta$ as the GL$_1$ special case of the (formal) Generalised Riemann Hypothesis for automorphic $L$-functions inside $\mathcal{E}_{\mathrm{cond}}$, via a categorical realisation of the Hilbert–Pólya programme. Crux: categorical self-adjointness inside $\mathcal{E}_{\mathrm{cond}}$.
- **Track B — Cohomological / arithmetic-site.** RH via a Weil–Deligne cohomological argument transferred from the function-field case (Deligne 1974) to the number-field case using Connes' arithmetic site, formalised inside $\mathcal{E}_{\mathrm{cond}}$ via condensed étale cohomology. Crux: Frobenius-purity bound over $\mathbb{Z}$.

The two cruxes are not the same obstruction (Track A is operator-theoretic; Track B is cohomological). Pursuing both in parallel is the only way Volume V's "final volume" claim can be honest.

### Termination conditions

Volume V terminates when **one** of the following holds:

1. **RH proven on either track.** `theorem RiemannHypothesis` machine-checked by Lean 4 + Mathlib + Volume V's own libraries, independently re-verified by Codex `gpt-5.5` `model_reasoning_effort=xhigh`. Programme ends with proof.
2. **Both tracks return obstruction theorems.** Each track produces a precisely-quantified obstruction (`theorem ObstructionTrackA`, `theorem ObstructionTrackB`) localising the irreducible mathematical barrier on its side. Programme ends with the most precise statement to date of *exactly which* categorical obstacles block RH from inside $\mathcal{E}_{\mathrm{cond}}$.

There is no Volume VI under either termination.

---

## The 13 concurrent agent teams

All 13 teams start at day 1. None waits on another. Inter-team synchronisation is via shared Lean libraries committed to `lean/` and continuous Codex re-verification on every commit. Proof teams (V6a, V6b) refine against the infrastructure as it lands; they do not gate on it.

| Team | Goal |
|---|---|
| **V1** | Close cosmos-internal Yoneda — proves OQ3 reverse direction; replaces `axiom half_reduction` with a theorem |
| **V2** | Resolve UCQ at $\kappa=\aleph_\omega$ — internally-coherent automorphic representations at a single universe |
| **V3** | Cubical Agda merge: `CauchyReals` + `CoalgebraicZeta` upstream into `agda/cubical`; discharge B1–B4 |
| **V4** | Discharge `ConjectureC_reverse` — constructive ZFC↔HoTT bridge; replaces the axiom with a theorem |
| **Infra-1** | `Mathlib4-AnalyticLanglands` — automorphic $L$-functions for $\mathrm{GL}_n(\mathbb{A}_{\mathbb{Q}})$ |
| **Infra-2** | `Mathlib4-LanglandsGL1` — GL$_1$ automorphic ↔ Hecke character ↔ Riemann ζ bridge |
| **Infra-3** | `Cubical.Analysis.AnalyticContinuation` — constructive complex analysis (zeros, poles, monodromy, identity theorem) |
| **Infra-4** | `Mathlib4-CategoricalSpectralTheorem` — spectral theorem for self-adjoint operators **internal** to $\mathcal{E}_{\mathrm{cond}}$ (Track A only) |
| **Infra-5** | `Mathlib4-CondensedEtaleCohomology` — six-functor formalism over the arithmetic site, categorical Frobenius substitute, Lefschetz trace formula, Deligne-purity in condensed coefficients (Track B only) |
| **V5a** | Track A formulation: `RiemannHypothesis ↔ ∃ self-adjoint H with spec(H) = Im(non-trivial zeros)` inside $\mathcal{E}_{\mathrm{cond}}$ |
| **V5b** | Track B formulation: `RiemannHypothesis ↔ Frobenius eigenvalues on étale cohomology of Spec(ℤ)_cond have absolute value $q^{1/2}$` + the formulation-equivalence theorem `V5a ↔ V5b` |
| **V6a** | Track A proof attempt — adelic spectral construction → trace formula → categorical self-adjointness → conclusion. Crux at categorical self-adjointness |
| **V6b** | Track B proof attempt — Connes' arithmetic site → categorical Frobenius → Lefschetz trace → Deligne-purity transfer → conclusion. Crux at Frobenius-purity bound over $\mathbb{Z}$ |

### Continuous-refinement contract

Every team:
- Commits to `lean/` (or `agda/`, `rzk/` as appropriate) on a per-theorem basis.
- Triggers Codex `gpt-5.5` `model_reasoning_effort=xhigh` re-verification on each commit, with the read-only review contract from Volume IV; Codex repair (workspace-write) on `incomplete` verdicts whose theorem is judged true.
- Publishes a per-team verdict matrix at `reviews/<team>-verdict-matrix.md`, updated on every commit.
- Does not gate on other teams. If a downstream team needs a not-yet-proven lemma, it cites it as a temporary `axiom` with a clear `-- TODO: replaced by <team>` marker; replacement is automatic when the upstream team commits the proof.

V6a and V6b are special: they continuously re-attempt the proof against the *current state* of all other teams' libraries. Each V6 attempt is committed as `lean/Vol5/RiemannHypothesis_TrackA_attempt-N.lean` (or `_TrackB_`); Codex evaluates each attempt and reports whether the proof closes against the current axiom set.

---

## Track A proof structure (V6a)

`lean/Vol5/RiemannHypothesis_TrackA.lean`:

1. **Adelic spectral construction.** Construct, internally to $\mathcal{E}_{\mathrm{cond}}$, the Connes-style spectral decomposition of the regular representation of $\mathrm{GL}_1(\mathbb{A}_{\mathbb{Q}})/\mathbb{Q}^\times$ on $L^2(\mathbb{A}_{\mathbb{Q}})$ as an internal Hilbert space. Consumes Infra-1, Infra-2, Infra-4.
2. **Trace formula.** Categorical Selberg–Connes trace formula for the adele class space, equating geometric (sum over conjugacy classes) and spectral (sum over zeros of $\zeta$) sides.
3. **Self-adjointness.** Prove the categorical-trace operator is internally self-adjoint, using the symplectic structure inherited from analytic Langlands at GL$_1$ (Clausen–Scholze + Gaitsgory–Raskin geometric-Langlands-I 2024 transferred to the number-field side). **This is the Track A crux.**
4. **Conclusion.** Spectrum of self-adjoint $\Rightarrow$ real $\Rightarrow$ via Mathlib's `Riemann.functional_equation` $\Rightarrow$ $\mathrm{Re}(s) = 1/2$ for non-trivial zeros.

If Step 3 succeeds: V6a outputs `theorem RiemannHypothesis`. If it doesn't: V6a outputs `theorem ObstructionTrackA` characterising the categorical-self-adjointness barrier exactly.

---

## Track B proof structure (V6b)

`lean/Vol5/RiemannHypothesis_TrackB.lean`:

1. **Arithmetic-site construction.** Formalise Connes' arithmetic site $\mathrm{Spec}(\mathbb{Z})_{\mathrm{cond}}$ as a condensed analytic stack inside $\mathcal{E}_{\mathrm{cond}}$. Consumes Infra-5 + V2 (UCQ at $\aleph_\omega$).
2. **Categorical Frobenius.** Construct $\mathrm{Frob}_{\mathrm{cond}}$ acting on the arithmetic site; show its action on the relevant étale cohomology recovers local zeta factors at each finite place.
3. **Lefschetz trace formula.** Categorical Lefschetz fixed-point on the arithmetic site, expressing $\zeta(s)$ as the alternating product of characteristic polynomials of $\mathrm{Frob}_{\mathrm{cond}}$.
4. **Riemann hypothesis bound.** Prove Frobenius eigenvalues on the relevant cohomology have absolute value $q^{1/2}$ via Deligne's purity argument transferred from $\ell$-adic to condensed coefficients. **This is the Track B crux.**
5. **Conclusion.** Step 4 is precisely the Track B formulation of `RiemannHypothesis` from V5b.

If Step 4 succeeds: V6b outputs `theorem RiemannHypothesis`. If it doesn't: V6b outputs `theorem ObstructionTrackB` characterising the Frobenius-purity barrier exactly.

---

## What Volume V does NOT need to address

- **GRH** for general automorphic $L$-functions (Artin, Hecke, GL$_n$ for $n\geq 2$). Distinct programme.
- **Function-field RH.** Already proven by Deligne (1974); used as transfer source by Track B, not as target.
- **OQ2 (cubical analytic continuation).** Subsumed by V3 + Infra-3.
- **Reformulating into alternative foundations** (cohesive HoTT, modal HoTT, IZF). If both tracks fail, this becomes a successor research direction, not part of Volume V.
- **Birch–Swinnerton-Dyer, Hodge conjecture, standard motivic conjectures.** Adjacent but distinct.

---

## Operational protocol

Volume V is executed by `/research-agent` with the same custom flags Volume IV used:

- `--perspective "Prove the Riemann Hypothesis categorically inside E_cond, dual-tracked, all teams concurrent"`
- `--peer-review gemini papers, codex code`
- `--haskell yes` (companion prototype layer per topic)
- `--source-context` includes Volume IV (`hott-riemann-hypothesis-vol4`), Volume III (`hott-riemann-hypothesis`), and the foundations repos
- `--deep-research yes` (continuous WebSearch / WebFetch for 2024–2026 work in condensed mathematics, analytic Langlands, arithmetic-site cohomology)
- `--lean-proof yes` with Codex `gpt-5.5` `model_reasoning_effort=xhigh`
- `--use-apple-mail-plugin-to-send yes` and `--use-email research@yonedaai.com`
- 13-team parallel mode (extension of the 6-worker parallel mode Volume IV used)

Each team commits continuously to `lean/Vol5/<TeamName>/`. The orchestrator's loop is:

1. Spawn all 13 teams concurrently from day 1.
2. On every commit by any team: trigger Codex re-verification of all dependent theorems across the project.
3. V6a and V6b continuously re-attempt the RH proof against the current axiom set.
4. When a proof attempt closes against zero open axioms (other than the toolchain + classical-logic where introduced + V4-conditional hypothesis if taken), terminate with success.
5. When V6a and V6b both produce stable obstruction theorems with no further progress on the cruxes for $N$ consecutive Codex iterations, terminate with the obstruction-theorem end-state.

---

## What success looks like

End-of-Volume-V verdict matrix that we *want* to see:

| | Valid | Invalid | Incomplete |
|---|---:|---:|---:|
| V1 cosmos-internal Yoneda | **6+** | 0 | 0–2 |
| V2 UCQ resolution | **5+** | 0 | 0–2 |
| V3 Cubical Agda upstream merge | **15+** | 0 | 0 |
| V4 `ConjectureC_reverse` discharged | **8+** | 0 | 0–1 |
| V5a Track A formulation | **3+** | 0 | 0 |
| V5b Track B formulation + equivalence | **4+** | 0 | 0 |
| V6a Track A proof | **1** | 0 | 0 |
| V6b Track B proof | **1** | 0 | 0 |
| Infra-1 AnalyticLanglands | **15+** | 0 | 0–3 |
| Infra-2 LanglandsGL1 | **8+** | 0 | 0–1 |
| Infra-3 AnalyticContinuation (Cubical) | **10+** | 0 | 0 |
| Infra-4 CategoricalSpectralTheorem | **6+** | 0 | 0–1 |
| Infra-5 CondensedEtaleCohomology | **20+** | 0 | 0–5 |

Volume IV's honest 62 / 0 / 29 becomes Volume V's end-state of **100+ valid / 0 invalid / 0–15 incomplete**, with the headline theorem:

```lean
theorem RiemannHypothesis :
    ∀ (s : ℂ_Cond), s ∈ NonTrivialZeros zetaCond → s.re = 1/2 := by
  ...
```

machine-checked, independently re-verified, depending only on declared axioms.

The dual-track structure produces three honest end-states:

1. **Both tracks succeed** — `theorem RiemannHypothesis` proven twice over (Track A self-adjointness; Track B Frobenius purity), cross-verified via V5's formulation-equivalence. Programme ends with a redundantly-verified proof of RH.
2. **Exactly one track succeeds** — surviving track produces `theorem RiemannHypothesis`; failed track produces `theorem ObstructionTrack{A,B}` localising the irreducible barrier on its side. Programme ends with one proof and one obstruction theorem.
3. **Both tracks fail** — Volume V publishes `theorem ObstructionTrackA` (categorical-self-adjointness barrier inside $\mathcal{E}_{\mathrm{cond}}$) and `theorem ObstructionTrackB` (Frobenius-purity barrier inside condensed étale cohomology). Programme ends with the most precise statement to date of *what exactly* blocks RH on both routes.

In all three end-states the programme **ends** at the close of Volume V. The HoTT-Riemann programme is **four volumes plus the final volume**: I (foundational), II (HoTT-foundations), III (formulation, the six OQs), IV (formal-proof of OQ1/3/5 + cross-cutting infrastructure), V (RH itself, categorically, dual-tracked, AI-concurrent). There is no Volume VI.
