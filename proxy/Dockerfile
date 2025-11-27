FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="londonappdeveloper.com"

# Copy templates and scripts
COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./gunicorn_headers /etc/nginx/gunicorn_headers
COPY ./run.sh /run.sh

# Environment variables for dynamic configuration
ENV LISTEN_PORT=8000
ENV APP_HOST=127.0.0.1
ENV APP_PORT=8000

# Root user needed for initial setup
USER root

RUN mkdir -p /vol/static /vol/media && \
    chmod 755 /vol && \
    chown -R nginx:nginx /vol && \
    touch /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /run.sh

# Persistent volumes
VOLUME /vol/static
VOLUME /vol/media

# Switch back to unprivileged nginx user
USER nginx

# Start script
CMD ["/run.sh"]
FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="londonappdeveloper.com"

# Copy templates and scripts
COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./gunicorn_headers /etc/nginx/gunicorn_headers
COPY ./run.sh /run.sh

# Environment variables for dynamic configuration
ENV LISTEN_PORT=8000
ENV APP_HOST=127.0.0.1
ENV APP_PORT=8000

# Root user needed for initial setup
USER root

RUN mkdir -p /vol/static /vol/media && \
    chmod 755 /vol && \
    chown -R nginx:nginx /vol && \
    touch /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /run.sh

# Persistent volumes
VOLUME /vol/static
VOLUME /vol/media

# Switch back to unprivileged nginx user
USER nginx

# Start script
CMD ["/run.sh"]
