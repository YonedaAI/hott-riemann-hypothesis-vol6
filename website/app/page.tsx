import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { papers } from "../lib/papers";
import { renderMathInHtml } from "../lib/render-math";

export const metadata: Metadata = {
  title: 'Volume VI',
  description:
    'Reducing the Riemann Hypothesis to a four-lemma No-Phantom Language, in Lean 4.',
  openGraph: {
    title: 'Volume VI',
    description:
      'Reducing the Riemann Hypothesis to a four-lemma No-Phantom Language, in Lean 4.',
    images: [{ url: '/og-images/paper-07-rh-classical-new-language.png', width: 1200, height: 630 }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Volume VI',
    images: ['/og-images/paper-07-rh-classical-new-language.png'],
  },
};

export default function Home() {
  return (
    <div>
      {/* Hero */}
      <section className="hero-gradient" style={{ padding: '5rem 1.5rem 4rem', textAlign: 'center' }}>
        <div style={{ maxWidth: '52rem', margin: '0 auto' }}>
          <div style={{ display: 'inline-block', background: 'var(--accent-glow)', border: '1px solid var(--border)', borderRadius: '999px', padding: '0.3rem 1rem', fontSize: '0.8125rem', color: 'var(--accent)', marginBottom: '1.5rem', letterSpacing: '0.05em', textTransform: 'uppercase' }}>
            HoTT/Yoneda Riemann Hypothesis Programme
          </div>
          <h1 style={{ fontSize: 'clamp(1.75rem, 4vw, 2.75rem)', fontWeight: 700, color: 'var(--text)', marginBottom: '1rem', lineHeight: 1.25 }}>
            Volume VI
          </h1>
          <p style={{ fontSize: '1.0625rem', color: 'var(--text-muted)', maxWidth: '44rem', margin: '0 auto 2rem', lineHeight: 1.7 }}>
            Reducing the Riemann Hypothesis to a four-lemma No-Phantom Language, in Lean 4.
          </p>

          {/* Argument */}
          <div className="verdict-box" style={{ padding: '1.5rem 1.75rem', maxWidth: '44rem', margin: '0 auto', textAlign: 'left' }}>
            <p style={{ fontSize: '0.9375rem', color: 'var(--text-muted)', lineHeight: 1.7, margin: '0 0 0.875rem 0' }}>
              If there were a non-trivial zero of the Riemann zeta function off the critical line, it would create a nonzero vector in the Burnol/Blaschke model space{' '}
              <code style={{ fontSize: '0.85em' }}>K_B = H&sup2; / B &middot; H&sup2;</code>. A rational-dilation Yoneda probe would detect that vector. Admissibility of the defect object forbids the resulting phantom&mdash;so no off-critical zero exists.
            </p>
            <p style={{ fontSize: '0.9375rem', color: 'var(--text-muted)', lineHeight: 1.7, margin: '0 0 0.875rem 0' }}>
              This volume formalises that argument in seven Lean-verified papers. Two principal theorems close unconditionally (finite Blaschke packets and finite-rank RKHS detector completeness). The remaining four reduce to a minimal four-lemma data package, with iff-bridges proving each lemma is exactly what the proof needs.
            </p>
            <p style={{ fontSize: '0.9375rem', color: 'var(--text-muted)', lineHeight: 1.7, margin: 0 }}>
              The full development is{' '}
              <code style={{ fontSize: '0.85em' }}>sorry</code>-,{' '}
              <code style={{ fontSize: '0.85em' }}>admit</code>-,{' '}
              <code style={{ fontSize: '0.85em' }}>axiom</code>-, and{' '}
              <code style={{ fontSize: '0.85em' }}>opaque</code>-free.{' '}
              <code style={{ fontSize: '0.85em' }}>#print axioms</code>{' '}
              reveals only standard Lean foundations&mdash;never RH, never Nyman density, never the Beurling-Nyman criterion.
            </p>
          </div>

          <div style={{ display: 'flex', gap: '0.75rem', justifyContent: 'center', marginTop: '2rem', flexWrap: 'wrap', fontSize: '0.875rem', color: 'var(--text-dim)' }}>
            <span style={{ display: 'flex', alignItems: 'center', gap: '0.375rem' }}>
              <span style={{ width: '8px', height: '8px', borderRadius: '50%', background: 'var(--success)', display: 'inline-block' }}></span>
              7 papers
            </span>
            <span style={{ display: 'flex', alignItems: 'center', gap: '0.375rem' }}>
              <span style={{ width: '8px', height: '8px', borderRadius: '50%', background: 'var(--accent)', display: 'inline-block' }}></span>
              7 Lean modules
            </span>
            <span style={{ display: 'flex', alignItems: 'center', gap: '0.375rem' }}>
              <span style={{ width: '8px', height: '8px', borderRadius: '50%', background: 'var(--warning)', display: 'inline-block' }}></span>
              4 named obstructions
            </span>
          </div>
        </div>
      </section>

      {/* Papers grid */}
      <section id="papers" style={{ maxWidth: '72rem', margin: '0 auto', padding: '3rem 1.5rem' }}>
        <h2 style={{ fontSize: '1.375rem', fontWeight: 600, color: 'var(--text)', marginBottom: '2rem', display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
          <span style={{ width: '3px', height: '1.25rem', background: 'var(--accent)', borderRadius: '2px', display: 'inline-block' }}></span>
          Papers
        </h2>

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(320px, 1fr))', gap: '1.25rem' }}>
          {papers.map((paper) => {
            const abstractSnippet = paper.abstract.replace(/\$[^$]*\$/g, '').replace(/\$\$[^$]*\$\$/g, '').replace(/\\[a-zA-Z]+(\{[^}]*\})?/g, '').replace(/[{}]/g, '').trim().slice(0, 160) + '…';
            return (
              <article key={paper.slug} className="paper-card" style={{ display: 'flex', flexDirection: 'column' }}>
                {/* Cover image */}
                <div style={{ position: 'relative', width: '100%', aspectRatio: '16/9', overflow: 'hidden', borderRadius: '12px 12px 0 0', background: 'var(--code-bg)' }}>
                  <Image
                    src={`/cover-images/${paper.slug}.png`}
                    alt={`Cover for ${paper.title}`}
                    fill
                    style={{ objectFit: 'cover' }}
                    sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
                  />
                </div>

                <div style={{ padding: '1.25rem', display: 'flex', flexDirection: 'column', flex: 1 }}>
                  {/* Header row */}
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                    <span style={{ fontSize: '0.75rem', color: 'var(--text-dim)', fontFamily: 'monospace' }}>
                      {paper.part}
                    </span>
                    <span
                      className={paper.status === 'closed' ? 'badge-closed' : 'badge-obstruction'}
                      style={{ fontSize: '0.6875rem', fontWeight: 600, padding: '0.2rem 0.5rem', borderRadius: '999px', textTransform: 'uppercase', letterSpacing: '0.04em' }}
                    >
                      {paper.status === 'closed' ? 'Closed' : 'Obstruction'}
                    </span>
                  </div>

                  <h3 style={{ fontSize: '1.0625rem', fontWeight: 600, color: 'var(--text)', marginBottom: '0.625rem', lineHeight: 1.35 }}>
                    {paper.title}
                  </h3>

                  <p style={{ fontSize: '0.875rem', color: 'var(--text-muted)', lineHeight: 1.6, marginBottom: '1rem', flex: 1 }}>
                    {abstractSnippet}
                  </p>

                  <div style={{ fontSize: '0.75rem', color: 'var(--text-dim)', marginBottom: '1rem', fontFamily: 'monospace', background: 'var(--code-bg)', borderRadius: '4px', padding: '0.3rem 0.5rem' }}>
                    {paper.statusNote}
                  </div>

                  {/* Action links */}
                  <div style={{ display: 'flex', gap: '0.625rem', flexWrap: 'wrap' }}>
                    <Link
                      href={`/papers/${paper.slug}/`}
                      style={{ display: 'inline-flex', alignItems: 'center', gap: '0.375rem', background: 'var(--accent)', color: '#0d0a1a', fontWeight: 600, fontSize: '0.8125rem', padding: '0.4rem 0.875rem', borderRadius: '6px', transition: 'background 0.2s' }}
                    >
                      Read
                    </Link>
                    <a
                      href={`/pdf/${paper.slug}.pdf`}
                      target="_blank"
                      rel="noopener noreferrer"
                      style={{ display: 'inline-flex', alignItems: 'center', gap: '0.375rem', border: '1px solid var(--border)', color: 'var(--text-muted)', fontWeight: 500, fontSize: '0.8125rem', padding: '0.4rem 0.875rem', borderRadius: '6px', transition: 'border-color 0.2s, color 0.2s' }}
                    >
                      PDF
                    </a>
                  </div>
                </div>
              </article>
            );
          })}
        </div>
      </section>
    </div>
  );
}
