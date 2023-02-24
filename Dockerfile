# syntax=docker/dockerfile:1.2
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TGT
#FROM certbot/certbot:latest as builder
#FROM --platform=${TARGETPLATFORM} certbot/certbot:amd64-latest
FROM --platform=${TARGETPLATFORM} certbot/certbot:${TGT[$TARGETARCH]}-latest

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TGT

RUN echo "TARGETPLATFORM: ${TARGETPLATFORM}" \
    && echo "TARGETIMAGE: ${TARGETIMAGE}" \
    && echo "TGT${TARGETARCH}: ${TGT[$TARGETARCH]}"

LABEL maintainer="docker@carlesbarreda.cat"

RUN set -eux; \
    apk add --no-cache --virtual .build-deps git=~2; \
    pip install git+https://github.com/rdrgzlng/certbot-dns-dinahosting.git@master; \
    apk del .build-deps

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
