# Assignment 3 – Multi-Version Website Deployment using Jenkins Pipeline

## 📌 Objective
Automate deployment of three independent website versions using a single Jenkins Pipeline job with multiple stages.  
This replaces the Freestyle jobs from Assignment 2 with a declarative pipeline defined in a `Jenkinsfile`.

---

## 🔹 Deployment Architecture

| Source File             | Pipeline Stage           | Apache Target Directory |
|--------------------------|--------------------------|--------------------------|
| repo1/index.html         | Q1 Release               | /var/www/html/R1/        |
| repo2/index.html         | Q4.2 Patch               | /var/www/html/R2/        |
| repo3/index.html         | Q3.3 Bug Fix             | /var/www/html/R3/        |

Final URLs:
- `http://<EC2-IP>/R1/index.html`
- `http://<EC2-IP>/R2/index.html`
- `http://<EC2-IP>/R3/index.html`

---

## 🔹 Jenkinsfile

```groovy
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/DV-45/Jenkins-assignment.git'
            }
        }

        stage('Q1 Release') {
            steps {
                sh '''
                mkdir -p /var/www/html/R1
                cp -r jenkins_ec2_assig2/repo1/* /var/www/html/R1/
                ls -la /var/www/html/R1
                '''
            }
        }

        stage('Q4.2 Patch') {
            steps {
                sh '''
                mkdir -p /var/www/html/R2
                cp -r jenkins_ec2_assig2/repo2/* /var/www/html/R2/
                ls -la /var/www/html/R2
                '''
            }
        }

        stage('Q3.3 Bug Fix') {
            steps {
                sh '''
                mkdir -p /var/www/html/R3
                cp -r jenkins_ec2_assig2/repo3/* /var/www/html/R3/
                ls -la /var/www/html/R3
                '''
            }
        }
    }
}
