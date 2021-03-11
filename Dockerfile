FROM certbot/certbot:amd64-latest

LABEL maintainer="docker@carlesbarreda.cat"

RUN pip install https://github.com/rdrgzlng/certbot-dns-dinahosting/tarball/master  --user --disable-pip-version-check

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
