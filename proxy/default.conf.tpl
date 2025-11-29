server {
    listen 8000;

    # Static files
    location /media/ {
        alias /vol/web/media/;
    }

    location /static/ {
        alias /vol/static/;
    }

    # Proxy to Django app
    location / {
        include /etc/nginx/gunicorn_headers;

        proxy_pass http://api:8000;
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_connect_timeout 5s;
        proxy_read_timeout 30s;

        client_max_body_size 10M;
    }

    # Health check
    location /health/ {
        return 200 'OK';
        add_header Content-Type text/plain;
    }

    # Logging
    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log warn;
}
