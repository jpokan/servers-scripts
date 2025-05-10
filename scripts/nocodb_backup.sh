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
# find "$BACKUP_DIR" -name "nc_backup_*.db" -type f -mtime +7 -exec rm {} \;

# Keep only the 5 most recent backups, delete the rest
# ls -1t "$BACKUP_DIR"/nc_backup_*.db | tail -n +6 | xargs -r rm --

# 1. Keep all backups from the last 24 hours
# 2. Keep only one backup per day from past 7 days
# 3. Delete anything else

# Set variables
BACKUP_PATTERN="nc_backup_*.db"
RETENTION_DIR="$BACKUP_DIR"
NOW=$(date +%s)

# Step 1: Delete backups older than 1 day that are not the most recent for that day
find "$RETENTION_DIR" -name "$BACKUP_PATTERN" -type f -mmin +1440 | while read -r file; do
	file_date=$(basename "$file" | cut -d'_' -f3 | cut -d'-' -f1-3)
	day_files=$(find "$RETENTION_DIR" -name "nc_backup_${file_date}_*.db" -type f)

	newest_file=$(ls -1t $day_files | head -n1)

	if [ "$file" != "$newest_file" ]; then
		echo "Deleting old backup: $file"
		rm "$file"
	fi
done

# Optional: Delete backups older than 7 days (even if they were the only one for the day)
find "$RETENTION_DIR" -name "$BACKUP_PATTERN" -type f -mtime +7 -exec rm {} \;

# --- Done ---
echo "Backup saved to $BACKUP_FILE"
