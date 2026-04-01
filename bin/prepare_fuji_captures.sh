#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

usage() {
    echo "Usage: $(basename "$0") <capture_dir>"
    echo "Organizes Fuji captures: RAWs, stills, and compressed JPEGs."
    exit 1
}

[[ $# -ne 1 ]] && usage

capture_dir="$(cd "$1" && pwd)"

echo "Organizing captures in: $capture_dir"
echo ""

raws_dir="$capture_dir/raws"
stills_dir="$capture_dir/stills"
shared_dir="$capture_dir/shared-small"
wa_dir="$capture_dir/wa"
videos_dir="$capture_dir/videos"

echo "Creating directories..."
mkdir -v -p "$raws_dir" "$stills_dir" "$shared_dir" "$wa_dir" "$videos_dir"
echo ""

# Move RAW files
echo "Moving RAW files to raws/..."
find "$capture_dir" -maxdepth 1 -type f \( -iname '*.raf' -o -iname '*.raw' \) -exec mv -v {} "$raws_dir/" \;
echo ""

# Move JPEG and HEIF files
echo "Moving JPEG/HEIF files to stills/..."
find "$capture_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.heic' -o -iname '*.heif' -o -iname '*.hif' \) -exec mv -v {} "$stills_dir/" \;
echo ""

# Move video files
echo "Moving video files to videos/..."
find "$capture_dir" -maxdepth 1 -type f \( -iname '*.mov' -o -iname '*.mp4' -o -iname '*.avi' -o -iname '*.mkv' \) -exec mv -v {} "$videos_dir/" \;
echo ""

# Compress for sharing
echo "Compressing images to shared-small/..."
"$SCRIPT_DIR/compress-jpegs.sh" "$stills_dir" "$shared_dir"
echo ""

# Compress for WhatsApp
echo "Compressing images to wa/..."
"$SCRIPT_DIR/compress-jpegs.sh" "$stills_dir" "$wa_dir" 10

echo "Done. Structure:"
echo "  $raws_dir"
echo "  $stills_dir"
echo "  $shared_dir"
echo "  $wa_dir"
echo "  $videos_dir"
