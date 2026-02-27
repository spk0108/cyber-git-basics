#!/bin/bash

# ==============================
# SERVICE AUDIT TOOL v2
# Git Bash Compatible
# Author  : Srivatsa
# Purpose : Detect unusual background services
# ==============================

echo "===================================="
echo "         SERVICE AUDIT REPORT"
echo "===================================="
echo "Date & Time : $(date)"
echo "Hostname    : $(hostname)"
echo "User        : $(whoami)"
echo ""

# ---------------------------------
# Section 1: Running Processes
# ---------------------------------
echo "[INFO] Running Processes (Sample View):"
ps | head -n 10
echo ""

# ---------------------------------
# Section 2: Background Process Check
# ---------------------------------
echo "[INFO] Checking for unusual background processes..."

FOUND=0

ps | while read -r LINE
do
    # Skip header
    if echo "$LINE" | grep "PID" >/dev/null; then
        continue
    fi

    # Ignore normal Git Bash processes
    if echo "$LINE" | grep -E "bash|mintty|ps" >/dev/null; then
        continue
    fi

    # If no tty/pty detected, possible background
    if ! echo "$LINE" | grep -E "tty|pty" >/dev/null; then
        echo "[WARN] Background-like process detected:"
        echo "       $LINE"
        echo ""
        FOUND=1
    fi
done

if [[ $FOUND -eq 0 ]]; then
    echo "[OK] No unusual background services detected"
fi

echo ""

# ---------------------------------
# Section 3: Suspicious Keywords
# ---------------------------------
echo "[INFO] Checking for suspicious service keywords..."

SUSPICIOUS=("nc" "netcat" "ncat" "python" "perl" "ruby" "php")

for keyword in "${SUSPICIOUS[@]}"
do
    if ps | grep -i "$keyword" | grep -v grep >/dev/null; then
        echo "[ALERT] Suspicious keyword detected: $keyword"
    fi
done

echo ""

# ---------------------------------
# Summary
# ---------------------------------
echo "===================================="
echo "      SERVICE AUDIT COMPLETED"
echo "===================================="
