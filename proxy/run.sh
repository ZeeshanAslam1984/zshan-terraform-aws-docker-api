#!/bin/sh
set -e

# Replace only the required env variables in the template
envsubst '$APP_HOST $APP_PORT $LISTEN_PORT' < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf

# Start Nginx in foreground
nginx -g "daemon off;"
