#!/bin/bash

# Update
apt update -y

# Install Docker
apt install docker.io -y
systemctl start docker
systemctl enable docker

# Install Trivy
apt install wget apt-transport-https gnupg lsb-release -y
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | tee -a /etc/apt/sources.list.d/trivy.list
apt update -y
apt install trivy -y

# Run SonarQube container
docker run -d --name sonarqube -p 9000:9000 sonarqube
