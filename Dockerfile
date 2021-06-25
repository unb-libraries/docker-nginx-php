FROM ghcr.io/unb-libraries/nginx:1.x
MAINTAINER UNB Libraries <libsupport@unb.ca>

ENV COMPOSER_MEMORY_LIMIT -1
ENV COMPOSER_PATH /usr/local/bin
ENV COMPOSER_EXIT_ON_PATCH_FAILURE 1
ENV PHP_FPM_ERROR_LOG /proc/self/fd/2
ENV PHP_PID_DIR /var/run/php

COPY ./conf /conf
COPY ./scripts /scripts

RUN apk --no-cache add php7 php7-fpm php7-json php7-zlib php7-xml php7-phar php7-iconv php7-mcrypt curl php7-curl php7-openssl php7-gd && \
  mkdir -p ${PHP_PID_DIR}/ && \
  chown ${NGINX_RUN_USER}:${NGINX_RUN_GROUP} ${PHP_PID_DIR}/ && \
  curl -sS https://getcomposer.org/installer | php -- --1 --install-dir=${COMPOSER_PATH} --filename=composer && \
  cp /conf/nginx/app.conf /etc/nginx/conf.d/app.conf && \
  cp /conf/php/app-php.ini /etc/php7/conf.d/zz_app.ini && \
  cp /conf/php/app-php-fpm.conf /etc/php7/php-fpm.d/zz_app.conf && \
  rm -f /etc/php7/php-fpm.d/www.conf && \
  chmod -R 755 /scripts

LABEL ca.unb.lib.generator="nginx" \
  ca.unb.lib.php.version="7.3" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.description="nginx-php is the base nginx/php-fpm image at UNB Libraries." \
  org.label-schema.name="nginx-php" \
  org.label-schema.url="https://github.com/unb-libraries/docker-nginx-php" \
  org.label-schema.vcs-url="https://github.com/unb-libraries/docker-nginx-php" \
  org.label-schema.version=$VERSION \
  org.opencontainers.image.source="https://github.com/unb-libraries/docker-nginx-php"
