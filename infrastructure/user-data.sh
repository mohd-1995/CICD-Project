#!/bin/bash

# Update the operating system and install Docker
sudo yum update -y
sudo yum install -y docker

# Start the Docker service
sudo systemctl start docker

# Wait for the Docker daemon to be active
while ! docker info > /dev/null 2>&1; do
   sleep 1
done

# Add the ec2-user to the Docker group
sudo usermod -a -G docker ec2-user

# Configure Docker to start on boot
sudo systemctl enable docker

# Adjust permissions on the Docker socket (consider more secure options)
# Be cautious when using chmod 666; this can have security implications
# A better approach is to add the user to the "docker" group
 sudo chmod 666 /var/run/docker.sock

# Stop all running containers (if any)
sudo docker stop $(sudo docker ps -q)

# Remove all stopped containers (if any)
sudo docker rm $(sudo docker ps -a -q)

# Remove the existing Docker image (if it exists)
sudo docker rmi mohd1995/testing

# Pull the Docker image from Docker Hub
sudo docker pull mohd1995/testing

# Run the Docker container with the latest image
sudo docker run -d -p 80:80 mohd1995/testing:latest  