FROM certbot/certbot:amd64-latest

LABEL maintainer="docker@carlesbarreda.cat"

RUN apk add --no-cache git=2.26.3-r0 \
    && pip install git+https://github.com/rdrgzlng/certbot-dns-dinahosting.git@master

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
