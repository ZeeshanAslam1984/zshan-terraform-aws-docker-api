#!/bin/sh

# Replace variables in template
envsubst '$LISTEN_PORT $APP_HOST $APP_PORT' < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf

# Start Nginx in foreground
nginx -g 'daemon off;'
