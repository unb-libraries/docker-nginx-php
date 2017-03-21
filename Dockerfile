FROM unblibraries/nginx:alpine-edge
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

LABEL ca.unb.lib.php="7.1"
LABEL vcs-ref="alpine-php7"
LABEL vcs-url="https://github.com/unb-libraries/docker-nginx-php"

ENV COMPOSER_PATH /usr/local/bin
ENV PHP_FPM_ERROR_LOG /proc/self/fd/2
ENV PHP_PID_DIR /var/run/php

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk --update add php7.1@testing php7.1-fpm@testing php7.1-json@testing php7.1-zlib@testing php7.1-xml@testing php7.1-phar@testing php7.1-iconv@testing php7.1-mcrypt@testing curl php7.1-curl@testing php7.1-openssl@testing php7.1-gd@testing && \
  rm -f /var/cache/apk/* && \
  mkdir -p ${PHP_PID_DIR}/ && \
  ln -s /etc/php7.1 /etc/php7 && \
  ln -s /usr/sbin/php-fpm7.1 /usr/sbin/php-fpm7 && \
  chown ${NGINX_RUN_USER}:${NGINX_RUN_GROUP} ${PHP_PID_DIR}/ && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer

COPY conf/nginx/app.conf /etc/nginx/conf.d/app.conf
COPY conf/php/app-php.ini /etc/php7/conf.d/zz_app.ini
COPY conf/php/app-php-fpm.conf /etc/php7/php-fpm.d/zz_app.conf

COPY scripts /scripts
RUN chmod -R 755 /scripts
