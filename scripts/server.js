const express = require("express");
const { exec } = require("child_process");
const app = express();
const PORT = process.env.PORT || 3005;

app.use(express.json());

app.post("/trigger-backup", (req, res) => {
  const command =
    'docker run --rm --privileged -v /:/mnt alpine sh -c "chroot /mnt sh /root/scripts/nocodb_backup.sh"';
  exec(command, (error, stdout, stderr) => {
    if (error) {
      console.error(`Backup error: ${error.message}`);
      return res.status(500).send("Backup failed");
    }
    console.log(`Backup success!:\n${stdout}`);
    res.send("Backup triggered");
  });
});

app.listen(PORT, () => {
  console.log(`Webhook listener running on port ${PORT}`);
});

