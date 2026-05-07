'use client';
import { useState, useEffect } from 'react';

interface Heading {
  id: string;
  text: string;
  level: number;
}

export function TableOfContents({ headings }: { headings: Heading[] }) {
  const [activeId, setActiveId] = useState('');
  const [open, setOpen] = useState(false);

  useEffect(() => {
    const onScroll = () => {
      const scrollY = window.scrollY + 110;
      let current = '';
      for (const { id } of headings) {
        const el = document.getElementById(id);
        if (el && el.offsetTop <= scrollY) {
          current = id;
        }
      }
      setActiveId(current);
    };
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
    return () => window.removeEventListener('scroll', onScroll);
  }, [headings]);

  if (headings.length === 0) return null;

  return (
    <aside style={{ position: 'sticky', top: '5rem', maxHeight: 'calc(100vh - 6rem)', overflowY: 'auto' }}>
      {/* Mobile toggle */}
      <button
        onClick={() => setOpen((o) => !o)}
        style={{
          display: 'none',
          width: '100%',
          textAlign: 'left',
          padding: '0.5rem 0.75rem',
          background: 'var(--surface)',
          border: '1px solid var(--border)',
          borderRadius: '6px',
          color: 'var(--text-muted)',
          fontSize: '0.875rem',
          cursor: 'pointer',
          marginBottom: '0.5rem',
        }}
        className="toc-toggle"
      >
        {open ? '▾' : '▸'} Contents
      </button>

      <div className="toc-body" style={{ display: 'block' }}>
        <div style={{ fontSize: '0.6875rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.1em', color: 'var(--text-dim)', padding: '0 0.75rem', marginBottom: '0.5rem' }}>
          Contents
        </div>
        <nav>
          {headings.map(({ id, text, level }) => (
            <a
              key={id}
              href={`#${id}`}
              className={`toc-item ${level === 3 ? 'toc-sub' : ''} ${activeId === id ? 'toc-active' : ''}`}
            >
              {text}
            </a>
          ))}
        </nav>
      </div>

      <style>{`
        @media (max-width: 1023px) {
          .toc-toggle { display: block !important; }
          .toc-body { display: ${open ? 'block' : 'none'} !important; }
        }
      `}</style>
    </aside>
  );
}
