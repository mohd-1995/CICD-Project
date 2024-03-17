#!/bin/bash

# Update the operating system and install Docker
yum update -y
yum install -y docker

# Start the Docker service
systemctl start docker

# Ensure the Docker service starts on boot
systemctl enable docker

# Add the ec2-user to the Docker group
usermod -a -G docker ec2-user

# Adjust permissions on the Docker socket
chmod 666 /var/run/docker.sock

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
chmod +x /tmp/update_docker_image.sh

# Add a cron job to run the script every 5 minutes
( crontab -l 2>/dev/null; echo "*/5 * * * * /bin/bash /tmp/update_docker_image.sh >> /var/log/update_docker_image.log 2>&1" ) | crontab -

# Start the initial Docker container manually
/tmp/update_docker_image.sh
