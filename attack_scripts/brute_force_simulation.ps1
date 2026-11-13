# ==============================================================================
# Simulates failed logon attempts to generate Windows Event ID 4625
# ==============================================================================

# Target account for fake authentication attempts
$TargetUser = "fake_admin_account"
$PasswordList = @("P@ssword123", "Admin2026!", "12345678", "LetMeIn123!", "WrongPassword!")

Write-Host "[+] Starting Brute-Force Authentication Simulation..." -ForegroundColor Cyan

# Access native Windows Logon APIs
Add-Type -AssemblyName System.DirectoryServices.AccountManagement

foreach ($Password in $PasswordList) {
    Write-Host "[*] Attempting logon for user '$TargetUser' with password '$Password'..." -ForegroundColor Yellow
    
    # Attempting local credential validation against Windows SAM
    $pc = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine)
    $isValid = $pc.ValidateCredentials($TargetUser, $Password)
    
    # Pause for 1 second between attempts to simulate realistic thread timing
    Start-Sleep -Seconds 1
}

Write-Host "[+] Simulation complete." -ForegroundColor Green