#!/usr/bin/env bash
# convert all .mp4 to .opus

set -euo pipefail

# Проверка наличия ffmpeg
if ! command -v ffmpeg &>/dev/null; then
    echo "Error: ffmpeg is not found. Please install ffmpeg and rerun the script." >&2
    exit 1
fi

# Processing
for input_file in *.mp4; do
    [[ -f "$input_file" ]] || continue

    output_file="${input_file%.mp4}.opus"
    echo "→ Processing '$input_file' → '$output_file'..."

    if ffmpeg -i "$input_file" -vn -c:a libopus -b:a 128k "$output_file" -y &>/dev/null; then
        echo "✔ File '$output_file' created sucessfully."
    else
        echo "✖ Processing error '$input_file'." >&2
    fi
done

echo "✅ All files were processed."
