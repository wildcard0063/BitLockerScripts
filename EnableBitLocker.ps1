
# Enable BitLocker on C: drive with Recovery Key and TPM

# Logging function
function Log {
    param ([string]$Message)
    $LogFile = "$env:USERPROFILE\Documents\BitLocker_Status_Log.txt"
    Add-Content -Path $LogFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
}

# Check for administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as Administrator."
    Log "Script not run as Administrator. Exiting."
    exit 1
}

# Check BitLocker status for C: drive
$BitLockerVolume = Get-BitLockerVolume -MountPoint "C:"
if ($BitLockerVolume.ProtectionStatus -eq 1) {
    Write-Host "BitLocker is already enabled on the C: drive."
    Log "BitLocker is already enabled on the C: drive."
    exit 0
}

# Add recovery password protector
try {
    $RecoveryPassword = Add-BitLockerKeyProtector -MountPoint "C:" -RecoveryPasswordProtector
    $RecoveryPasswordFile = "$env:USERPROFILE\Documents\BitLocker_Recovery_Key.txt"
    $RecoveryPassword.KeyProtectorId | Out-File -FilePath $RecoveryPasswordFile
    Write-Host "Recovery password saved to $RecoveryPasswordFile."
    Log "Recovery password saved to $RecoveryPasswordFile."
} catch {
    Write-Host "Failed to create recovery password protector. Error: $_"
    Log "Failed to create recovery password protector. Error: $_"
    exit 1
}

# Enable BitLocker for C: drive
try {
    Write-Host "Enabling BitLocker on the C: drive with TPM and Recovery Password..."
    Log "Starting BitLocker encryption on the C: drive."
    Enable-BitLocker -MountPoint "C:" -EncryptionMethod XtsAes256 -UsedSpaceOnly -TpmProtector -SkipHardwareTest
    Write-Host "BitLocker enabled successfully on the C: drive."
    Log "BitLocker enabled successfully on the C: drive."
} catch {
    Write-Host "Failed to enable BitLocker. Error: $_"
    Log "Failed to enable BitLocker. Error: $_"
    exit 1
}

# Verify encryption status
$EncryptionStatus = Get-BitLockerVolume -MountPoint "C:" | Select-Object -ExpandProperty EncryptionPercentage
if ($EncryptionStatus -eq 100) {
    Write-Host "BitLocker encryption completed successfully."
    Log "BitLocker encryption completed successfully."
} else {
    Write-Host "BitLocker encryption is in progress. Check back later."
    Log "BitLocker encryption is in progress."
}
