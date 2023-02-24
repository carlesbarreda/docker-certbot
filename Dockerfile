# syntax=docker/dockerfile:1.2
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETIMAGE="certbot/certbot"
FROM certbot/certbot:latest as builder

#ARG TARGETPLATFORM
#ARG TARGETARCH
ARG TARGETIMAGE
#ENV TARGETIMAGE="certbot/certbot"

RUN case ${TARGETPLATFORM} in \
	linux/amd64) \
		export TARGETIMAGE="certbot/certbot:amd64-latest" \
		;; \
	linux/arm/v6) \
		export TARGETIMAGE="certbot/certbot:arm32v6-latest" \
		;; \
	linux/arm/v8) \
		export TARGETIMAGE="certbot/certbot:arm64v8-latest" \
		;; \
	esac \
    && echo "TARGETPLATFORM: ${TARGETPLATFORM}" \
    && echo "TARGETIMAGE: ${TARGETIMAGE}"

#FROM --platform=${TARGETPLATFORM} certbot/certbot:${TARGETARCH}${TARGETVARIANT}-latest
#FROM --platform=${TARGETPLATFORM} ${TARGETIMAGE}
FROM --platform=${TARGETPLATFORM} certbot/certbot:amd64-latest

ARG TARGETPLATFORM
ARG TARGETARCH
#ARG TARGETIMAGE

LABEL maintainer="docker@carlesbarreda.cat"

RUN echo "TARGETIMAGE: ${TARGETIMAGE}"

RUN set -eux; \
    apk add --no-cache --virtual .build-deps git=~2; \
    pip install git+https://github.com/rdrgzlng/certbot-dns-dinahosting.git@master; \
    apk del .build-deps

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
