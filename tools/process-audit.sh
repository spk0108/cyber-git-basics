#!/bin/bash

# ==============================
# PROCESS AUDIT TOOL v2.1
# Git Bash Compatible
# ==============================

echo "===================================="
echo "        PROCESS AUDIT REPORT"
echo "===================================="
echo "Date & Time : $(date)"
echo "Hostname    : $(hostname)"
echo "User        : $(whoami)"
echo ""

# ------------------------------
# Running processes (basic view)
# ------------------------------
echo "[+] Running processes (sample):"
ps | head -n 10
echo ""

# ------------------------------
# Suspicious shell detection
# ------------------------------
echo "[+] Checking for suspicious shell processes:"

SUSPICIOUS=0

ps | while read -r LINE
do
    if echo "$LINE" | grep -E "bash|sh" >/dev/null; then
        if ! echo "$LINE" | grep -E "tty|pty" >/dev/null; then
            echo "[!] Suspicious shell-like process:"
            echo "    $LINE"
            echo ""
            SUSPICIOUS=1
        fi
    fi
done

if [[ $SUSPICIOUS -eq 0 ]]; then
    echo "[✓] No suspicious shell processes detected"
fi

echo ""

# ------------------------------
# Processes of current user
# ------------------------------
echo "[+] Processes running as current user:"
ps | grep "$(whoami)" | head -n 5
echo ""

# ------------------------------
# Summary
# ------------------------------
echo "===================================="
echo "          AUDIT COMPLETED"
echo "===================================="
