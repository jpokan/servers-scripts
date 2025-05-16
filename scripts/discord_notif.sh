#!/bin/sh

. ./.env #WEBHOOK_URL

discord_backed() {
	BODY="{\"username\": \"Server\", \"content\": \"> **Express** - \`backup_trigger\` - Backed Up! - file: ||nc_backup_$DATE.db|| \"}"
	curl -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"
}

discord_cleaned() {
	BODY="{\"username\": \"Server\", \"content\": \"> **Express** - \`backup_trigger\` - Cleaned Up! \"}"
	curl -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"
}
