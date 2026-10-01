#!/bin/bash

# Verifies if the user provided a .tex file as an argument
if [ -z "$1" ]; then
    echo "Error : .tex file not provided"
    echo "Example: ./tex2svg.sh file.tex"
    exit 1
fi
echo  "Input file: $1"

# Files and paths
TEXFILE="$(realpath "$1")"
BASENAME="$(basename "$TEXFILE" .tex)"
OUTPUTDIR="$(dirname "$TEXFILE")"
DVI="$OUTPUTDIR/$BASENAME.dvi"
SVG="$OUTPUTDIR/$BASENAME.svg"

# Verification that the provided file has a .tex extension
if [[ "$TEXFILE" != *.tex ]]; then
    echo "Error: file extension is not .tex."
    exit 1
fi

# Verification that latex and dvisvgm are installed
for cmd in latex dvisvgm; do
    if ! command -v $cmd &> /dev/null; then
        echo "Error: $cmd is not installed or cannot be found in PATH."
        exit 1
    fi
done

# Compilation of .tex to DVI
echo "Compilando $TEXFILE a DVI..."
latex -interaction=nonstopmode -halt-on-error -output-directory="$OUTPUTDIR" "$TEXFILE" > /dev/null
if [ $? -ne 0 ]; then
    echo "Error compiling LaTeX."
    exit 1
fi

# Conversion from DVI to SVG
echo "Converting DVI to SVG..."
dvisvgm --no-fonts "$DVI" "$SVG"

# Cleanup of intermediate files
rm -f "$DVI" "$OUTPUTDIR/$BASENAME.aux" "$OUTPUTDIR/$BASENAME.log" "$OUTPUTDIR/$BASENAME.out"

echo "Conversion completed: $SVG"
