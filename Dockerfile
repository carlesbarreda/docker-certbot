# syntax=docker/dockerfile:1.2
ARG TARGETPLATFORM
ARG TARGETARCH
FROM --platform=${TARGETPLATFORM} certbot/certbot:${TARGETARCH}-latest
#FROM --platform=linux/amd64 certbot/certbot:amd64-latest
#FROM --platform=${TARGETPLATFORM} certbot/certbot:amd64-latest
#FROM --platform=${TARGETPLATFORM} certbot/certbot:${TGT[$TARGETARCH]}-latest

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETVARIANT

RUN echo "TARGETPLATFORM: ${TARGETPLATFORM}" \
    && echo "TARGETARCH: ${TARGETARCH}" \
    && echo "TARGETVARIANT: ${TARGETVARIANT}"

LABEL maintainer="docker@carlesbarreda.cat"

RUN set -eux; \
    apk add --no-cache --virtual .build-deps git=~2; \
    pip install git+https://github.com/rdrgzlng/certbot-dns-dinahosting.git@master; \
    apk del .build-deps

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
