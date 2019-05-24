FROM nginx:1.13.8-alpine
LABEL maintainer "paul@hutoma.ai"

COPY selfsigned.crt /etc/nginx/ssl/nginx.crt
COPY selfsigned.key /etc/nginx/ssl/nginx.key
COPY reverse_proxy_nginx.conf /etc/nginx/nginx.conf