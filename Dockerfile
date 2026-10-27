# Rebuild Alpine's php82 at the upstream security release until Alpine ships it.
# CVE-2026-109618 / CVE-2026-109619: https://www.php.net/archive/2026.php#2026-10-21-5
# Remove this stage and build/php-apk once v3.22 community has php82 >= 8.2.35.
FROM alpine:3.22 AS php-apk
ENV PACKAGER="UNB Libraries <libsupport@unb.ca>"
RUN apk add alpine-sdk && \
  adduser -D builder && \
  addgroup builder abuild
COPY --chown=builder ./build/php-apk /home/builder/php-apk
# abuild -r installs makedepends through setuid abuild-apk, which fails under
# QEMU for the arm64 build. Install them as root and build with -d instead.
RUN cd /home/builder/php-apk/php82 && \
  . ./APKBUILD && \
  apk add $(for d in $makedepends; do case "$d" in "$pkgname"*) ;; *) echo "$d" ;; esac; done)
USER builder
RUN abuild-keygen -an
USER root
RUN cp /home/builder/.abuild/*.rsa.pub /etc/apk/keys/
USER builder
WORKDIR /home/builder/php-apk/php82
RUN abuild -d

FROM ghcr.io/unb-libraries/nginx:3.22.x

ENV COMPOSER_INSTALL="composer install --prefer-dist --no-interaction --no-progress"
ENV COMPOSER_MEMORY_LIMIT=-1
ENV COMPOSER_PATH=/usr/local/bin
ENV COMPOSER_EXIT_ON_PATCH_FAILURE=1
ENV PHP_VERSION=82
ENV PHP_VERSION_DOTTED=8.2
ENV PHP_FPM_BIN=/usr/sbin/php-fpm${PHP_VERSION}
ENV PHP_CONFD_DIR=/etc/php${PHP_VERSION}/conf.d
ENV PHP_APP_INI_FILE=$PHP_CONFD_DIR/zz_app.ini
ENV PHP_FPM_CONFD_DIR=/etc/php${PHP_VERSION}/php-fpm.d
ENV PHP_FPM_APP_CONF_FILE=$PHP_FPM_CONFD_DIR/zz_app.conf
ENV PHP_FPM_ERROR_LOG=/proc/self/fd/2
ENV PHP_FPM_SOCK_PATH=/var/run/php/php-fpm${PHP_VERSION}.sock
ENV PHP_PID_DIR=/var/run/php

# Serve the rebuilt packages as a local repository so this and all downstream
# php82-* installs (extensions, site ADDITIONAL_OS_PACKAGES) resolve to the same build.
COPY --from=php-apk /home/builder/packages/php-apk /opt/php-apk
COPY --from=php-apk /home/builder/.abuild/*.rsa.pub /etc/apk/keys/
RUN echo "/opt/php-apk" >> /etc/apk/repositories

COPY ./build /build

RUN apk --no-cache add \
    php${PHP_VERSION} \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zlib \
    tini && \
  # php82 is not Alpine 3.22's default PHP, so nothing provides /usr/bin/php.
  ln -sf "/usr/bin/php${PHP_VERSION}" /usr/bin/php && \
  mkdir -p "$PHP_PID_DIR/" && \
  chown "$NGINX_RUN_USER":"$NGINX_RUN_GROUP" "$PHP_PID_DIR/" && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir="$COMPOSER_PATH" --filename=composer && \
  $RSYNC_COPY /build/conf/nginx/app.conf "$NGINX_APP_CONF_FILE" && \
  $RSYNC_COPY /build/conf/php/app-php.ini "$PHP_APP_INI_FILE" && \
  $RSYNC_COPY /build/conf/php/app-php-fpm.conf "$PHP_FPM_APP_CONF_FILE" && \
  rm -f $PHP_FPM_CONFD_DIR/www.conf && \
  $RSYNC_COPY /build/scripts/ /scripts/ && \
  rm -rf /build/php-apk && \
  chmod -R 755 /scripts

# tini as PID 1: reap zombies and (-g) forward signals to the whole process
# group, so SIGQUIT on pod stop drains both nginx and the backgrounded php-fpm.
STOPSIGNAL SIGQUIT
ENTRYPOINT ["/sbin/tini", "-g", "--", "/scripts/run.sh"]

ARG BUILD_DATE
ARG VERSION
LABEL ca.unb.lib.generator="php-fpm" \
  ca.unb.lib.php.version=$PHP_VERSION_DOTTED \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.description="nginx-php is the base nginx/php-fpm image at UNB Libraries." \
  org.label-schema.name="nginx-php" \
  org.label-schema.url="https://github.com/unb-libraries/docker-nginx-php" \
  org.label-schema.vcs-url="https://github.com/unb-libraries/docker-nginx-php" \
  org.label-schema.version=$VERSION \
  org.opencontainers.image.authors="UNB Libraries <libsupport@unb.ca>" \
  org.opencontainers.image.source="https://github.com/unb-libraries/docker-nginx-php"
