# Physics Reference Notes

A personal collection of derivations and techniques that are missing, scattered, or explained too briefly in the standard literature. The current PDF can be found in [`build/main.pdf`](build/main.pdf).

## Structure

```
main.tex                             <- master document (shared preamble + \subfile{} list)
preamble.sty                         <- shared packages and macros
notes/
  similarity_transformations/main.tex        <- one self-contained note per topic, each in its own dir
  tensor_product/main.tex
  jordan_wigner/main.tex
  wirtinger_derivatives/main.tex
  density_matrix_entanglement_svd/main.tex
  refreshers/                       <- shorter background/review notes, one subdir each
    spin/main.tex
    unitary_transformations/main.tex
    current_in_electrodynamics/main.tex
.latexmkrc                           <- build config (output goes to build/, keeps repo clean)
.vscode/                             <- editor settings (see below)
```

Each topic gets its own directory under `notes/` containing a `main.tex`. That file is a [`subfiles`](https://ctan.org/pkg/subfiles) document: it can be compiled **on its own** (fast iteration while writing a single note) or pulled into the top-level `main.tex` to produce one combined PDF with a table of contents. Shared packages and macros (e.g. `\ad` for the adjoint action) live once in `preamble.sty` and subfiles automatically inherit it, so don't redefine them locally.

## Adding a new note

1. Create a new directory under `notes/` (or `notes/refreshers/` for a short
   background note), e.g. `notes/your-new-note/main.tex`. Copy an existing
   note as a template and keep the `\documentclass[...]{subfiles}` line,
   adjusting the relative path to `main.tex` to match the new file's depth
   (e.g. `../../main.tex` for a note directly under `notes/`, one more `../`
   for notes under `notes/refreshers/`) — it's what makes standalone
   compiling work.
2. Add a line `\subfile{notes/your-new-note/main}` to the top-level `main.tex`.
3. Compile either the new file directly, or `main.tex` for the full book.

## Prerequisites

- A LaTeX distribution providing `pdflatex` and `latexmk`:
  - Linux Fedora: `sudo dnf install texlive-scheme-full` (or a smaller subset, e.g.
    `texlive-latex-extra texlive-science latexmk`)
  - macOS: [MacTeX](https://tug.org/mactex/)
  - Windows: [MiKTeX](https://miktex.org/) (includes latexmk) or TeX Live
- [VS Code](https://code.visualstudio.com/)
- The **LaTeX Workshop** extension (`James-Yu.latex-workshop`) - VS Code will prompt you to install it automatically on opening this folder, since it's listed in `.vscode/extensions.json`.

## Building

With LaTeX Workshop installed, just save a `.tex` file (`Cmd/Ctrl+S`) and it builds automatically (`latexmk`, configured in `.vscode/settings.json`); the PDF opens in a VS Code tab with SyncTeX enabled (click in the PDF to jump to source, or `Ctrl+Alt+J` from source to jump to the PDF location).

From the command line, equivalently:
```bash
latexmk main.tex                                    # full combined document
latexmk notes/similarity_transformations/main.tex   # just one note, standalone
latexmk -c                                          # clean build artifacts
```

All build output goes to `build/` (configured in `.latexmkrc`). Most of it is
git-ignored, with one exception: `build/main.pdf`, the combined document, is
tracked so it can be downloaded straight from GitHub without a local LaTeX
install. Remember to rebuild and commit it after changing any note.

## Git workflow

- Commit early and often — one note (or one meaningful revision of a note)
  per commit is a reasonable granularity.
- Only `.tex` sources, `build/main.pdf`, and this README/config are tracked;
  everything else under `build/` (and `notes/*/build/`) is ignored, so
  `git status` should otherwise never show generated files.

