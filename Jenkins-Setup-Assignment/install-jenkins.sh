```bash
#!/bin/bash

# ============================================================
# Jenkins Installation Shell Script
# ============================================================
#
# Usage:
#   ./install-jenkins.sh <jenkins-version>
#
# Example:
#   ./install-jenkins.sh 2.568.3
#
# ============================================================

set -e

# ============================================================
# Configuration
# ============================================================

JENKINS_VERSION="$1"

BASE_DIR="/mnt"
JENKINS_DIR="${BASE_DIR}/jenkins"
JENKINS_HOME="${JENKINS_DIR}/jenkins_home"

JENKINS_WAR="jenkins.war"
JENKINS_URL="https://get.jenkins.io/war-stable/${JENKINS_VERSION}/jenkins.war"

JENKINS_PORT="8080"


# ============================================================
# Validate Input
# ============================================================

if [ -z "${JENKINS_VERSION}" ]; then

    echo ""
    echo "ERROR: Jenkins version is required."
    echo ""
    echo "Usage:"
    echo "  ./install-jenkins.sh <jenkins-version>"
    echo ""
    echo "Example:"
    echo "  ./install-jenkins.sh 2.568.3"
    echo ""

    exit 1

fi


# ============================================================
# Display Configuration
# ============================================================

echo ""
echo "============================================================"
echo " Jenkins Installation"
echo "============================================================"
echo "Jenkins Version : ${JENKINS_VERSION}"
echo "Jenkins URL     : ${JENKINS_URL}"
echo "Installation Dir: ${JENKINS_DIR}"
echo "Jenkins Home    : ${JENKINS_HOME}"
echo "Jenkins Port    : ${JENKINS_PORT}"
echo "============================================================"
echo ""


# ============================================================
# Check Root User
# ============================================================

if [ "$EUID" -ne 0 ]; then

    echo "ERROR: Please run this script as root."
    echo ""
    echo "Example:"
    echo "  sudo ./install-jenkins.sh 2.568.3"
    echo ""

    exit 1

fi


# ============================================================
# Install Required Packages
# ============================================================

echo "Installing Java and wget..."

yum install -y java-21-amazon-corretto.x86_64 wget


# ============================================================
# Verify Java Installation
# ============================================================

echo ""
echo "Checking Java installation..."

java -version


# ============================================================
# Create Jenkins Directories
# ============================================================

echo ""
echo "Creating Jenkins directories..."

mkdir -p "${JENKINS_DIR}"
mkdir -p "${JENKINS_HOME}"


# ============================================================
# Download Jenkins WAR
# ============================================================

echo ""
echo "Downloading Jenkins WAR ${JENKINS_VERSION}..."

cd "${JENKINS_DIR}"

wget -O "${JENKINS_WAR}" "${JENKINS_URL}"


# ============================================================
# Verify Jenkins WAR
# ============================================================

if [ ! -f "${JENKINS_DIR}/${JENKINS_WAR}" ]; then

    echo ""
    echo "ERROR: Jenkins WAR download failed."
    exit 1

fi


echo ""
echo "Jenkins WAR downloaded successfully."

ls -lh "${JENKINS_DIR}/${JENKINS_WAR}"


# ============================================================
# Set Jenkins Home
# ============================================================

export JENKINS_HOME="${JENKINS_HOME}"

echo ""
echo "JENKINS_HOME=${JENKINS_HOME}"


# ============================================================
# Start Jenkins
# ============================================================

echo ""
echo "Starting Jenkins on port ${JENKINS_PORT}..."

cd "${JENKINS_DIR}"

nohup java -jar "${JENKINS_WAR}" \
    --httpPort="${JENKINS_PORT}" \
    > "${JENKINS_DIR}/jenkins.log" 2>&1 &

JENKINS_PID=$!


# ============================================================
# Wait for Jenkins Startup
# ============================================================

echo ""
echo "Waiting for Jenkins to start..."

sleep 10


# ============================================================
# Check Jenkins Process
# ============================================================

if ps -p "${JENKINS_PID}" > /dev/null 2>&1; then

    echo ""
    echo "============================================================"
    echo " Jenkins Started Successfully"
    echo "============================================================"
    echo "Jenkins Version : ${JENKINS_VERSION}"
    echo "Jenkins PID     : ${JENKINS_PID}"
    echo "Jenkins Home    : ${JENKINS_HOME}"
    echo "Jenkins Log     : ${JENKINS_DIR}/jenkins.log"
    echo "Jenkins URL     : http://<SERVER-IP>:${JENKINS_PORT}"
    echo "============================================================"

else

    echo ""
    echo "ERROR: Jenkins failed to start."
    echo ""
    echo "Check the Jenkins log:"
    echo "  cat ${JENKINS_DIR}/jenkins.log"
    echo ""

    exit 1

fi


# ============================================================
# Initial Admin Password
# ============================================================

echo ""
echo "============================================================"
echo " Jenkins Initial Admin Password"
echo "============================================================"

if [ -f "${JENKINS_HOME}/secrets/initialAdminPassword" ]; then

    echo ""
    cat "${JENKINS_HOME}/secrets/initialAdminPassword"
    echo ""

else

    echo ""
    echo "Password file is not available yet."
    echo ""
    echo "Check later using:"
    echo "cat ${JENKINS_HOME}/secrets/initialAdminPassword"

fi


# ============================================================
# Useful Commands
# ============================================================

echo ""
echo "============================================================"
echo " Useful Commands"
echo "============================================================"

echo ""
echo "View Jenkins logs:"
echo "  tail -f ${JENKINS_DIR}/jenkins.log"

echo ""
echo "Check Jenkins process:"
echo "  ps -ef | grep jenkins"

echo ""
echo "Check Jenkins port:"
echo "  ss -lntp | grep ${JENKINS_PORT}"

echo ""
echo "Jenkins URL:"
echo "  http://<SERVER-IP>:${JENKINS_PORT}"

echo ""
echo "============================================================"
echo " Jenkins installation completed."
echo "============================================================"
```