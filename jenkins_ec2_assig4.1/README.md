\# Assignment 4.1 – Jenkins Pipeline Deployment to EC2



This assignment demonstrates deploying a Java WAR file from Jenkins (running on one EC2 instance) to a \*\*second EC2 instance\*\* running Tomcat, using a Jenkins Pipeline. No Jenkins slave/agent is required.



\---



\## Prerequisites



\- \*\*Jenkins EC2 instance\*\* (Amazon Linux 2023)

\- \*\*Deployment EC2 instance\*\* (Amazon Linux 2023)

\- `.pem` key pair for SSH access

\- Security groups open for:

&#x20; - SSH (22)

&#x20; - Jenkins port (8080 or 9090)

&#x20; - Tomcat port (8080/8081)



\---



\## Jenkins Server Setup



1\. \*\*Install Java\*\*

&#x20;  ```bash

&#x20;  sudo yum install java-21-amazon-corretto.x86\_64 -y

&#x20;  java -version



