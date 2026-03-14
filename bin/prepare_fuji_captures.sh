#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

usage() {
    echo "Usage: $(basename "$0") <capture_dir>"
    echo "Organizes Fuji captures: RAWs, originals, and compressed JPEGs."
    exit 1
}

[[ $# -ne 1 ]] && usage

capture_dir="$(cd "$1" && pwd)"

echo "Organizing captures in: $capture_dir"
echo ""

raws_dir="$capture_dir/raws"
originals_dir="$capture_dir/originals"
shared_dir="$capture_dir/shared-small"

echo "Creating directories..."
mkdir -v -p "$raws_dir" "$originals_dir" "$shared_dir"
echo ""

# Move RAW files
echo "Moving RAW files to raws/..."
find "$capture_dir" -maxdepth 1 -type f \( -iname '*.raf' -o -iname '*.raw' \) -exec mv -v {} "$raws_dir/" \;
echo ""

# Move JPEG and HEIF files
echo "Moving JPEG/HEIF files to originals/..."
find "$capture_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.heic' -o -iname '*.heif' -o -iname '*.hif' \) -exec mv -v {} "$originals_dir/" \;
echo ""

# Compress
echo "Compressing images to shared-small/..."
"$SCRIPT_DIR/compress-jpegs.sh" "$originals_dir" "$shared_dir"

echo "Done. Structure:"
echo "  $raws_dir"
echo "  $originals_dir"
echo "  $shared_dir"
