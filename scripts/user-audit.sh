#!/bin/bash
# -----------------------------------------
# Tool Name : user-audit.sh
# Purpose   : Audit users, admin privileges,
#             detect suspicious accounts
# Author    : Srivatsa
# Version   : v2
# -----------------------------------------

# ================= SECURITY CONFIG =================

LOG_DIR="../logs"
LOG_FILE="$LOG_DIR/user-audit.log"

# List of known safe admin accounts
SAFE_ADMINS=("Administrator" "sriva")

# Create logs directory if it doesn't exist
mkdir -p "$LOG_DIR"

# ================= LOGGING FUNCTION =================

log_event() {
    local level="$1"
    local message="$2"
    local timestamp

    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp [$level] $message" | tee -a "$LOG_FILE"
}

# ================= USER AUDIT =================

log_event "INFO" "Starting user audit"

log_event "INFO" "Listing all local users"
net user

# ================= ADMIN AUDIT =================

log_event "INFO" "Checking administrators group"

ADMIN_USERS=$(net localgroup administrators | sed -n '/^---/ ,$p' | tail -n +2 | sed '/command completed/d')

for user in $ADMIN_USERS; do
    SAFE=false

    for safe_user in "${SAFE_ADMINS[@]}"; do
        if [[ "$user" == "$safe_user" ]]; then
            SAFE=true
            break
        fi
    done

    if [[ "$SAFE" == false ]]; then
        log_event "ALERT" "Suspicious admin account detected: $user"
    else
        log_event "INFO" "Trusted admin account found: $user"
    fi
done

log_event "INFO" "User audit completed"
