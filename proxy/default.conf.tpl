server {
    listen ${LISTEN_PORT};

    # UPDATED: Matches STATIC_URL = '/static/' in settings.py
    location /static/ {
        alias /vol/web/static/;
    }

    # UPDATED: Matches MEDIA_URL = '/media/' in settings.py
    location /media/ {
        alias /vol/web/media/;
    }

    location / {
        include /etc/nginx/gunicorn_headers;

        proxy_pass http://${APP_HOST}:${APP_PORT};
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

    location /health/ {
        return 200 'OK';
        add_header Content-Type text/plain;
    }

    access_log /var/log/nginx/access.log;
    error_log  /var/log/nginx/error.log warn;
}d
