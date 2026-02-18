param(
    [switch]$Detailed,
    [switch]$Export,
    [string]$OutputPath = "results.json"
)

$Results = @{
    Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    SystemInfo = @{}
    SecurityChecks = @{}
    Vulnerabilities = @()
}

function Get-SystemInformation {

    $Results.SystemInfo.OSVersion = (Get-CimInstance Win32_OperatingSystem).Caption
    $Results.SystemInfo.Architecture = (Get-CimInstance Win32_OperatingSystem).OSArchitecture
    $Results.SystemInfo.Domain = (Get-CimInstance Win32_ComputerSystem).Domain
    $Results.SystemInfo.CurrentUser = $env:USERNAME

    $adminCheck = ([Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")

    $Results.SystemInfo.IsAdmin = $adminCheck
}

function Get-UserPrivileges {

    $groups = whoami /groups
    $Results.SecurityChecks.UserGroups = $groups

    if ($groups -match "S-1-5-32-544") {
        $Results.SecurityChecks.IsAdministrator = $true
    } else {
        $Results.SecurityChecks.IsAdministrator = $false
    }
}

function Test-SecurityConfiguration {

    $uac = Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
    $Results.SecurityChecks.UACEnabled = $uac.EnableLUA

    $lsa = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
    $Results.SecurityChecks.LSAProtection = $lsa.RunAsPPL

    try {
        $wdigest = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest"
        $Results.SecurityChecks.WDigestUseLogonCredential = $wdigest.UseLogonCredential
    } catch {
        $Results.SecurityChecks.WDigestUseLogonCredential = "Not Found"
    }
}

function Get-VulnerableProcesses {

    $systemProcs = Get-Process | Where-Object { $_.SI -eq 0 }
    $Results.SecurityChecks.SystemProcesses = $systemProcs.Name

    $lsass = Get-Process -Name lsass -ErrorAction SilentlyContinue
    if ($lsass) {
        $Results.SecurityChecks.LSASSRunning = $true
    }
}

function Get-PrivilegeEscalationVectors {

    if ($Results.SecurityChecks.WDigestUseLogonCredential -eq 1) {
        $Results.Vulnerabilities += "WDigest storing plaintext credentials"
    }

    if (-not $Results.SecurityChecks.LSAProtection) {
        $Results.Vulnerabilities += "LSA Protection not enabled"
    }

    if (-not $Results.SecurityChecks.IsAdministrator) {
        $Results.Vulnerabilities += "User lacks admin privileges"
    }
}

function Export-Results {

    $Results | ConvertTo-Json -Depth 5 | Out-File $OutputPath
    Write-Host "Results exported to $OutputPath"
}

function Main {

    Write-Host "Privilege Escalation Assessment Tool" -ForegroundColor Cyan

    Get-SystemInformation
    Get-UserPrivileges
    Test-SecurityConfiguration
    Get-VulnerableProcesses
    Get-PrivilegeEscalationVectors

    if ($Export) {
        Export-Results
    }

    Write-Host "Assessment Complete"
}

Main
