# Use Nginx as the base image
FROM nginx:latest

# Copy HTML and CSS files to Nginx HTML directory
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css
