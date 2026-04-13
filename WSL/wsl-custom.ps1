# script to create a wsl distro with a custom name and install a specific Linux distribution
# usage: .\wsl-custom.ps1 -DistroName "MyDistro" -LinuxDistro "Ubuntu" -LinuxUser ""
# default Linux distribution is "Ubuntu 24.04"

param (
    [string]$DistroName = "MyDistro",
    [string]$LinuxDistro = "Ubuntu 24.04"
)

# Check if the specified Linux distribution is valid
$validDistros = @("Ubuntu 24.04")
if (-not $validDistros.Contains($LinuxDistro)) {
    Write-Host "Invalid Linux distribution specified. Valid options are: $($validDistros -join ', ')" -ForegroundColor Red
    exit 1
}

# Check if the specified WSL distribution name already exists
$existingDistros = wsl --list --quiet
if ($existingDistros -contains $DistroName) {
    Write-Host "A WSL distribution with the name '$DistroName' already exists. Please choose a different name." -ForegroundColor Red
    exit 1
}

# Install the specified Linux distribution
Write-Host "Installing $LinuxDistro as $DistroName..." -ForegroundColor Green
wsl --install -d $LinuxDistro --name $DistroName

# Set the default user for the new distribution if 'LinuxUser' is not empty
if ($LinuxUser) {
    Write-Host "Setting default user to '$LinuxUser' for $DistroName..." -ForegroundColor Green
    wsl --set-default-user $LinuxUser -d $DistroName
}
Write-Host "WSL distribution '$DistroName' with Linux distribution '$LinuxDistro' has been installed successfully." -ForegroundColor Green
