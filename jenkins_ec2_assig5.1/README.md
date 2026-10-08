# Assignment 5.1 – Jenkins Pipeline Webhook / Poll SCM

This assignment demonstrates automating Jenkins builds using a **Pipeline job** when code changes are pushed to GitHub.  
Jenkins is triggered either by a **GitHub webhook** (instant) or by **Poll SCM** (scheduled checks).  
The pipeline installs Apache, starts it, and deploys the updated website automatically.

---

## Objective

- Developer pushes a change → GitHub repository  
- GitHub notifies Jenkins (webhook) or Jenkins polls GitHub (SCM)  
- Jenkins pipeline checks out the latest code  
- Apache HTTPD is installed and started  
- The updated `index.html` is deployed to `/var/www/html`

---

## Prerequisites

On the Jenkins EC2 instance:

- Java 21 Amazon Corretto installed
- Jenkins service running (port 8080 or 9090)
- Git and Maven installed
- Security group open for:
  - Jenkins port (8080/9090) → required for webhook
  - HTTP port 80 → required to view deployed site

Verify:
```bash
java -version
sudo systemctl status jenkins
git --version
