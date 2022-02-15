FROM ghcr.io/unb-libraries/nginx:2.x
MAINTAINER UNB Libraries <libsupport@unb.ca>

ENV COMPOSER_INSTALL "composer install --prefer-dist --no-interaction --no-progress"
ENV COMPOSER_MEMORY_LIMIT -1
ENV COMPOSER_PATH /usr/local/bin
ENV COMPOSER_EXIT_ON_PATCH_FAILURE 1
ENV PHP_CONFD_DIR /etc/php7/conf.d
ENV PHP_APP_INI_FILE $PHP_CONFD_DIR/zz_app.ini
ENV PHP_FPM_CONFD_DIR /etc/php7/php-fpm.d
ENV PHP_FPM_APP_CONF_FILE $PHP_FPM_CONFD_DIR/zz_app.conf
ENV PHP_FPM_ERROR_LOG /proc/self/fd/2
ENV PHP_PID_DIR /var/run/php

COPY ./build /build

RUN apk --no-cache add \
    php7 \
    php7-curl \
    php7-fpm \
    php7-gd \
    php7-iconv \
    php7-json \
    php7-mcrypt \
    php7-openssl \
    php7-phar \
    php7-xml \
    php7-zlib && \
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
  ca.unb.lib.php.version="7.4" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.description="nginx-php is the base nginx/php-fpm image at UNB Libraries." \
  org.label-schema.name="nginx-php" \
  org.label-schema.url="https://github.com/unb-libraries/docker-nginx-php" \
  org.label-schema.vcs-url="https://github.com/unb-libraries/docker-nginx-php" \
  org.label-schema.version=$VERSION \
  org.opencontainers.image.source="https://github.com/unb-libraries/docker-nginx-php"
