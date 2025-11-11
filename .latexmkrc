# Always use pdflatex
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';

# Default output directory (optional)
$out_dir = 'build';

# Turn off automatic shell escape globally (safer)
$latex = 'pdflatex -no-shell-escape -interaction=nonstopmode -synctex=1 %O %S';

# Enable PDF mode by default
$pdf_mode = 1;

# Clean up typical auxiliary files
@generated_exts = qw(aux bbl blg fls fdb_latexmk log out toc synctex.gz);

# Print a concise summary at the end
$print_good = '=== LaTeXmk: Compilation succeeded ===';
$print_bad  = '=== LaTeXmk: Compilation failed ===';
