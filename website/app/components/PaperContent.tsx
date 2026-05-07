'use client';
import { useCallback } from 'react';

// NOTE: html here is our own pandoc + KaTeX pre-rendered build-time output,
// not user-supplied content. The data comes from trusted static source files.
export function PaperContent({ html }: { html: string }) {
  const contentRef = useCallback((node: HTMLDivElement | null) => {
    if (node) {
      // Use ref callback to bypass React hydration reconciliation for KaTeX HTML
      node.innerHTML = html; // nosec - static trusted build-time HTML, not user input
    }
  }, [html]);

  return <div ref={contentRef} className="paper-content" />;
}
