# Assignment 2 – Multi-Version Website Deployment with Jenkins & EC2

## 📌 Objective
Deploy three independent versions of a website from a single GitHub repository to one EC2 instance using **Jenkins Freestyle jobs**.  
Each release is deployed into a separate Apache directory and accessible via unique URLs.

---

## 🔹 Deployment Architecture

| Source File             | Jenkins Job              | Apache Target Directory |
|--------------------------|--------------------------|--------------------------|
| repo1/index.html         | Assignment2-Q1-Release   | /var/www/html/R1/        |
| repo2/index.html         | Assignment2-Q4.2-Patch   | /var/www/html/R2/        |
| repo3/index.html         | Assignment2-Q3.3-Bug-Fix | /var/www/html/R3/        |

Final URLs:
- `http://<EC2-IP>/R1/index.html`
- `http://<EC2-IP>/R2/index.html`
- `http://<EC2-IP>/R3/index.html`

---

## 🔹 Jenkins Job Configuration

### 1. Assignment2-Q1-Release
**SCM:**
- Git Repository: `https://github.com/DV-45/Jenkins-assignment.git`
- Branch: `main`

**Build Step (Execute Shell):**
```bash
mkdir -p /var/www/html/R1
cp -r jenkins_ec2_assig2/repo1/* /var/www/html/R1/
ls -la /var/www/html/R1
