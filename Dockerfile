FROM ghcr.io/unb-libraries/nginx:3.23.x

ENV COMPOSER_INSTALL="composer install --prefer-dist --no-interaction --no-progress"
ENV COMPOSER_MEMORY_LIMIT=-1
ENV COMPOSER_PATH=/usr/local/bin
ENV COMPOSER_EXIT_ON_PATCH_FAILURE=1
ENV PHP_VERSION=84
ENV PHP_VERSION_DOTTED=8.4
ENV PHP_FPM_BIN=/usr/sbin/php-fpm${PHP_VERSION}
ENV PHP_CONFD_DIR=/etc/php${PHP_VERSION}/conf.d
ENV PHP_APP_INI_FILE=$PHP_CONFD_DIR/zz_app.ini
ENV PHP_FPM_CONFD_DIR=/etc/php${PHP_VERSION}/php-fpm.d
ENV PHP_FPM_APP_CONF_FILE=$PHP_FPM_CONFD_DIR/zz_app.conf
ENV PHP_FPM_ERROR_LOG=/proc/self/fd/2
ENV PHP_FPM_SOCK_PATH=/var/run/php/php-fpm${PHP_VERSION}.sock
ENV PHP_PID_DIR=/var/run/php

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
    php${PHP_VERSION}-zlib && \
  mkdir -p "$PHP_PID_DIR/" && \
  chown "$NGINX_RUN_USER":"$NGINX_RUN_GROUP" "$PHP_PID_DIR/" && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir="$COMPOSER_PATH" --filename=composer && \
  $RSYNC_COPY /build/conf/nginx/app.conf "$NGINX_APP_CONF_FILE" && \
  $RSYNC_COPY /build/conf/php/app-php.ini "$PHP_APP_INI_FILE" && \
  $RSYNC_COPY /build/conf/php/app-php-fpm.conf "$PHP_FPM_APP_CONF_FILE" && \
  rm -f $PHP_FPM_CONFD_DIR/www.conf && \
  $RSYNC_COPY /build/scripts/ /scripts/ && \
  chmod -R 755 /scripts

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
