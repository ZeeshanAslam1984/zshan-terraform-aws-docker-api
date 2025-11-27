server {
    listen ${LISTEN_PORT};

    # Fix for large headers / cookies
    client_header_buffer_size 16k;
    large_client_header_buffers 4 32k;

    location /static/ {
        alias /vol/static/;
    }

    location /media/ {
        alias /vol/media/;
    }

    location / {
        include            /etc/nginx/gunicorn_headers;
        proxy_redirect     off;
        proxy_pass         http://${APP_HOST}:${APP_PORT};
        client_max_body_size 10M;
    }
}
