#!/bin/sh

# Replace environment variables in the NGINX template
envsubst '$LISTEN_PORT $APP_HOST $APP_PORT' < /etc/nginx/conf.d/default.conf.tpl > /etc/nginx/conf.d/default.conf

# Start NGINX in foreground
exec nginx -g 'daemon off;'
