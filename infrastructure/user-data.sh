#!/bin/bash

# Update the operating system and install Docker
sudo yum update -y
sudo yum install -y docker

# Start the Docker service
sudo systemctl start docker

# Add the ec2-user to the Docker group to run Docker without sudo
sudo usermod -a -G docker ec2-user

# Configure Docker to start on boot
sudo systemctl enable docker

# Pull the Docker image from Docker Hub and run the Docker container
sudo docker pull mohd1995/webhosting:latest
sudo docker run -d -p 80:80 --name webhosting mohd1995/webhosting:latest

# Setup a cron job to check for new Docker image daily and update the container
(crontab -l 2>/dev/null; echo "0 0 * * * /usr/bin/docker pull mohd1995/webhosting:latest && /usr/bin/docker container rm -f webhosting && /usr/bin/docker run -d -p 80:80 --name webhosting mohd1995/webhosting:latest") | crontab -

