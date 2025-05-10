#!/bin/bash

WEBHOOK_URL="https://discord.com/api/webhooks/1368547031450390570/f9aZcNA1ixgrRFaR7-DDAK8T6NCdD8fC5OfZ5yES7WBJ1komcc8C3Vxbuq_DoSQsFFdQ"
discord_backed() {
	BODY="{\"username\": \"Server\", \"content\": \"> **Express** - \`backup_trigger\` - Backed Up! - file: ||nc_backup_$DATE.db|| \"}"
	curl -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"
}

discord_cleaned() {
	BODY="{\"username\": \"Server\", \"content\": \"> **Express** - \`backup_trigger\` - Cleaned Up! - files: \n\`\`\`\n$deleted_string\`\`\` \"}"
	curl -H "Content-Type: application/json" -d "$BODY" "$WEBHOOK_URL"
}
