# carlesbarreda/certbot

Multiplatform image based on [certbot/certbot](https://hub.docker.com/r/certbot/certbot/) with [Dinahosting DNS Authenticator plugin](https://github.com/rdrgzlng/certbot-dns-dinahosting) by @rdrgzlng for [certbot](https://certbot.eff.org/).


## How to use

1. Create directories and Dinahosting credential account INI file.
```bash
mkdir -p ./certbot/etc/secrets
cat <<EOF > ./certbot/etc/secrets/dinahosting.ini
dns_dinahosting_username = "username"
dns_dinahosting_password = "password"
EOF
```

2. Pull the image.
```bash
docker pull carlesbarreda/certbot:latest
```

3. Registre a Let's Encrypt ACME account.
```bash
docker run --rm \
  --volume "./certbot/etc:/etc/letsencrypt" \
  --volume "./certbot/lib:/var/lib/letsencrypt" \
  --volume "./certbot/log:/var/log/letsencrypt" \
  --cap-drop=all \
  carlesbarreda/certbot:latest register \
    --email "email@example.com" \
    --agree-tos \
    --non-interactive
```

4. Obtain or renew a certificate for your domain in Dinahosting.
```bash
docker run --rm \
  --volume "./certbot/etc:/etc/letsencrypt" \
  --volume "./certbot/lib:/var/lib/letsencrypt" \
  --volume "./certbot/log:/var/log/letsencrypt" \
  --cap-drop=all \
  carlesbarreda/certbot:latest certonly \
    --authenticator dns-dinahosting \
    --dns-dinahosting-credentials /etc/letsencrypt/secrets/dinahosting.ini \
    --dns-dinahosting-propagation-seconds 900 \
    --domains example.com,*.example.com \
    --renew-by-default \
    --non-interactive
```

5. If all goes right, we will find our certificate in _./certbot/etc/live/example.com_


## Notes

- You must own a domain with [Dinahosting](https://dinahosting.com/) for use this plugin.

- You can build your own image with:
```bash
docker build --tag dockeruser/certbot:latest -<<EOF
FROM certbot/certbot:latest

RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install https://github.com/rdrgzlng/certbot-dns-dinahosting/tarball/master

VOLUME ["/etc/letsencrypt"]
VOLUME ["/var/lib/letsencrypt"]
VOLUME ["/var/log/letsencrypt"]
EOF
```

- You can take a look to _buildx-images.ps1_ and _buildx-images.sh_ scripts for multiplatform build. You need the latest version of Docker engine with experimental support to use the buildx command.
