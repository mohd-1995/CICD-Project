# Use the Nginx image from Docker Hub
FROM nginx:alpine

# Copy the static content (HTML and CSS files) into the Nginx image
COPY index.html /usr/share/nginx/html/
COPY index.css /usr/share/nginx/html/
# Corrected the path for the image directory
COPY images/me.jpg /usr/share/nginx/html/images/

# Expose port 80
EXPOSE 80

# Start Nginx when the container has provisioned
CMD ["nginx", "-g", "daemon off;"]
