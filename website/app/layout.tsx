import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";

const siteUrl = process.env.VERCEL_PROJECT_PRODUCTION_URL
  ? `https://${process.env.VERCEL_PROJECT_PRODUCTION_URL}`
  : process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000';

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  title: {
    default: 'Volume VI',
    template: '%s | Vol VI',
  },
  description:
    'Reducing the Riemann Hypothesis to a four-lemma No-Phantom Language, in Lean 4.',
  openGraph: {
    type: 'website',
    siteName: 'Vol VI',
    images: [{ url: '/og-images/paper-07-rh-classical-new-language.png', width: 1200, height: 630 }],
  },
  twitter: {
    card: 'summary_large_image',
    images: ['/og-images/paper-07-rh-classical-new-language.png'],
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <header className="navbar sticky top-0 z-50">
          <div style={{ maxWidth: '72rem', margin: '0 auto', padding: '0 1.5rem', display: 'flex', alignItems: 'center', justifyContent: 'space-between', height: '3.5rem' }}>
            <Link
              href="/"
              style={{ color: 'var(--accent)', fontFamily: 'Georgia, serif', fontSize: '0.875rem', fontWeight: 600, letterSpacing: '0.025em' }}
            >
              Vol VI
            </Link>
            <nav style={{ display: 'flex', gap: '1.25rem', alignItems: 'center', fontSize: '0.875rem', color: 'var(--text-muted)' }}>
              <Link href="/#papers" style={{ color: 'inherit' }} className="hover-link">Papers</Link>
              <a
                href="https://github.com/YonedaAI/hott-riemann-hypothesis-vol6"
                target="_blank"
                rel="noopener noreferrer"
                style={{ color: 'inherit' }}
                className="hover-link"
              >
                GitHub
              </a>
            </nav>
          </div>
        </header>

        <main style={{ minHeight: '100vh' }}>
          {children}
        </main>

        <footer style={{ borderTop: '1px solid var(--border)', background: 'var(--surface)', marginTop: '5rem' }}>
          <div style={{ maxWidth: '72rem', margin: '0 auto', padding: '2rem 1.5rem', display: 'flex', flexWrap: 'wrap', alignItems: 'center', justifyContent: 'space-between', gap: '0.75rem', fontSize: '0.875rem', color: 'var(--text-dim)' }}>
            <div>
              <span style={{ color: 'var(--accent)' }}>HoTT/Yoneda Riemann Hypothesis Programme</span>
              {' '}&mdash; Volume VI
            </div>
            <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
              <a
                href="https://github.com/YonedaAI/hott-riemann-hypothesis-vol6"
                target="_blank"
                rel="noopener noreferrer"
                style={{ color: 'var(--text-muted)' }}
              >
                GitHub
              </a>
              <span style={{ color: 'var(--border)' }}>|</span>
              <span>No <code>sorry</code> &middot; No <code>admit</code> &middot; No new <code>axiom</code></span>
            </div>
          </div>
        </footer>
      </body>
    </html>
  );
}
