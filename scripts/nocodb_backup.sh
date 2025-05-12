#!/bin/sh

. discord_notif.sh
echo "imported discord messages"

# --- Configuration ---
CONTAINER_NAME="nocodb-t0oog4kssskwocwk0o0okwkg"
DB_PATH_IN_CONTAINER="/usr/app/data/noco.db"
BACKUP_DIR="/opt/nocodb_backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/nc_backup_$DATE.db"
BACKUP_PATTERN="nc_backup_*.db"
RETENTION_DIR="$BACKUP_DIR"

BACKUP_FILE="/opt/nocodb_backups/nc_backup_$DATE.db"

# --- Ensure backup directory exists ---
mkdir -p "$BACKUP_DIR"
echo "directory created: $BACKUP_DIR"

# --- Copy the database from the container to host ---
cp "$DB_PATH_IN_CONTAINER" "$BACKUP_FILE"
# docker cp "$CONTAINER_NAME:$DB_PATH_IN_CONTAINER" "$BACKUP_FILE"
echo "backed up: $BACKUP_FILE"
discord_backed

# Delete backups older than 1 day unless they are the newest of that day
find "$RETENTION_DIR" -name "$BACKUP_PATTERN" -type f -mmin +1440 | while read file; do
	FILE_DATE=$(basename "$file" | cut -d'_' -f3 | cut -d'-' -f1-3)
	DAY_FILES=$(find "$RETENTION_DIR" -name "nc_backup_${FILE_DATE}_*.db" -type f)
	NEWEST_FILE=$(ls -1t $DAY_FILES | head -n1)

	if [ "$file" != "$NEWEST_FILE" ]; then
		echo "Deleting old backup: $file"
		rm "$file"
	fi
done

# Optional: Delete backups older than 7 days
find "$RETENTION_DIR" -name "$BACKUP_PATTERN" -type f -mtime +7 -exec rm {} \;
