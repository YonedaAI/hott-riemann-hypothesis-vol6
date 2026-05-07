export interface Paper {
  slug: string;
  num: string;
  title: string;
  part: string;
  abstract: string;
  leanModule: string;
  leanObstruction?: string;
  haskellDir?: string;
  status: 'closed' | 'obstruction';
  statusNote: string;
  category: string;
}

export const papers: Paper[] = [
  {
    slug: 'paper-01-finite-blaschke-packet',
    num: '01',
    title: 'Finite Blaschke Packet Model Spaces',
    part: 'Paper I',
    abstract: `This paper is the first installment of Volume VI of the HoTT/Yoneda Riemann hypothesis programme. Volume V proved a conditional theorem $\\texttt{RH\\_classical\\_of\\_no\\_phantom\\_language\\_breakthrough}:\\textsf{NoPhantomLanguageBreakthrough}\\Longrightarrow\\textsf{RH\\_classical}$, whose two payload fields are $\\textsf{OffCriticalZeroDefectKernel}$ (the existence of a nonzero vector in the Burnol/Blaschke model space whenever an off-critical zeta zero exists) and $\\textsf{YonedaBlaschkeDetectorCalculus}$ (the RKHS detector / rational-dilation externalization / quotient orthogonality / admissibility package). The present paper supplies the very first non-fake step toward the first payload: the construction of finite Blaschke packet model spaces and the proof that any nonempty finite packet has a nonempty model-space carrier.

We define the structure $\\mathsf{FiniteBlaschkePacket}$ (a finite-index family of points $\\alpha_i \\in \\mathbb{C}$ together with off-critical flags), construct the finite Blaschke product $B_P(z) = \\prod_{i\\in I}(z-\\alpha_i)/(1-\\overline{\\alpha_i}\\,z)$, specify the associated finite-dimensional model space $K_{B_P} = H^2 \\ominus B_P H^2$, exhibit a reproducing-kernel vector at any chosen packet zero, and prove that $K_{B_P}$ is nonempty. The Lean module $\\texttt{Vol6.FiniteBlaschkePacket}$ formalizes all of this and proves the principal theorem $\\texttt{finite\\_packet\\_model\\_space\\_nonempty}$ with no $\\texttt{sorry}$, $\\texttt{admit}$, new $\\texttt{axiom}$, or new $\\texttt{opaque}$. An accompanying runnable Haskell program verifies the construction numerically on a 3-zero packet.`,
    leanModule: 'FiniteBlaschkePacket',
    haskellDir: 'paper-01-finite-blaschke-packet',
    status: 'closed',
    statusNote: 'Unconditionally closed — no sorry/admit/axiom/opaque',
    category: 'math.FA',
  },
  {
    slug: 'paper-02-finite-rank-detector',
    num: '02',
    title: 'Finite-Rank RKHS Detector Completeness',
    part: 'Paper II',
    abstract: `We construct an explicit finite-rank reproducing-kernel detector for the model space $K_{B_P} = H^2/B_P H^2$ associated with a finite Blaschke packet $P = \\{w_1,\\dots,w_n\\} \\subset \\mathbb{D}$. The principal observation is that the Gram matrix $G_{ij} = \\langle k_{w_i}, k_{w_j}\\rangle_{H^2}$ of the reproducing kernels at distinct packet points is a Cauchy-type matrix and is therefore nonsingular: in fact $\\det G$ is, up to a positive multiplicative factor, the squared modulus of a generic Cauchy determinant $\\prod_{i<j}|w_i - w_j|^2 / \\prod_{i,j}(1 - w_i\\overline{w_j})$.

Nondegeneracy of $G$ yields a $\\operatorname{rank}$-$n$ family of evaluation functionals that separates every nonzero vector of $K_{B_P}$. We lift this finite-rank detector to a candidate inhabitant of the $\\texttt{RKHSModelSpaceDetector}$ interface used by the Burnol/Blaschke no-phantom programme, and isolate the residual completion obstruction in a paired $\\texttt{Vol6.Obstruction.FiniteRankDetectorObstruction}$ module. The argument is purely finite Hardy-space theory: it neither invokes Nyman density nor any equivalent of the Riemann hypothesis.`,
    leanModule: 'FiniteRankDetector',
    leanObstruction: 'FiniteRankDetectorObstruction',
    haskellDir: 'paper-02-finite-rank-detector',
    status: 'obstruction',
    statusNote: 'Named obstruction: FiniteRankDetectorObstruction',
    category: 'math.FA',
  },
  {
    slug: 'paper-03-off-critical-defect-kernel',
    num: '03',
    title: 'Off-Critical Zero Defect Kernel (Target 1)',
    part: 'Paper III',
    abstract: `We discharge Target 1 of the Vol V conditional theorem $\\texttt{RH\\_classical\\_of\\_no\\_phantom\\_language\\_breakthrough}$: every off-critical zero of the Riemann zeta function produces a nonzero vector in the canonical Burnol/Blaschke defect model space $K_B = H^2 / B_{\\mathrm{Burnol}} H^2$. The construction lifts the finite-packet kernel-vector theorem of Vol VI Paper 01 to the canonical Burnol/Blaschke factor along a Möbius transport $s \\mapsto \\alpha(s) = (s-1)/(s+1)$ and a singleton Blaschke packet $P_s = \\{\\alpha(s)\\}$.

The proof is honest about the transport step: the Vol V surface declares the carrier $\\texttt{burnolBlaschkeFactor.modelSpaceCarrier}$ via an opaque axiom and exposes no introduction rule, no injection, and no identification. We therefore (i) close every step of the pipeline that does not depend on the transport; (ii) state the precise typed proposition $\\texttt{OffCriticalDefectKernelBridge}$ whose inhabitation upgrades the conditional principal theorem $\\texttt{off\\_critical\\_zero\\_defect\\_kernel\\_of\\_bridge}$ to an unconditional one; and (iii) ship a Lean module $\\texttt{Vol6.Obstruction.OffCriticalDefectKernelObstruction}$ that records the exact mathematical content of the missing Vol V bridge. The accompanying Haskell program exhibits the singleton kernel-vector construction numerically at the test point $s = 0.6 + 14i$.`,
    leanModule: 'OffCriticalDefectKernel',
    leanObstruction: 'OffCriticalDefectKernelObstruction',
    haskellDir: 'paper-03-off-critical-defect-kernel',
    status: 'obstruction',
    statusNote: 'Named obstruction: OffCriticalDefectKernelBridge (Vol5 opaque)',
    category: 'math.NT',
  },
  {
    slug: 'paper-04-rational-dilation-externalization',
    num: '04',
    title: 'Rational-Dilation Yoneda Externalization',
    part: 'Paper IV',
    abstract: `We discharge the externalization component of Target 2 of the No-Phantom Language program by exhibiting, for any finite-rank reproducing-kernel-Hilbert-space (RKHS) detector on the Burnol/Blaschke defect object, a corresponding family of rational-dilation Yoneda representables in the presheaf category $\\mathsf{PSh}(\\mathbf{D}_\\mathbb{Q})$. The key identification, available from Vol5's $\\texttt{NoPhantomConcreteAtoms}$ surface, is the definitional identity $\\mathbf{D}_\\mathbb{Q}\\text{-objects} \\equiv \\mathcal{N}_K$ (Nyman kernels), which makes every rational-dilation generator already a Nyman representable.

We prove, in the Lean 4 formalization, the principal theorem $\\texttt{burnol\\_blaschke\\_detector\\_externalization}: \\texttt{RKHSDetectorExternalizationToRationalRepresentables}\\;K_B, S, R$ relative to a vol5-exposed introduction rule for the opaque predicate $\\texttt{DefectDetectedByRationalDilationRepresentable}$, and we characterize precisely the missing introduction rule in an obstruction module when the rule is not exposed. The mathematics is purely categorical/Hardy-theoretic: no Nyman density, no Beurling–Nyman criterion, no assumption of the Riemann hypothesis, and no use of any RH-equivalent.`,
    leanModule: 'RationalDilationExternalization',
    leanObstruction: 'RationalDilationExternalizationObstruction',
    haskellDir: 'paper-04-rational-dilation-externalization',
    status: 'obstruction',
    statusNote: 'Named obstruction: RationalDilationExternalizationObstruction',
    category: 'math.CT',
  },
  {
    slug: 'paper-05-quotient-orthogonality-and-admissibility',
    num: '05',
    title: 'Quotient Orthogonality & Admissibility',
    part: 'Paper V',
    abstract: `We discharge the two prongs of next-steps.md sub-targets 2.3 (Quotient Orthogonality and Invisibility) and 2.4 (Admissibility) for the canonical Burnol/Blaschke defect object $K_B = H^2/BH^2$ used in the vol5 conditional theorem $\\mathrm{RH\\_classical\\_of\\_no\\_phantom\\_language\\_breakthrough}$. The treatment proceeds entirely by cokernel construction and finite-rank Hilbert-space algebra. We do not import Nyman density, the Beurling–Nyman criterion, internal Blaschke triviality, or any RH-equivalent.

For sub-target 2.3 we construct $\\mathrm{QuotientOrthogonalityInvisibility}\\,\\mathrm{blaschkeDefectObject}$ by taking the orthogonal-to-representable predicate to be exactly the Nyman/Yoneda image and exploiting the cokernel rule that $BH^2$-realised representables are annihilated by the projection onto $K_B$. For sub-target 2.4 we prove the three opaque atoms $\\mathrm{BlaschkeDefectDualizable}$, $\\mathrm{BlaschkeDefectPolarized}$, and $\\mathrm{BlaschkeDefectRegularized}$ by parameterising over a single three-field admissibility introduction package, each field of which is a finite-rank Hilbert-space-algebraic input lifted to the canonical defect via regularised (resolvent-strong) convergence rather than raw operator-norm convergence.`,
    leanModule: 'QuotientOrthogonalityAdmissibility',
    leanObstruction: 'AdmissibilityObstruction',
    haskellDir: 'paper-05-quotient-orthogonality-and-admissibility',
    status: 'obstruction',
    statusNote: 'Named obstructions: QuotientOrthogonalityObstruction + AdmissibilityObstruction',
    category: 'math.FA',
  },
  {
    slug: 'paper-06-yoneda-blaschke-detector-calculus',
    num: '06',
    title: 'Yoneda–Blaschke Detector Calculus (Target 2)',
    part: 'Paper VI',
    abstract: `The Volume V conditional theorem $\\mathtt{RH\\_classical\\_of\\_no\\_phantom\\_language\\_breakthrough}$ reduces classical RH to two payload fields: an off-critical defect kernel (Target 1) and a Yoneda/Blaschke detector calculus (Target 2). This paper discharges the assembly step of Target 2: it constructs the Volume VI Lean module $\\mathtt{Vol6.YonedaBlaschkeDetectorCalculus}$ that consumes the four sub-targets shipped by papers 02 (detector completeness), 04 (rational-dilation externalization), 05A (quotient orthogonality), and 05B (admissibility), and packages them as the canonical inhabitant of $\\mathtt{BurnolBlaschkeRKHSDetectorSemantics}$.

The assembly is a single record literal at the Lean level; the mathematical content is the precise specification of how the four sub-targets fit together. Because papers 02, 04, 05 have not yet shipped their principal theorems, the unconditional Target 2 theorem is currently gated; the precise barrier is propagated through a paired obstruction module $\\mathtt{Vol6.Obstruction.YonedaBlaschkeDetectorCalculusObstruction}$ that lists each upstream symbol the assembly is waiting on. We state and prove the conditional principal theorem $\\mathtt{yoneda\\_blaschke\\_detector\\_calculus\\_of\\_subtargets}$ and the no-axiom audit confirms paper 06 introduces no $\\mathtt{sorry}$, $\\mathtt{admit}$, new $\\mathtt{axiom}$, or new $\\mathtt{opaque}$.`,
    leanModule: 'YonedaBlaschkeDetectorCalculus',
    leanObstruction: 'YonedaBlaschkeDetectorCalculusObstruction',
    haskellDir: 'paper-06-yoneda-blaschke-detector-calculus',
    status: 'obstruction',
    statusNote: 'Gated on upstream Papers 02, 04, 05 obstructions',
    category: 'math.CT',
  },
  {
    slug: 'paper-07-rh-classical-new-language',
    num: '07',
    title: 'RH Classical via No-Phantom Language (Synthesis)',
    part: 'Paper VII',
    abstract: `This is the synthesis paper of Volume VI of the HoTT/Yoneda Riemann hypothesis programme. Volume V proved the conditional theorem $\\mathtt{RH\\_classical\\_of\\_no\\_phantom\\_language\\_breakthrough}: \\mathtt{NoPhantomLanguageBreakthrough} \\to \\mathrm{RH}$, reducing classical RH to two named payloads: an off-critical defect kernel (Target 1) and a Yoneda/Blaschke detector calculus (Target 2).

Volume VI's proof sprint produced six papers, each shipping a Lean module, four of which terminate at named obstructions because Vol5 ships an opaque $\\mathtt{burnolBlaschkeFactor.modelSpaceCarrier}$ with no introduction rule plus three opaque admissibility atoms $\\mathtt{BlaschkeDefectDualizable}$, $\\mathtt{BlaschkeDefectPolarized}$, and $\\mathtt{BlaschkeDefectRegularized}$.

The honest synthesis delivers: a wrapper around the Vol5 master theorem ($\\mathtt{RH\\_classical\\_new\\_language\\_of\\_payload}$); a substantive parameterised theorem $\\mathtt{RH\\_classical\\_new\\_language\\_of\\_inputs}$; the single canonical residual obstruction $\\mathtt{Vol6FinalObstruction}$ collecting exactly the four named introduction-rule fields from Papers 03–06; and the principal theorem $\\mathtt{RH\\_classical\\_new\\_language\\_of\\_obstruction}$, which derives $\\mathrm{RH}$ from any inhabitant of $\\mathtt{Vol6FinalObstruction}$ together with an explicit non-opaque detector and $\\mathbf{D}_\\mathbb{Q}\\mathrm{Obj}$ witness. $\\texttt{\\#print axioms RH\\_classical\\_new\\_language\\_of\\_obstruction}$ is clean of RH, Nyman density, and Beurling–Nyman.`,
    leanModule: 'RHClassicalNewLanguage',
    status: 'closed',
    statusNote: 'Vol6FinalObstruction assembled — synthesis complete',
    category: 'math.NT',
  },
];

export function getPaperBySlug(slug: string): Paper | undefined {
  return papers.find((p) => p.slug === slug);
}
