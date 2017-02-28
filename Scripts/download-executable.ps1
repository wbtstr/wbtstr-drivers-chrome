Add-Type -AssemblyName System.IO.Compression.FileSystem

$wc = New-Object Net.WebClient
$shell = New-Object -com Shell.Application

# Get URL of latest Chrome Driver
$latestRelease_url = "https://chromedriver.storage.googleapis.com/LATEST_RELEASE"
$latestRelease = $wc.DownloadString($latestRelease_url).Trim()

$zipChromeDriver_fileName = "chromedriver_win32.zip"
$zipChromeDriver_source = "https://chromedriver.storage.googleapis.com/{0}/{1}" -f $latestRelease, $zipChromeDriver_fileName
$zipChromeDriver_destination = Join-Path (Convert-Path ".") $zipChromeDriver_fileName

# Download and unpack .zip
$exeChromeDriver_destination = "..\\Source\\WbTstr.Drivers.Chrome"
$wc.DownloadFile($zipChromeDriver_source, $zipChromeDriver_destination)
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipChromeDriver_destination, $exeChromeDriver_destination)

Write-Host "Put Chrome Driver executable in '{0}'" -f $exeChromeDriver_destination
sleep(5)