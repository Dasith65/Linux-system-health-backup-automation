#!/bin/bash

PROJECT="$HOME/linux-automation-project"
SOURCE="$HOME/backup-demo"
BACKUP="$PROJECT/backups"
LOG="$PROJECT/automation.log"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG"
}

echo "===== SYSTEM HEALTH CHECK ====="

# Disk Monitoring
DISK=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "Disk Usage: ${DISK}%"

if [ "$DISK" -lt 60 ]; then
    echo "Disk Status: HEALTHY"
elif [ "$DISK" -lt 80 ]; then
    echo "Disk Status: WARNING"
else
    echo "Disk Status: CRITICAL"
fi

log_message "Disk usage: ${DISK}%"

# RAM Monitoring
read TOTAL USED <<< "$(free -m | awk '/^Mem:/ {print $2, $3}')"

RAM=$((USED * 100 / TOTAL))

echo "RAM Usage: ${RAM}%"

if [ "$RAM" -lt 60 ]; then
    echo "RAM Status: HEALTHY"
elif [ "$RAM" -lt 80 ]; then
    echo "RAM Status: WARNING"
else
    echo "RAM Status: CRITICAL"
fi

log_message "RAM usage: ${RAM}%"

# Automated Backup
if [ ! -d "$SOURCE" ]; then
    echo "ERROR: Source directory not found!"
    log_message "ERROR: Source directory not found!"
    exit 1
fi

if ! mkdir -p "$BACKUP"; then
    echo "ERROR: Cannot create backup directory!"
    log_message "ERROR: Cannot create backup directory!"
    exit 1
fi

FILE="$BACKUP/backup-$TIMESTAMP.tar.gz"

if tar -czf "$FILE" -C "$HOME" "backup-demo"; then
    echo "Backup: SUCCESS"
    log_message "SUCCESS: Backup created at $FILE"
else
    echo "Backup: FAILED"
    log_message "ERROR: Backup failed"
    rm -f "$FILE"
    exit 1
fi

echo "===== AUTOMATION COMPLETE ====="
log_message "Automation completed"
