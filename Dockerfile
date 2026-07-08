# Use the lightweight stable Nginx image
FROM nginx:alpine

# 1. Copy our custom Nginx routing configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 2. Copy master branch files to the root of the web server
COPY ./master-site/ /usr/share/nginx/html/

# 3. Create the 'dev' subdirectory inside the server root
RUN mkdir -p /usr/share/nginx/html/dev

# 4. Copy dev branch files into that subdirectory
COPY ./dev-site/ /usr/share/nginx/html/dev/

# Expose port 80 to access the site
EXPOSE 80