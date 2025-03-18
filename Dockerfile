# syntax=docker/dockerfile:1.2
FROM certbot/certbot:${TARGETARCH}

ARG TARGETARCH

RUN set -eux; \
    apk add --no-cache --virtual .build-deps git=~2; \
    #pip install git+https://github.com/rdrgzlng/certbot-dns-dinahosting.git@master; \
    pip install git+https://github.com/carlesbarreda/certbot-dns-dinahosting.git@api_request; \
    apk del .build-deps

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
