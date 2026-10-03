# Assignment 1.1 – GitHub to EC2 Deployment using Jenkins Pipeline

## 📌 Objective
Deploy a static website from a GitHub repository to an AWS EC2 Linux VM using a **Jenkins Pipeline**.  
The pipeline automates:
- GitHub checkout
- Apache installation/startup
- Copying website files to `/var/www/html`
- Verifying accessibility via EC2 public IP

---

## 🏗️ Architecture / Flow
GitHub Repository → Jenkins Pipeline → Git Checkout → Jenkins Workspace → Install/Start Apache → Deploy Files → `/var/www/html` → Apache :80 → Browser

---

## ⚙️ Setup Details
- **Source:** GitHub repository  
- **Repository URL:** `https://github.com/Shantanumajan6/vel-app.git`  
- **Branch:** `master`  
- **Jenkins Job Name:** `GitHub-Apache-Pipeline`  
- **Jenkins Type:** Pipeline (Declarative)  
- **Destination:** AWS EC2 Linux VM  
- **Web Server:** Apache HTTP Server (httpd)  
- **Document Root:** `/var/www/html`  
- **HTTP Port:** `80`

---

## 🚀 Jenkinsfile

```groovy
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Shantanumajan6/vel-app.git'
            }
        }

        stage('Install Apache') {
            steps {
                sh '''
                echo "===== Installing Apache ====="
                sudo yum install httpd -y
                '''
            }
        }

        stage('Start Apache') {
            steps {
                sh '''
                echo "===== Starting Apache ====="
                sudo systemctl enable httpd
                sudo systemctl start httpd
                '''
            }
        }

        stage('Deploy Website') {
            steps {
                sh '''
                echo "===== Deploying Website ====="
                sudo cp -r ./* /var/www/html/
                sudo chown -R apache:apache /var/www/html
                sudo chmod -R 755 /var/www/html
                ls -la /var/www/html/
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                sh '''
                echo "===== Apache Status ====="
                sudo systemctl status httpd --no-pager
                echo "===== Testing Website ====="
                curl -I http://localhost
                '''
            }
        }
    }
}
