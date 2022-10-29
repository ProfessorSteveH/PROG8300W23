FROM owncloud/base:20.04-amd64@sha256:4575ef876c07d6db5bc8eb3780d3572c7d376d2c3f21c53a7797d42a6693e86d


# Install all OS dependencies for notebook server that starts but lacks all
# features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
    locales \
    #netcat \
    #vim \
    nginx && \
    apt-get  clean && rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen


LABEL maintainer="ownCloud GmbH <devops@owncloud.com>" \
  org.opencontainers.image.authors="ownCloud DevOps <devops@owncloud.com>" \
  org.opencontainers.image.vendor="ownCloud GmbH" \
  org.opencontainers.image.title="ownCloud Server" \
  org.opencontainers.image.description="ownCloud - Secure Collaboration Platform" \
  org.opencontainers.image.url="https://hub.docker.com/r/owncloud/server" \
  org.opencontainers.image.source="https://github.com/owncloud-docker/server" \
  org.opencontainers.image.documentation="https://github.com/owncloud-docker/server"

VOLUME ["/mnt/data"]
EXPOSE 80

RUN wget https://download.owncloud.com/server/stable/owncloud-complete-latest.tar.bz2 -O /var/www/owncloud.tar.bz2
#COPY owncloud.tar.bz2 /var/www/
RUN bunzip2 /var/www/owncloud.tar.bz2
RUN tar xf /var/www/owncloud.tar -C /var/www

#COPY default /etc/nginx/sites-enabled/default

#COPY 90-nginx.sh /etc/entrypoint.d/90-nginx.sh
#RUN chmod 755 /etc/entrypoint.d/90-nginx.sh 

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/owncloud", "server"]

#ADD overlay /
WORKDIR /var/www/owncloud

ENV OWNCLOUD_DOMAIN=localhost:80
# ENV OWNCLOUD_TRUSTED_DOMAINS=localhost,172.16.10.167,172.17.0.2
ENV ADMIN_USERNAME=admin
ENV ADMIN_PASSWORD=p@ssw0rd
ENV HTTP_PORT=80


RUN find /var/www/owncloud \( \! -user www-data -o \! -group root \) -print0 | xargs -r -0 chown www-data:root && \
  chmod g+w /var/www/owncloud /var/www/owncloud/.htaccess
