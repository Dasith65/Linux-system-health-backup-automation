#  Linux System Health & Backup Automation

#  Project Overview

This project automates basic Linux system monitoring and backup tasks using Bash scripting on Ubuntu Linux.

The script monitors disk and RAM usage, creates timestamped compressed backups, and records execution results in a log file. Cron is used to schedule automatic execution.

## Technologies Used

- Ubuntu Linux
- Bash Scripting
- Cron Jobs
- Tar and Gzip
- AWK
- Linux Logging and Exit Codes

## Features

### 1. Disk Monitoring
Checks root filesystem disk usage and displays a status:
- Healthy: below 60%
- Warning: 60% to below 80%
- Critical: 80% or above

### 2. RAM Monitoring
Calculates RAM usage as a percentage of total memory and displays a status using the same thresholds.

### 3. Automated Backups
Creates timestamped `.tar.gz` archives of the `backup-demo` directory.

### 4. Error Handling
Checks whether the source directory exists and handles backup failures using non-zero exit codes.

### 5. Logging
Records disk usage, RAM usage, backup results, and errors in `automation.log`.

### 6. Scheduled Execution
Uses Cron to run the automation script daily at 12:05 AM.

## Project Structure

```text
linux-automation-project/
├── system-health-backup.sh
├── automation.log
├── README.md
└── backups/
    └── backup-YYYY-MM-DD_HH-MM-SS.tar.gz
```

## How to Run

1. Open a terminal in the project directory.
2. Make the script executable:

   `chmod +x system-health-backup.sh`

3. Run the script:

   `./system-health-backup.sh`

4. View backup files:

   `ls -lh backups/`

5. View execution logs:

   `tail -n 10 automation.log`

## Cron Configuration

Example Cron entry for daily execution at 12:05 AM:

`5 0 * * * /home/dasith/linux-automation-project/system-health-backup.sh`

Cron execution requires the Ubuntu virtual machine to be running at the scheduled time.

## Learning Outcomes

- Bash scripting and conditional statements
- Linux system monitoring
- Compressed backup creation and restoration concepts
- Error handling and exit codes
- Log management
- Task scheduling with Cron

## Project Status

Implemented and manually tested in an Ubuntu Linux virtual machine. Scheduled execution should be verified through Cron logs and generated backup files.

## Future Improvements

- Send notifications when disk usage reaches critical levels
- Automatically remove old backups based on a retention policy
- Add backup integrity checks
- Improve monitoring and failure reporting
