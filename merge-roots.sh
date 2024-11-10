#!/usr/bin/env sh

# Check if at least two arguments (archives) are provided
if [ "$#" -lt 2 ]; then
    echo "Usage: $(basename $0) <archive1.tar.gz> <archive2.tar.gz> ..."
    exit 1
fi

output_archive="output_archive.tar.gz"

tmp_dir=$(mktemp -d)
if [ ! -d "$tmp_dir" ]; then
    echo "Failed to create temporary directory."
    exit 1
fi

# Extract each archive into the temporary directory
for archive in "$@"; do
    if [ -f "$archive" ]; then
        tar -xzf "$archive" -C "$tmp_dir"
    else
        echo "Archive $archive does not exist."
        rm -rf "$tmp_dir"
        exit 1
    fi
done

tar -czf "$output_archive" -C "$tmp_dir" .

rm -rf "$tmp_dir"

echo "Merged archive created at $(realpath $output_archive)"
