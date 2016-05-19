FROM unblibraries/nginx:alpine-edge
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV COMPOSER_PATH /usr/local/bin
ENV PHP_FPM_ERROR_LOG ${APP_LOG_DIR}/${APP_HOSTNAME}.php.error.log

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --update add php7-fpm@testing php7-json@testing php7-zlib@testing php7-xml@testing php7-phar@testing php7-iconv@testing php7-mcrypt@testing curl php7-curl@testing php7-openssl@testing php7-gd@testing && \
  rm -f /var/cache/apk/* && \
  mkdir -p /var/run/php/ && \
  chown ${NGINX_RUN_USER}:${NGINX_RUN_GROUP} /var/run/php/ && \
  ln -s /usr/bin/php7 /usr/bin/php && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer && \
  chmod +x /var/lib/nginx -R

COPY conf/nginx/app.conf /etc/nginx/conf.d/app.conf
COPY conf/php/php.ini /etc/php7/php.ini
COPY conf/php/php-fpm.conf /etc/php7/php-fpm.conf
COPY conf/php/www.conf /etc/php7/php-fpm.d/www.conf

COPY scripts /scripts
RUN chmod -R 755 /scripts
