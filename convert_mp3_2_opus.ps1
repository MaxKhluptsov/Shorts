Get-ChildItem -Filter *.mp3 | ForEach-Object {
    $inputFile = $_.FullName
    $outputFile = [System.IO.Path]::ChangeExtension($inputFile, ".ogg")

    Write-Host "Working on the file: $($inputFile)" -ForegroundColor Cyan

    # Run ffmpeg
    ffmpeg -i "$inputFile" -c:a libvorbis -qscale:a 4 "$outputFile"

    # Cheking last exit code
    if ($LASTEXITCODE -eq 0) {
        Write-Host "File '$($_.Name)' is susscessfully converted to '$(Split-Path $outputFile -Leaf)'" -ForegroundColor Green
    }
    else {
        Write-Host "Error '$($_.Name)'" -ForegroundColor Red
    }
}
