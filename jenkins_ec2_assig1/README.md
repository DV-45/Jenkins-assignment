# GitHub_EC2_with_Jenkins_and_Apache_assig1

## 📌 Objective
Deploy a static website from a GitHub repository to an AWS EC2 Linux VM using **Jenkins Freestyle Project**.  
Jenkins will:
- Checkout the GitHub repository
- Install & start Apache HTTP Server (if not already running)
- Copy website files to `/var/www/html`
- Verify accessibility via the EC2 public IP

---

## 🏗️ Architecture / Flow
GitHub Repository → Jenkins Freestyle Job → Git Checkout → Jenkins Workspace → Install/Start Apache → Deploy Files → `/var/www/html` → Apache :80 → Browser

---

## ⚙️ Setup Details
- **Source:** GitHub repository  
- **Repository URL:** 
- **Branch:** `master`  
- **Jenkins Job Name:** `GitHub-Apache-Deployment`  
- **Jenkins Type:** Freestyle Project  
- **Destination:** AWS EC2 Linux VM  
- **Web Server:** Apache HTTP Server (httpd)  
- **Document Root:** `/var/www/html`  
- **HTTP Port:** `80`

---

## 🚀 Deployment Steps

### 1. Verify EC2 VM
```bash
ssh -i "key_pair.pem" ec2-user@<EC2-Public-IP>
