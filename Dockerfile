ARG ARCH
ARG BRANCH
FROM --platform=${TARGETPLATFORM} certbot/certbot:${ARCH}-${BRANCH}

ARG TARGETPLATFORM

LABEL maintainer="docker@carlesbarreda.cat"

RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install https://github.com/rdrgzlng/certbot-dns-dinahosting/tarball/master

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
