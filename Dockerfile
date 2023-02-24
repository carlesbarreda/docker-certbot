# syntax=docker/dockerfile:1.2
ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETIMAGE="certbot/certbot"
FROM certbot/certbot:latest as builder

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
	esac

#FROM --platform=${TARGETPLATFORM} certbot/certbot:${TARGETARCH}${TARGETVARIANT}-latest
FROM --platform=${TARGETPLATFORM} ${TARGETIMAGE}

LABEL maintainer="docker@carlesbarreda.cat"

RUN set -eux; \
    apk add --no-cache --virtual .build-deps git=~2; \
    pip install git+https://github.com/rdrgzlng/certbot-dns-dinahosting.git@master; \
    apk del .build-deps

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
