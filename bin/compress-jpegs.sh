#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $(basename "$0") <input_dir> <output_dir>"
    echo "Compresses JPEGs/HEIF to JPEG using macOS sips while preserving metadata."
    exit 1
}

[[ $# -ne 2 ]] && usage

input_dir="$(cd "$1" && pwd)"
mkdir -p "$2"
output_dir="$(cd "$2" && pwd)"

if [[ "$input_dir" == "$output_dir" ]]; then
    echo "Error: Input and output directories must be different."
    exit 1
fi

count=0
while IFS= read -r -d '' file; do
    basename="$(basename "$file")"
    size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    outfile="$output_dir/${basename%.*}_compressed.jpg"
    echo "Compressing: $basename ($(( size / 1024 / 1024 ))MB)"
    sips -s format jpeg -s formatOptions 50 "$file" --out "$outfile"
    count=$((count + 1))
done < <(find "$input_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.heic' -o -iname '*.heif' -o -iname '*.hif' \) -print0)

echo "Done. Compressed $count file(s) to $output_dir"
