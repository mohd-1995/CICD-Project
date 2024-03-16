#!/bin/bash

# Redirect stdout and stderr to a log file for troubleshooting
exec > /var/log/user-data.log 2>&1

# Update the operating system and install Docker
sudo yum update -y
sudo yum install -y docker

# Start the Docker service
sudo systemctl start docker

# Add the ec2-user to the Docker group to run Docker without sudo
# Note: You may need to log out and log back in for this to take effect, but since this is user data, we proceed
sudo usermod -a -G docker ec2-user

# Configure Docker to start on boot
sudo systemctl enable docker

# Wait for Docker service to be fully up and running
until sudo docker info; do
  echo "Waiting for Docker to start..."
  sleep 1
done

# Pull the Docker image from Docker Hub and run the Docker container
sudo docker pull mohd1995/testing:latest
sudo docker run -d -p 80:80 --name testing mohd1995/testing:latest

# Setup a cron job to check for new Docker image every 5 minutes and update the container
(crontab -l 2>/dev/null; echo "*/5 * * * * /usr/bin/docker pull mohd1995/testing:latest && /usr/bin/docker container rm -f testing && /usr/bin/docker run -d -p 80:80 --name testing mohd1995/testing:latest") | crontab -

# Ensure the cron service is running
sudo systemctl enable crond.service
sudo systemctl start crond.service
