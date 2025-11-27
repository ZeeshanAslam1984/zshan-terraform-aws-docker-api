FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="londonappdeveloper.com"

# Copy config templates and scripts
COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./gunicorn_headers /etc/nginx/gunicorn_headers
COPY ./run.sh /run.sh

# Environment variables
ENV LISTEN_PORT=8000
ENV APP_HOST=app
ENV APP_PORT=8001  

USER root

# Create directories for static/media and set permissions
RUN mkdir -p /vol/static /vol/media && \
    chmod 755 /vol && \
    chown -R nginx:nginx /vol && \
    # Prepare Nginx default.conf
    envsubst '${LISTEN_PORT} ${APP_HOST} ${APP_PORT}' < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /run.sh

# Volumes for persistence
VOLUME /vol/static
VOLUME /vol/media

USER nginx

# Start Nginx using your custom run.sh
CMD ["/run.sh"]
