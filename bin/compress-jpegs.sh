#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $(basename "$0") <input_dir> <output_dir>"
    echo "Compresses JPEGs/HEIF larger than 10MB to JPEG using macOS sips while preserving metadata."
    exit 1
}

[[ $# -ne 2 ]] && usage

input_dir="$1"
output_dir="$2"

if [[ ! -d "$input_dir" ]]; then
    echo "Error: Input directory '$input_dir' does not exist."
    exit 1
fi

if [[ "$(cd "$input_dir" && pwd)" == "$(mkdir -p "$output_dir" && cd "$output_dir" && pwd)" ]]; then
    echo "Error: Input and output directories must be different."
    exit 1
fi

mkdir -p "$output_dir"

count=0
while IFS= read -r -d '' file; do
    size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null)
    if (( size > 10 * 1024 * 1024 )); then
        basename="$(basename "$file")"
        outfile="$output_dir/${basename%.*}_compressed.jpg"
        echo "Compressing: $basename ($(( size / 1024 / 1024 ))MB)"
        sips -s format jpeg -s formatOptions 75 "$file" --out "$outfile"
        count=$((count + 1))
    fi
done < <(find "$input_dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.heic' -o -iname '*.heif' -o -iname '*.hif' \) -print0)

echo "Done. Compressed $count file(s) to $output_dir"
