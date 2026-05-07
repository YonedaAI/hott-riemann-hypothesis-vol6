import katex from 'katex';

const baseMacros: Record<string, string> = {
  '\\RH': '\\mathrm{RH}',
  '\\D': '\\mathbb{D}',
  '\\C': '\\mathbb{C}',
  '\\HtH': 'H^2',
  '\\HHH': 'H^2',
  '\\KB': 'K_B',
  '\\KBp': 'K_{B_P}',
  '\\KBP': 'K_{B_P}',
  '\\Yon': '\\mathbf{y}',
  '\\PSh': '\\mathsf{PSh}',
  '\\DQ': '\\mathbf{D}_{\\mathbb{Q}}',
  '\\NK': '\\mathcal{N}_K',
  '\\HardyTwo': 'H^2',
  '\\BurnolFactor': 'B_{\\mathrm{Burnol}}',
  '\\FiniteBlaschkePacket': '\\mathsf{FiniteBlaschkePacket}',
  '\\Obs': '\\mathcal{O}',
  '\\inner': '\\langle #1,#2\\rangle',
  '\\abs': '|#1|',
  '\\rank': '\\operatorname{rank}',
  '\\code': '\\mathtt{#1}',
  '\\slashed': '\\not{#1}',
  '\\bra': '\\langle #1|',
  '\\ket': '|#1\\rangle',
  '\\braket': '\\langle #1|#2\\rangle',
  '\\Hom': '\\operatorname{Hom}',
  '\\Tr': '\\operatorname{Tr}',
  '\\Lan': '\\operatorname{Lan}',
  '\\Ran': '\\operatorname{Ran}',
  '\\Complex': '\\mathbb{C}',
  '\\Rationals': '\\mathbb{Q}',
  '\\conj': '\\overline{#1}',
};

export function renderMathInHtml(html: string): string {
  // Handle display math: \[...\] and $$...$$
  let result = html;

  // Replace \[...\] display math
  result = result.replace(/\\\[([\s\S]*?)\\\]/g, (_match, tex) => {
    try {
      return katex.renderToString(tex.trim(), {
        displayMode: true,
        throwOnError: false,
        trust: true,
        macros: baseMacros,
      });
    } catch {
      return `<span class="katex-error">${tex}</span>`;
    }
  });

  // Replace $$...$$ display math
  result = result.replace(/\$\$([\s\S]*?)\$\$/g, (_match, tex) => {
    try {
      return katex.renderToString(tex.trim(), {
        displayMode: true,
        throwOnError: false,
        trust: true,
        macros: baseMacros,
      });
    } catch {
      return `<span class="katex-error">${tex}</span>`;
    }
  });

  // Replace \(...\) inline math
  result = result.replace(/\\\(([\s\S]*?)\\\)/g, (_match, tex) => {
    try {
      return katex.renderToString(tex.trim(), {
        displayMode: false,
        throwOnError: false,
        trust: true,
        macros: baseMacros,
      });
    } catch {
      return `<span class="katex-error">${tex}</span>`;
    }
  });

  // Replace $...$ inline math (careful not to catch $$)
  result = result.replace(/(?<!\$)\$(?!\$)((?:[^$\\]|\\[\s\S])*?)(?<!\$)\$(?!\$)/g, (_match, tex) => {
    try {
      return katex.renderToString(tex.trim(), {
        displayMode: false,
        throwOnError: false,
        trust: true,
        macros: baseMacros,
      });
    } catch {
      return `<span class="katex-error">${tex}</span>`;
    }
  });

  return result;
}
