# Physics Reference Notes

A personal collection of derivations and techniques that are missing, scattered,
or explained too briefly in the standard literature.

## Structure

```
main.tex                             <- master document (shared preamble + \subfile{} list)
notes/
  squeezing-transformation.tex       <- one self-contained note per topic
  similarity-transformations.tex
.latexmkrc                           <- build config (output goes to build/, keeps repo clean)
.vscode/                             <- editor settings (see below)
```

Each file in `notes/` is a [`subfiles`](https://ctan.org/pkg/subfiles) document:
it can be compiled **on its own** (fast iteration while writing a single note)
or pulled into `main.tex` to produce one combined PDF with a table of contents.
Shared packages and macros (e.g. `\ad` for the adjoint action) live once in
`main.tex`'s preamble — subfiles automatically inherit it, so don't redefine
them locally.

## Adding a new note

1. Copy `notes/similarity-transformations.tex` as a template (keep the
   `\documentclass[../main.tex]{subfiles}` line — it's what makes standalone
   compiling work).
2. Add a line `\subfile{notes/your-new-note}` to `main.tex`.
3. Compile either the new file directly, or `main.tex` for the full book.

## Prerequisites

- A LaTeX distribution providing `pdflatex` and `latexmk`:
  - Linux: `sudo apt install texlive-full` (or a smaller subset, e.g.
    `texlive-latex-extra texlive-science latexmk`)
  - macOS: [MacTeX](https://tug.org/mactex/)
  - Windows: [MiKTeX](https://miktex.org/) (includes latexmk) or TeX Live
- [VS Code](https://code.visualstudio.com/)
- The **LaTeX Workshop** extension (`James-Yu.latex-workshop`) — VS Code will
  prompt you to install it automatically on opening this folder, since it's
  listed in `.vscode/extensions.json`.

## Building

With LaTeX Workshop installed, just save a `.tex` file (`Cmd/Ctrl+S`) and it
builds automatically (`latexmk`, configured in `.vscode/settings.json`); the
PDF opens in a VS Code tab with SyncTeX enabled (click in the PDF to jump to
source, or `Ctrl+Alt+J` from source to jump to the PDF location).

From the command line, equivalently:
```bash
latexmk main.tex                       # full combined document
latexmk notes/squeezing-transformation.tex   # just one note, standalone
latexmk -c                             # clean build artifacts
```

All build output goes to `build/` (configured in `.latexmkrc`), which is
git-ignored, so the repo only ever tracks source.

## Git workflow

- Commit early and often — one note (or one meaningful revision of a note)
  per commit is a reasonable granularity.
- Only `.tex` sources (and this README/config) are tracked; `build/` is
  ignored, so `git status` should never show generated files.
