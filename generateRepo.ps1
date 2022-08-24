
$jsonFiles = gci */*.json
$content = ($jsonFiles | % { (gc -Raw $_) }) -Join ("," + [System.Environment]::NewLine)
$content = "{" + [System.Environment]::NewLine + $content + [System.Environment]::NewLine + "}"

Out-File -InputObject $content -FilePath repo.json -Encoding utf8
