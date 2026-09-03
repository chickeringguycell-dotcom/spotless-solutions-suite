# ⭐ **Viper Studios Cloud Setup Guide (Private, Always‑On)**

This is the exact sequence you will follow to deploy Viper Studios on a cloud VM such as DigitalOcean, Linode, AWS, or Azure.

---

# 1️⃣ **Create Your Cloud VM**

Choose a provider:

- DigitalOcean Droplet  
- Linode/Akamai VM  
- AWS EC2  
- Azure VM  

Recommended specs:

- **Ubuntu 22.04 LTS**
- **2 GB RAM** minimum  
- **50 GB SSD** minimum  
- **1 vCPU** minimum  

Once the VM is created, you’ll receive:

- Public IP  
- SSH login credentials  

---

# 2️⃣ **Log Into Your Cloud VM**

From your PC:

```bash
ssh viper@YOUR_CLOUD_IP
```

If your provider uses root:

```bash
ssh root@YOUR_CLOUD_IP
```

---

# 3️⃣ **Install Docker + Docker Compose**

Run these commands on the VM:

```bash
sudo apt update
sudo apt install docker.io docker-compose -y
sudo systemctl enable docker
sudo systemctl start docker
```

Verify:

```bash
docker --version
docker-compose --version
```

---

# 4️⃣ **Clone Your GitHub Repository**

Once your repo is pushed to GitHub, clone it onto the VM:

```bash
git clone https://github.com/YOUR-USERNAME/viper-studios.git
```

Your cloud directory will look like:

```text
/home/viper/viper-studios/
    cloud-deployment/
        docker-compose.yml
        deploy.sh
    artifacts/
        viperstream-cloud/
        landing-page/
```

This matches your workspace exactly.

---

# 5️⃣ **Prepare Your Deployment Script**

Navigate into the deployment folder:

```bash
cd viper-studios/cloud-deployment
```

Make the script executable:

```bash
chmod +x deploy.sh
```

---

# 6️⃣ **Run Your First Deployment**

This command builds and launches the entire Viper Studios stack:

```bash
./deploy.sh
```

This will:

- Pull latest GitHub code  
- Build all Docker containers  
- Start Viper Studios  
- Create persistent volumes (`media`, `config`)  
- Launch:
  - Viper Backend  
  - Movie Hub UI  
  - Swarm importer  
  - Metadata engine  

Your studio is now **alive in the cloud**.

---

# 7️⃣ **Keep Viper Studios Private**

You have two secure access options:

---

## **Option A — VPN (Best)**

Install **Tailscale** on:

- Your PC  
- Your cloud VM  

Then access Movie Hub privately:

```url
http://viper-cloud:8000
```

Only devices in your Tailscale network can reach it.

---

## **Option B — SSH Tunnel (Simple)**

Block all public ports:

```bash
sudo ufw deny 8000
sudo ufw deny 8002
```

Then create a tunnel:

```bash
ssh -L 8000:localhost:8000 viper@YOUR_CLOUD_IP
```

Open Movie Hub:

```url
http://localhost:8000
```

Only you can access it.

---

# 8️⃣ **GitHub → Cloud Sync Workflow**

Your workflow becomes:

### On your PC:
```bash
git add .
git commit -m "update"
git push
```

### On your cloud VM:
```bash
cd viper-studios/cloud-deployment
./deploy.sh
```

This updates your cloud studio instantly.

Later, we can automate this with GitHub Actions.

---

# 9️⃣ **External Drive Backup**

On the cloud VM:

```bash
tar -czf viper_backup_$(date +%Y%m%d).tar.gz /var/lib/docker/volumes/viper-studios_media/_data /var/lib/docker/volumes/viper-studios_config/_data
```

Download to your PC:

```bash
scp viper@YOUR_CLOUD_IP:/home/viper/viper_backup_20260824.tar.gz .
```

Copy to your external drive.
