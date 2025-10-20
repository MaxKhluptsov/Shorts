# all .mp4 to .opus
# Check if ffmpeg is available
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Host "Error: ffmpeg not found. Please install ffmpeg and rerun the script." -ForegroundColor Red
    exit 1
}

Get-ChildItem -Filter *.mp4 | ForEach-Object {
    $inputFile = $_.FullName
    $outputFile = [System.IO.Path]::ChangeExtension($inputFile, ".opus")

    Write-Host "→ Конвертация '$($inputFile)' → '$($outputFile)'" -ForegroundColor Cyan

    & ffmpeg -i "$inputFile" -vn -c:a libopus -b:a 128k "$outputFile" -y | Out-Null

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✔ File '$($outputFile)' is sucssesfully done." -ForegroundColor Green
    }
    else {
        Write-Host "✖ Processing error '$($inputFile)'" -ForegroundColor Red
    }
}

Write-Host "✅ All files converion is completed." -ForegroundColor Yellow