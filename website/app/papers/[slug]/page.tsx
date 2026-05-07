import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { papers, getPaperBySlug } from "../../../lib/papers";
import { renderMathInHtml } from "../../../lib/render-math";

export async function generateStaticParams() {
  return papers.map((p) => ({ slug: p.slug }));
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ slug: string }>;
}): Promise<Metadata> {
  const { slug } = await params;
  const paper = getPaperBySlug(slug);
  if (!paper) return {};

  const plainAbstract = paper.abstract
    .replace(/\$\$[\s\S]*?\$\$/g, '')
    .replace(/\$[^$]*\$/g, '')
    .replace(/\\[a-zA-Z]+(\{[^}]*\})?/g, '')
    .replace(/[{}]/g, '')
    .trim()
    .slice(0, 200);

  return {
    title: paper.title,
    description: plainAbstract,
    openGraph: {
      title: paper.title,
      description: plainAbstract,
      type: 'article',
      url: `/papers/${paper.slug}/`,
      images: [{ url: `/og-images/${paper.slug}.png`, width: 1200, height: 630 }],
    },
    twitter: {
      card: 'summary_large_image',
      title: paper.title,
      description: plainAbstract,
      images: [`/og-images/${paper.slug}.png`],
    },
  };
}

const LEAN_GITHUB_BASE = 'https://github.com/YonedaAI/hott-riemann-hypothesis-vol6/blob/main/lean/Vol6';
const OBSTRUCTION_GITHUB_BASE = 'https://github.com/YonedaAI/hott-riemann-hypothesis-vol6/blob/main/lean/Vol6/Obstruction';
const HASKELL_GITHUB_BASE = 'https://github.com/YonedaAI/hott-riemann-hypothesis-vol6/blob/main/haskell';

export default async function PaperPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;
  const paper = getPaperBySlug(slug);
  if (!paper) notFound();

  const idx = papers.findIndex((p) => p.slug === slug);
  const prev = idx > 0 ? papers[idx - 1] : null;
  const next = idx < papers.length - 1 ? papers[idx + 1] : null;

  // Render abstract math at build time server-side — content is our own static data
  const abstractHtml = renderMathInHtml(
    paper.abstract
      .split('\n\n')
      .map((para) => `<p>${para.replace(/\n/g, ' ')}</p>`)
      .join('\n')
  );

  return (
    <div style={{ maxWidth: '72rem', margin: '0 auto', padding: '2rem 1.5rem' }}>
      {/* Breadcrumb */}
      <nav style={{ fontSize: '0.8125rem', color: 'var(--text-dim)', marginBottom: '2rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
        <Link href="/" style={{ color: 'var(--text-dim)' }}>Home</Link>
        <span>/</span>
        <span style={{ color: 'var(--text-muted)' }}>{paper.part}</span>
      </nav>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr', gap: '2rem' }} className="paper-layout">
        {/* Main content */}
        <div style={{ minWidth: 0 }}>
          {/* Header */}
          <header style={{ marginBottom: '2.5rem' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '0.75rem', flexWrap: 'wrap' }}>
              <span style={{ fontSize: '0.8125rem', fontFamily: 'monospace', color: 'var(--text-dim)', background: 'var(--code-bg)', padding: '0.2rem 0.6rem', borderRadius: '4px' }}>
                {paper.part}
              </span>
              <span style={{ fontSize: '0.75rem', fontWeight: 600, padding: '0.2rem 0.6rem', borderRadius: '999px', textTransform: 'uppercase', letterSpacing: '0.04em' }}
                className={paper.status === 'closed' ? 'badge-closed' : 'badge-obstruction'}>
                {paper.status === 'closed' ? 'Unconditionally Closed' : 'Named Obstruction'}
              </span>
              <span style={{ fontSize: '0.75rem', color: 'var(--text-dim)', fontFamily: 'monospace' }}>{paper.category}</span>
            </div>
            <h1 style={{ fontSize: 'clamp(1.5rem, 3.5vw, 2.25rem)', fontWeight: 700, color: 'var(--text)', lineHeight: 1.25, marginBottom: '1.25rem' }}>
              {paper.title}
            </h1>

            {/* Quick action links */}
            <div style={{ display: 'flex', gap: '0.625rem', flexWrap: 'wrap' }}>
              <a
                href={`/pdf/${paper.slug}.pdf`}
                target="_blank"
                rel="noopener noreferrer"
                style={{ display: 'inline-flex', alignItems: 'center', gap: '0.375rem', background: 'var(--accent)', color: '#0d0a1a', fontWeight: 700, fontSize: '0.8125rem', padding: '0.45rem 1rem', borderRadius: '6px' }}
              >
                Download PDF
              </a>
              <a
                href={`${LEAN_GITHUB_BASE}/${paper.leanModule}.lean`}
                target="_blank"
                rel="noopener noreferrer"
                style={{ display: 'inline-flex', alignItems: 'center', gap: '0.375rem', border: '1px solid var(--border)', color: 'var(--text-muted)', fontSize: '0.8125rem', padding: '0.45rem 1rem', borderRadius: '6px' }}
              >
                Lean Module
              </a>
              {paper.haskellDir && (
                <a
                  href={`${HASKELL_GITHUB_BASE}/${paper.haskellDir}/Main.hs`}
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{ display: 'inline-flex', alignItems: 'center', gap: '0.375rem', border: '1px solid var(--border)', color: 'var(--text-muted)', fontSize: '0.8125rem', padding: '0.45rem 1rem', borderRadius: '6px' }}
                >
                  Haskell Artifact
                </a>
              )}
              {paper.leanObstruction && (
                <a
                  href={`${OBSTRUCTION_GITHUB_BASE}/${paper.leanObstruction}.lean`}
                  target="_blank"
                  rel="noopener noreferrer"
                  style={{ display: 'inline-flex', alignItems: 'center', gap: '0.375rem', border: '1px solid rgba(245,158,11,0.4)', color: 'var(--warning)', fontSize: '0.8125rem', padding: '0.45rem 1rem', borderRadius: '6px', background: 'rgba(245,158,11,0.06)' }}
                >
                  Obstruction File
                </a>
              )}
            </div>
          </header>

          {/* Abstract */}
          <section id="abstract" style={{ marginBottom: '2.5rem' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 600, color: 'var(--accent-hover)', marginBottom: '1rem', paddingBottom: '0.5rem', borderBottom: '1px solid var(--border)', scrollMarginTop: '5rem' }}>
              Abstract
            </h2>
            {/* abstractHtml is server-rendered KaTeX output from our own static LaTeX source files */}
            <div
              className="paper-content abstract-math"
              dangerouslySetInnerHTML={{ __html: abstractHtml }}
            />
          </section>

          {/* Artifacts */}
          <section id="artifacts" style={{ marginBottom: '2.5rem' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 600, color: 'var(--accent-hover)', marginBottom: '1rem', paddingBottom: '0.5rem', borderBottom: '1px solid var(--border)', scrollMarginTop: '5rem' }}>
              Artifacts
            </h2>

            <div style={{ display: 'grid', gap: '0.875rem' }}>
              {/* Lean module */}
              <div id="lean-module" style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: '8px', padding: '1rem 1.25rem', scrollMarginTop: '5rem' }}>
                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.5rem' }}>
                  <div>
                    <div style={{ fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.08em', color: 'var(--text-dim)', marginBottom: '0.25rem' }}>Lean 4 Module</div>
                    <code style={{ color: 'var(--accent-hover)', fontSize: '0.9375rem' }}>Vol6.{paper.leanModule}</code>
                  </div>
                  <a
                    href={`${LEAN_GITHUB_BASE}/${paper.leanModule}.lean`}
                    target="_blank"
                    rel="noopener noreferrer"
                    style={{ fontSize: '0.8125rem', color: 'var(--accent)', border: '1px solid var(--border)', padding: '0.3rem 0.75rem', borderRadius: '5px' }}
                  >
                    View on GitHub &rarr;
                  </a>
                </div>
              </div>

              {/* Haskell artifact */}
              {paper.haskellDir && (
                <div style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: '8px', padding: '1rem 1.25rem' }}>
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.5rem' }}>
                    <div>
                      <div style={{ fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.08em', color: 'var(--text-dim)', marginBottom: '0.25rem' }}>Haskell Numeric Artifact</div>
                      <code style={{ color: 'var(--accent-hover)', fontSize: '0.9375rem' }}>haskell/{paper.haskellDir}/Main.hs</code>
                    </div>
                    <a
                      href={`${HASKELL_GITHUB_BASE}/${paper.haskellDir}/Main.hs`}
                      target="_blank"
                      rel="noopener noreferrer"
                      style={{ fontSize: '0.8125rem', color: 'var(--accent)', border: '1px solid var(--border)', padding: '0.3rem 0.75rem', borderRadius: '5px' }}
                    >
                      View on GitHub &rarr;
                    </a>
                  </div>
                </div>
              )}

              {/* Obstruction file */}
              {paper.leanObstruction && (
                <div style={{ background: 'rgba(245,158,11,0.05)', border: '1px solid rgba(245,158,11,0.25)', borderRadius: '8px', padding: '1rem 1.25rem' }}>
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '0.5rem' }}>
                    <div>
                      <div style={{ fontSize: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.08em', color: 'var(--warning)', marginBottom: '0.25rem', opacity: 0.8 }}>Obstruction Module</div>
                      <code style={{ color: 'var(--warning)', fontSize: '0.9375rem' }}>Vol6.Obstruction.{paper.leanObstruction}</code>
                    </div>
                    <a
                      href={`${OBSTRUCTION_GITHUB_BASE}/${paper.leanObstruction}.lean`}
                      target="_blank"
                      rel="noopener noreferrer"
                      style={{ fontSize: '0.8125rem', color: 'var(--warning)', border: '1px solid rgba(245,158,11,0.35)', padding: '0.3rem 0.75rem', borderRadius: '5px' }}
                    >
                      View on GitHub &rarr;
                    </a>
                  </div>
                </div>
              )}
            </div>
          </section>

          {/* Status */}
          <section id="status" style={{ marginBottom: '2.5rem' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 600, color: 'var(--accent-hover)', marginBottom: '1rem', paddingBottom: '0.5rem', borderBottom: '1px solid var(--border)', scrollMarginTop: '5rem' }}>
              Status &amp; Obstructions
            </h2>
            <div
              className={paper.status === 'closed' ? 'badge-closed' : 'badge-obstruction'}
              style={{ display: 'inline-block', padding: '0.75rem 1.25rem', borderRadius: '8px', marginBottom: '1rem' }}
            >
              <div style={{ fontWeight: 700, fontSize: '0.875rem', marginBottom: '0.25rem' }}>
                {paper.status === 'closed' ? 'Unconditionally Closed' : 'Named Obstruction Present'}
              </div>
              <div style={{ fontSize: '0.8125rem', fontFamily: 'monospace', opacity: 0.85 }}>
                {paper.statusNote}
              </div>
            </div>
            {paper.status === 'closed' && (
              <p style={{ fontSize: '0.9375rem', color: 'var(--text-muted)', lineHeight: 1.65 }}>
                This paper introduces no <code>sorry</code>, <code>admit</code>, new <code>axiom</code>, or new <code>opaque</code>. The principal theorem is unconditionally proved within the Vol5 surface.
              </p>
            )}
            {paper.status === 'obstruction' && (
              <p style={{ fontSize: '0.9375rem', color: 'var(--text-muted)', lineHeight: 1.65 }}>
                The principal theorem is conditional on inhabiting the named obstruction type. The obstruction module precisely characterizes the missing Vol5 introduction rule. No new <code>sorry</code>, <code>admit</code>, <code>axiom</code>, or <code>opaque</code> is introduced in Vol6.
              </p>
            )}
          </section>

          {/* Navigation */}
          <section id="navigation" style={{ scrollMarginTop: '5rem' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 600, color: 'var(--accent-hover)', marginBottom: '1rem', paddingBottom: '0.5rem', borderBottom: '1px solid var(--border)' }}>
              Navigation
            </h2>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
              {prev ? (
                <Link href={`/papers/${prev.slug}/`} style={{ display: 'block', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: '8px', padding: '1rem', transition: 'border-color 0.2s' }}>
                  <div style={{ fontSize: '0.75rem', color: 'var(--text-dim)', marginBottom: '0.25rem' }}>&larr; Previous</div>
                  <div style={{ fontSize: '0.9375rem', color: 'var(--text)', fontWeight: 500 }}>{prev.title}</div>
                </Link>
              ) : <div />}
              {next ? (
                <Link href={`/papers/${next.slug}/`} style={{ display: 'block', background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: '8px', padding: '1rem', textAlign: 'right', transition: 'border-color 0.2s' }}>
                  <div style={{ fontSize: '0.75rem', color: 'var(--text-dim)', marginBottom: '0.25rem' }}>Next &rarr;</div>
                  <div style={{ fontSize: '0.9375rem', color: 'var(--text)', fontWeight: 500 }}>{next.title}</div>
                </Link>
              ) : <div />}
            </div>
          </section>
        </div>
      </div>

      <style>{`
        @media (min-width: 1024px) {
          .paper-layout {
            grid-template-columns: 1fr !important;
          }
        }
      `}</style>
    </div>
  );
}
