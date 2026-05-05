#!/bin/bash

# Exit if any command fails
set -e

echo "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "☕ Installing OpenJDK (Java)..."
sudo apt install -y openjdk-21-jdk

echo "🔑 Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "📦 Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔁 Updating package list..."
sudo apt update

echo "📥 Installing Jenkins..."
sudo apt install -y jenkins

echo "🚀 Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "🧱 (Optional) Configuring UFW firewall for Jenkins (port 8080)..."
sudo ufw allow 8080
sudo ufw reload

echo "✅ Jenkins installation completed."
echo "🌐 Access Jenkins via: http://<your-server-ip>:8080"

echo "🔐 Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
