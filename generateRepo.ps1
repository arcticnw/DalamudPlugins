function ProcessConfigFile {
  param (
    [System.IO.FileSystemInfo] $File
  )

  $name = $File.Name -Replace ".json"

  $raw = gc -Raw $File
  $raw = $raw -Replace "[\r\n]+\}$" 

  return $raw + "," + [System.Environment]::NewLine + `
    "  ""IsHide"": ""False""," + [System.Environment]::NewLine + `
    "  ""IsTestingExclusive"": ""False""," + [System.Environment]::NewLine + `
    "  ""DownloadCount"": 0," + [System.Environment]::NewLine + `
    "  ""LastUpdate"": 0," + [System.Environment]::NewLine + `
    "  ""LoadPriority"": 0," + [System.Environment]::NewLine + `
    "  ""DownloadLinkInstall"": ""https://raw.githubusercontent.com/arcticnw/DalamudPlugins/master/" + $name + "/latest.zip""" + [System.Environment]::NewLine + `
    "}"
}

$jsonFiles = gci */*.json
$content = ($jsonFiles | % { ProcessConfigFile -File $_ }) -Join ("," + [System.Environment]::NewLine)
$content = "[" + [System.Environment]::NewLine + $content + [System.Environment]::NewLine + "]"

Out-File -InputObject $content -FilePath repo.json -Encoding utf8
