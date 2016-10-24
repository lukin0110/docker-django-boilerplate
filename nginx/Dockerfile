#
# Sample docker Nginx image
# More info: https://hub.docker.com/_/nginx/
#
FROM nginx:1.11.5-alpine

# Expose Nginx HTTP service
EXPOSE 80 443

RUN mkdir /logs
COPY nginx.conf /etc/nginx/
COPY hello.conf /etc/nginx/sites-enabled/
