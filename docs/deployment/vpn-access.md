# ⭐ **Tailscale Private‑Domain Setup Guide for Viper Studios**

This guide shows you how to:

- Install Tailscale on your cloud VM  
- Install Tailscale on your PC  
- Join both devices to your private network  
- Access Viper Studios through your own private domain name  
- Keep everything secure and invisible to the public internet  

---

# 1️⃣ **Install Tailscale on Your Cloud VM**

SSH into your VM:

```bash
ssh viper@YOUR_CLOUD_IP
```

Then install Tailscale:

```bash
curl -fsSL https://tailscale.com/install.sh | sh
```

Start Tailscale:

```bash
sudo tailscale up
```

You’ll get a link in the terminal:

```text
To authenticate, visit:

https://login.tailscale.com/a/XYZ123
```

Open that link on your PC and log in.

Your cloud VM is now part of your private network.

---

# 2️⃣ **Install Tailscale on Your PC**

Download Tailscale:

[https://tailscale.com/download](https://tailscale.com/download)

Install it, sign in with the same account you used for the cloud VM.

Now both machines are in your private network.

---

# 3️⃣ **Find Your Private Domain Name**

Run this on your cloud VM:

```bash
tailscale ip
```

You’ll see something like:

```text
100.120.55.12
fd7a:115c:a1e0::abcd
```

But the real magic is your **MagicDNS name**:

```text
viper-cloud.yourname.ts.net
```

This is your **private domain name**.

Only your devices can access it.

---

# 4️⃣ **Access Viper Studios Privately**

Your Movie Hub UI runs on port **8000**.

Your backend runs on port **8002**.

So you can access them at:

```url
http://viper-cloud.yourname.ts.net:8000
http://viper-cloud.yourname.ts.net:8002
```

This works:

- On your PC  
- On your laptop  
- On your phone  
- On your tablet  
- Anywhere in the world  

As long as the device is logged into Tailscale.

No public exposure.  
No firewall rules.  
No SSH tunnels.  
No reverse proxies.  
No DNS configuration.  
No SSL certificates.  

Just pure private access.

---

# 5️⃣ **Optional: Give Your Cloud VM a Friendly Name**

On the cloud VM:

```bash
sudo tailscale set --hostname viper-cloud
```

Now your domain becomes:

```url
http://viper-cloud.yourname.ts.net:8000
```

Much cleaner.

---

# 6️⃣ **Optional: Enable MagicDNS**

MagicDNS lets you skip the `.ts.net` domain entirely.

Enable it here:

[https://login.tailscale.com/admin/dns](https://login.tailscale.com/admin/dns)

Then you can access Viper Studios at:

```url
http://viper-cloud:8000
```

Just like a local machine — but it’s actually your cloud VM.

---

# 7️⃣ **Optional: Lock Down Public Ports Completely**

Since Tailscale handles all access, you can block everything else:

```bash
sudo ufw deny 8000
sudo ufw deny 8002
sudo ufw deny 22
sudo ufw allow 22/tcp
```

Your VM becomes invisible to the internet.

Only Tailscale can reach it.
