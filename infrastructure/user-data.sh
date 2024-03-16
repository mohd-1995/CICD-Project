#!/bin/bash

# Update the operating system and install Docker
sudo yum update -y
sudo yum install -y docker

# Start the Docker service
sudo systemctl start docker

# Enable the Docker service to start on boot
sudo systemctl enable docker

# Add the ec2-user to the Docker group
sudo usermod -a -G docker ec2-user

# Configure the cron job
(crontab -l 2>/dev/null; echo "*/5 * * * * /home/ec2-user/update_docker.sh") | crontab -

# Create the update_docker.sh script
cat <<'EOF' >/home/ec2-user/update_docker.sh
#!/bin/bash
IMAGE="mohd1995/testing:latest"

# Pull the latest version of the image
docker pull $IMAGE

# Stop the running container
docker stop website-container || true

# Remove the stopped container
docker rm website-container || true

# Run the new container
docker run -d -p 80:80 --name website-container $IMAGE
EOF

# Make the script executable
chmod +x /home/ec2-user/update_docker.sh

# Run the update script imediately to start the container
/home/ec2-user/update_docker.sh
