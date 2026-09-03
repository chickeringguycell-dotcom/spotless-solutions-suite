# ⭐ Viper Studios Disaster Recovery Guide

This is your **master checklist** for rebuilding Viper Studios from scratch after a catastrophic failure (cloud VM wiped, disks lost, etc.).

---

## 1️⃣ Recreate the Cloud VM

**Steps:**

- **Create new VM** on DigitalOcean/Linode/AWS/Azure:
  - Ubuntu 22.04 LTS  
  - 2 GB RAM, 50 GB SSD minimum  
- **Get:**
  - New public IP  
  - SSH credentials  

---

## 2️⃣ Install Core Dependencies

**On the new VM:**

```bash
sudo apt update
sudo apt install docker.io docker-compose git -y
sudo systemctl enable docker
sudo systemctl start docker
```

---

## 3️⃣ Reconnect Tailscale (Private Access)

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

- Open the auth link in your browser.
- Log in with your Tailscale account.
- (Optional) rename host:

```bash
sudo tailscale set --hostname viper-cloud
```

---

## 4️⃣ Reclone Your GitHub Repository

```bash
git clone https://github.com/YOUR-USERNAME/viper-studios.git
cd viper-studios/cloud-deployment
chmod +x deploy.sh
```

---

## 5️⃣ Restore From Backup (If You Have One)

Upload your latest backup archive to the VM:

```bash
scp viper_backup_YYYYMMDD_HHMMSS.tar.gz viper@YOUR_CLOUD_IP:/home/viper/
```

Run the restore script:

```bash
cd ~/viper-studios
chmod +x scripts/restore_media.sh
./scripts/restore_media.sh /home/viper/viper_backup_YYYYMMDD_HHMMSS.tar.gz
```

This:

- Stops containers  
- Restores `/media` + `/config` volumes  
- Restarts Viper Studios  

---

## 6️⃣ Fresh Deploy (If No Backup Exists)

If you don’t have a backup yet:

```bash
cd viper-studios/cloud-deployment
./deploy.sh
```

This:

- Pulls latest code  
- Builds containers  
- Starts:
  - Backend  
  - Movie Hub UI  
  - Swarm importer  
  - Metadata engine  

You’ll need to re‑import legal movies via the swarm and rebuild metadata.

---

## 7️⃣ Re-enable Nightly Backups

On the VM:

```bash
crontab -e
```

Add:

```bash
0 3 * * * /home/viper/viper-studios/scripts/backup_external_drive.sh >> /home/viper/viper-backup.log 2>&1
```

---

## 8️⃣ Verify Studio Health

Check containers:

```bash
docker ps
```

Access Movie Hub via Tailscale:

```text
http://viper-cloud.yourname.ts.net:8000
```

Confirm:

- Movies load  
- Metadata appears  
- Sorting works  
- Swarm + metadata scripts run without errors  

---

## 9️⃣ Quick Disaster Checklist

When catastrophe happens:

1. **Recreate VM**  
2. **Install Docker + Git**  
3. **Reconnect Tailscale**  
4. **Clone GitHub repo**  
5. **Restore from backup** (if available)  
6. **Run `deploy.sh`**  
7. **Re-enable cron backups**  
8. **Verify Movie Hub + backend**  

With this, you can rebuild Viper Studios in **minutes**, not days.
