#!/bin/sh

# Update Installed Packages
sudo apt-get update && sudo apt-get -y upgrade

# Install Some Necessary Packages
sudo apt-get -y install default-jdk unzip make tidy

# Install and Setup Docker
sudo apt-get -y remove docker docker-engine docker.io containerd runc

sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io

sudo chmod 666 /var/run/docker.sock

# Install Jenkins and start it
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'

sudo apt-get update

sudo apt-get -y install jenkins

sudo systemctl start jenkins

systemctl status jenkins

sudo systemctl enable jenkins

# Install Azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin

# Install Aks

release=v0.1.0 ## choose the available release version
curl --silent --location "https://github.com/adfolks/aksctl/releases/download/$release/aksctl-$(uname -s)-amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/aksctl /usr/local/bin

# Install hadolint
sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64 && sudo chmod +x /bin/hadolint
