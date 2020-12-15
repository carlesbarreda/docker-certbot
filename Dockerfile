FROM certbot/certbot:latest

RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install https://github.com/rdrgzlng/certbot-dns-dinahosting/tarball/master

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]