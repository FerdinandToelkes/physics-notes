$pdf_mode = 1;               # use pdflatex
$out_dir = 'build';          # keep aux/log/pdf out of the repo root
$aux_dir = 'build';
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$max_repeat = 5;              # make sure cross-references/TOC always settle on first build
