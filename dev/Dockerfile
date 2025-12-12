# Stage 1: Base build - responsible for preparing the content
FROM node:18 AS builder

# Install rsync (git no longer needed)
RUN apt-get update && apt-get install -y rsync && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the project files into the container
COPY . .

# Create output directories for Nginx
RUN mkdir -p /app/out /app/out/dev

# If building from main branch, copy everything to /app/out
# Exclude dev_content_temp (no longer needed) and out
RUN rsync -av --exclude 'out/' . /app/out/

# Optional: If you want dev branch content, just copy it from a dev folder in your repo
# For example, if locally you have a 'dev_content' folder
# RUN rsync -av dev_content/ /app/out/dev/

# Stage 2: Web server - using Nginx
FROM nginx:stable-alpine
COPY --from=builder /app/out /usr/share/nginx/html

# Make sure Nginx can read all files
RUN chmod -R 755 /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html


EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
