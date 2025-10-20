for input_file in *.mp3; do
    if [[ -f "$input_file" ]]; then
        output_file="${input_file%.mp3}.ogg"
        ffmpeg -i "$input_file" -c:a libvorbis -qscale:a 4 "$output_file"
        if [[ $? -eq 0 ]]; then
            echo "File '$input_file' is converted to '$output_file'."
        else
            echo "error '$input_file'."
        fi
    else
        echo "File '$input_file' not found."
    fi
done
