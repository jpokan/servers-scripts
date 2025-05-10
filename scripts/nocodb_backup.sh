#!/bin/bash

# NocoDB
# This script makes backups for the nocodb SQLite database file, it copies the file inside the container instance and saves it on the selected host machine directory $BACKUP_DIR
#
# 1. Set a cron task from the host server
# crontab -e
#
# 2. Paste this on the opened crontab file (example: run daily at 2 AM)
# 0 2 * * * /root/scripts/nocodb_backup.sh >> /var/log/nocodb_backup.log 2>&1
#
# 3. To make the script executable
# sudo chmod +x /root/scripts/nocodb_backup.sh
#
# 4. Test by running the script
# ./nocodb_backup.sh
#
# Extras (original)
#
# Manually copy the file on your server
# docker cp CONTAINER_NAME:/usr/app/data/noco.db ~/noco.db
#
# Copy to your local machine
# scp root@SERVER_IP_ADDRESS:~/noco.db ./noco.db
# scp root@SERVER_IP_ADDRESS:~/nocodb/nc_backup_2025-05-09_19-03-17.db ./noco.db

# --- Configuration ---
CONTAINER_NAME="nocodb-t0oog4kssskwocwk0o0okwkg" # Replace with your NocoDB container name
DB_PATH_IN_CONTAINER="/usr/app/data/noco.db"     # Default NocoDB SQLite path
BACKUP_DIR="/root/nocodb"                        # Where backups will be stored on the host
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/nc_backup_$DATE.db"

# --- Ensure backup directory exists ---
mkdir -p "$BACKUP_DIR"

# --- Copy the database from the container to host ---
docker cp "$CONTAINER_NAME:$DB_PATH_IN_CONTAINER" "$BACKUP_FILE"

# --- Optional: clean up old backups (older than 7 days) ---
find "$BACKUP_DIR" -name "nc_backup_*.db" -type f -mtime +7 -exec rm {} \;

# --- Done ---
echo "Backup saved to $BACKUP_FILE"
