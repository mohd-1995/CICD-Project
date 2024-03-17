#!/bin/bash

# Update the operating system and install Docker
sudo yum update -y
sudo yum install -y docker

# Install cronie (provides cron and crontab)
sudo yum install -y cronie


# Start the Docker service
sudo systemctl start docker

# Ensure the Docker service starts on boot
sudo systemctl enable docker

# Add the ec2-user to the Docker group
sudo usermod -a -G docker ec2-user

# Adjust permissions on the Docker socket
sudo chmod 666 /var/run/docker.sock

# Wait for the Docker daemon to be active
while ! docker info > /dev/null 2>&1; do
   sleep 1
done

# Create the update script in /tmp
cat <<'EOF' > /tmp/update_docker_image.sh
#!/bin/bash
# Stop the currently running container
docker stop my-container

# Remove the stopped container
docker rm my-container

# Pull the latest Docker image
docker pull mohd1995/testing:latest

# Run the Docker container with the latest image
docker run -d --name my-container -p 80:80 mohd1995/testing:latest
EOF

# Ensure the script is executable
sudo chmod +x /tmp/update_docker_image.sh

# Ensure the cron service starts on boot and is running
sudo systemctl enable crond
sudo systemctl start crond

# Add a cron job to run the script every 5 minutes
( crontab -l 2>/dev/null; echo "*/3 * * * * /bin/bash /tmp/update_docker_image.sh >> /var/log/update_docker_image.log 2>&1" ) | crontab -

# Start the initial Docker container manually
/tmp/update_docker_image.sh
