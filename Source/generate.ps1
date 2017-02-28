$wc = New-Object Net.WebClient
$shell = New-Object -com Shell.Application

# Get URL of latest Chrome Driver
$latestRelease_url = "https://chromedriver.storage.googleapis.com/LATEST_RELEASE"
$latestRelease = $wc.DownloadString($latestRelease_url).Trim()

$zipChromeDriver_fileName = "chromedriver_win32.zip"
$zipChromeDriver_source = "https://chromedriver.storage.googleapis.com/{0}/{1}" -f $latestRelease, $zipChromeDriver_fileName
$zipChromeDriver_destination = Join-Path (Convert-Path ".") $zipChromeDriver_fileName

# Download and unpack .zip
$exeChromeDriver_destination = (Convert-Path ".")
$wc.DownloadFile($zipChromeDriver_source, $zipChromeDriver_destination)

7z e $zipChromeDriver_fileName -o"$exeChromeDriver_destination" -y

# Create NuGet package
nuget pack WbTstr.Drivers.Chrome.nuspec -version $latestRelease

# Cleanup
Remove-Item $zipChromeDriver_fileName
Remove-Item "chromedriver.exe"