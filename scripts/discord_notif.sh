#!/bin/sh

WEBHOOK_URL="https://discord.com/api/webhooks/1368547031450390570/f9aZcNA1ixgrRFaR7-DDAK8T6NCdD8fC5OfZ5yES7WBJ1komcc8C3Vxbuq_DoSQsFFdQ"

discord_backed() {
	echo "discord_backed"
	# 	BODY="{\"username\": \"Server\", \"content\": \"> **Express** - \`backup_trigger\` - Backed Up! - file: ||nc_backup_$DATE.db|| \"}"
	# 	curl -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"
}

discord_cleaned() {
	echo "start discord_cleaned"
	# BODY="{"username": "Server", "content": "> **Express** - `backup_trigger` - Cleaned Up! - files: "}"
	# cat "$TEMP_FILE"
	# echo "$BODY"
	# CONTENT=$(cat "$TEMP_FILE")
	# BODY=$(printf '%s\n%s\n%s\n' \
	# '{"username": "Server", "content": "> **Express** - `backup_trigger` - Cleaned Up! - files:\n```' \
	# "$CONTENT" \
	# '```"}')
	# echo "$BODY"
	# curl https://discord.com
	# curl -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"
	BODY="{\"content\":\"Test message!\"}"
	# echo "$BODY"
	# curl \
	#     -v \
	#     -H "Content-Type: application/json" \
	#     -d $BODY \
	#     $WEBHOOK_URL
	# curl -v -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"

	echo "end discord_cleaned"
	# 	BODY="{\"username\": \"Server\", \"content\": \"> **Express** - \`backup_trigger\` - Cleaned Up! - files: \n\`\`\`\n\`\`\` \"}"
	# 	curl -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"
}
