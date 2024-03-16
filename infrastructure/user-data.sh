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

sudo chkconfig docker on 

sudo chmod 666 /var/run/docker.sock

# Pull the Docker image from Docker Hub and run the Docker container
sudo docker pull mohd1995/testing:latest
sudo docker run -d -p 80:80 --name testing mohd1995/testing:latest

