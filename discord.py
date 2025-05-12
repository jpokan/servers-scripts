import http.client
import json
import urllib.parse

webhook_url = "https://discord.com/api/webhooks/1368547031450390570/f9aZcNA1ixgrRFaR7-DDAK8T6NCdD8fC5OfZ5yES7WBJ1komcc8C3Vxbuq_DoSQsFFdQ"  # Replace this
message = "> **Server** - `backup_trigger` - Backup complete ✅"

parsed_url = urllib.parse.urlparse(webhook_url)

conn = http.client.HTTPSConnection(parsed_url.netloc)
headers = {
    "Content-Type": "application/json"
}

payload = {
    "username": "Server",
    "content": message
}

json_data = json.dumps(payload)

conn.request("POST", parsed_url.path, body=json_data, headers=headers)
response = conn.getresponse()

print(response.status, response.reason)
print(response.read().decode())

# print("hello!")

