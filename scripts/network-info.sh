#!/bin/bash

LOGFILE="network_info_$(date +%Y-%m-%d_%H-%M-%S).log"

{
  echo "===== SYSTEM & NETWORK INFORMATION ====="
  echo "Collected on: $(date)"
  echo ""

  echo "Hostname:"
  hostname
  echo ""

  echo "Current User:"
  whoami
  echo ""

  echo "IP Configuration:"
  ipconfig
  echo ""
} | tee "$LOGFILE"

echo "Information saved to $LOGFILE"
