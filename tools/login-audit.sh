#!/bin/bash
# login-audit.sh
# Windows Login Activity Audit Tool
# Author: Srivatsa
# Purpose: Detect recent failed and successful login attempts

echo "=========================================="
echo " WINDOWS LOGIN ACTIVITY AUDIT"
echo "=========================================="

LOGFILE="../logs/login-audit.log"
mkdir -p ../logs

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$1] $2" | tee -a "$LOGFILE"
}

# Failed logins (Event ID 4625)
log "INFO" "Checking recent FAILED login attempts (Event ID 4625)"

powershell.exe -Command "
\$failed = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 5 -ErrorAction SilentlyContinue
if (\$failed) {
    \$failed | Select-Object TimeCreated, Message
} else {
    Write-Output 'No recent failed login attempts detected.'
}
"

echo "------------------------------------------"

# Successful logins (Event ID 4624)
log "INFO" "Checking recent SUCCESSFUL login attempts (Event ID 4624)"

powershell.exe -Command "
\$success = Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4624} -MaxEvents 5 -ErrorAction SilentlyContinue
if (\$success) {
    \$success | Select-Object TimeCreated, Message
} else {
    Write-Output 'No recent successful logins detected.'
}
"

log "INFO" "Login audit completed"
