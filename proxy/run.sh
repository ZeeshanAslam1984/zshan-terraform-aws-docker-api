#!/bin/sh

# Wait for the Django app to start on localhost:8000
echo "Waiting for Django app to start..."
while ! nc -z 127.0.0.1 8000; do
  sleep 1
done
echo "Django app is up, starting Nginx..."

# Start Nginx in foreground
nginx -g 'daemon off;'
