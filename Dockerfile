# syntax=docker/dockerfile:1.2
FROM --platform=${TARGETPLATFORM} certbot/certbot:${TARGETARCH}

ARG TARGETPLATFORM
ARG TARGETARCH

LABEL maintainer="docker@carlesbarreda.cat"

#    pip install git+https://github.com/rdrgzlng/certbot-dns-dinahosting.git@master; \
RUN set -eux; \
    apk add --no-cache --virtual .build-deps git=~2; \
    pip install git+https://github.com/carlesbarreda/certbot-dns-dinahosting.git@certbot-v2; \
    apk del .build-deps

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
