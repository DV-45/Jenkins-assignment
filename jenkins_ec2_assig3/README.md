# LoginWebApp

A simple Java web application built with **Maven** and packaged as a **WAR** file for deployment on **Apache Tomcat**.  
This project demonstrates CI/CD integration using **Jenkins** and deployment on **AWS EC2**.

---

## 📂 Project Structure
- `src/main/webapp` → Web application resources (JSPs, web.xml, etc.)
- `pom.xml` → Maven build configuration
- `Jenkinsfile` → Jenkins pipeline definition
- `target/` → Generated WAR file after build

---

## ⚙️ Prerequisites
- Java 17 (Amazon Corretto recommended)
- Apache Maven 3.8+
- Apache Tomcat 10+ (installed manually in `/opt/tomcat`)
- Jenkins (running on EC2 for CI/CD)

---

## 🚀 Build Instructions
Run the following commands inside the project directory:

```bash
mvn clean package
