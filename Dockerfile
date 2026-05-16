# Stage 1: Base build - responsible for preparing the content
FROM node:18 AS builder

# Install rsync and git
RUN apt-get update && apt-get install -y rsync git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy local project into /app
COPY . .

# Temp dir for dev branch
RUN mkdir /app/dev_content_temp

# Clone repo into temp and checkout dev branch
RUN git clone . /app/dev_content_temp && cd /app/dev_content_temp && git checkout dev

# Output folder for Nginx
RUN mkdir -p /app/out /app/out/dev

# Copy main branch content
RUN rsync -av --exclude 'dev_content_temp/' . /app/out/

# Copy dev branch content into /dev folder
RUN rsync -av /app/dev_content_temp/ /app/out/dev/

# Stage 2: Nginx web server
FROM nginx:stable-alpine

# Copy built site from builder
COPY --from=builder /app/out /usr/share/nginx/html

# Fix permissions BEFORE CMD
RUN chmod -R 755 /usr/share/nginx/html && \
    chown -R nginx:nginx /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
