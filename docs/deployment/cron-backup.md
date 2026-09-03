# ⭐ Cloud VM Auto‑Backup Cron Job (Nightly at 3:00 AM)

This cron job will:

- run your backup script  
- create a timestamped archive  
- copy it to your external drive (if connected)  
- log the results  
- keep your studio safe without manual work  

### 1️⃣ Copy your backup script to the cloud VM  
If it’s already in your repo (it is), your cloud VM will get it automatically when you run:

```bash
./deploy.sh
```

Your script lives at:

```bash
viper-studios/scripts/backup_external_drive.sh
```

---

# 2️⃣ Make the script executable on the cloud VM

SSH into your VM:

```bash
ssh viper@YOUR_CLOUD_IP
```

Then:

```bash
chmod +x ~/viper-studios/scripts/backup_external_drive.sh
```

---

# 3️⃣ Create a cron job entry

Open the cron editor:

```bash
crontab -e
```

Add this line:

```bash
0 3 * * * /home/viper/viper-studios/scripts/backup_external_drive.sh >> /home/viper/viper-backup.log 2>&1
```

### What this does:

- `0 3 * * *` → runs every night at **3:00 AM**
- Executes your backup script
- Logs output to `/home/viper/viper-backup.log`

Your cloud VM now performs **automatic nightly backups**.
