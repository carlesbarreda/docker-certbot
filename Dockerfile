# syntax=docker/dockerfile:1.2
ARG ARCH
FROM --platform=${TARGETPLATFORM} certbot/certbot:${ARCH}-latest

ARG TARGETPLATFORM

LABEL maintainer="docker@carlesbarreda.cat"

RUN set -eux; \
    apk add --no-cache --virtual .build-deps git=~2; \
    pip install git+https://github.com/rdrgzlng/certbot-dns-dinahosting.git@master; \
    apk del .build-deps

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]