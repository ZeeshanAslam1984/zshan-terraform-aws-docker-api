server {
    listen ${LISTEN_PORT};

    # Static files
    location /static/ {
        alias /vol/static/;
    }

    location /media/ {
        alias /vol/media/;
    }

    # Proxy to Django app
    location / {
        include /etc/nginx/gunicorn_headers;
        proxy_redirect off;
        proxy_pass http://${APP_HOST}:${APP_PORT};
        client_max_body_size 10M;
    }

    # Optional: simple health check for ALB
    location /health/ {
        return 200 'OK';
        add_header Content-Type text/plain;
    }
}
