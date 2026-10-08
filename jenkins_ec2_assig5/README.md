# Assignment 5 – Jenkins Webhook / Poll SCM (Freestyle)

This assignment demonstrates automating Jenkins builds when code changes are pushed to GitHub.  
Instead of manually clicking *Build Now*, Jenkins is triggered either by a **GitHub webhook** (instant) or by **Poll SCM** (scheduled checks).

---

## Objective

- Developer pushes a change → GitHub repository  
- GitHub notifies Jenkins (webhook) or Jenkins polls GitHub (SCM)  
- Jenkins checks out the latest code  
- Jenkins installs and starts Apache  
- Jenkins deploys the updated `index.html` to `/var/www/html`

---

## Prerequisites

On the Jenkins EC2 instance:

- Java 21 Amazon Corretto installed
- Jenkins service running (port 8080 or 9090)
- Git installed
- Security group open for:
  - Jenkins port (8080/9090) → required for webhook
  - HTTP port 80 → required to view deployed site

Verify:
```bash
java -version
sudo systemctl status jenkins
git --version
