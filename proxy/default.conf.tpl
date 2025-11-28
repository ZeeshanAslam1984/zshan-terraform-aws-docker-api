server {
    listen ${LISTEN_PORT};

    # Static files
    location /static/ {
        alias /vol/static/;
    }

    location /static/web/media/ {
        alias /vol/web/media/;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;  # django app
    }

    # Proxy to Django app
    location / {
        include /etc/nginx/gunicorn_headers;

        proxy_pass http://${APP_HOST}:${APP_PORT};
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Optional: retries if backend is temporarily down
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_connect_timeout 5s;
        proxy_read_timeout 30s;

        client_max_body_size 10M;
    }

    # Optional: simple health check for ALB
    location /health/ {
        return 200 'OK';
        add_header Content-Type text/plain;
    }
    
    # Optional: logging
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log warn;
}
