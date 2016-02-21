FROM unblibraries/nginx:alpine
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV COMPOSER_PATH /usr/local/bin
ENV PHP_FPM_ERROR_LOG ${APP_LOG_DIR}/${APP_HOSTNAME}.php.error.log

RUN apk --update add php-fpm php-json php-zlib php-xml php-phar php-gd php-iconv php-mcrypt curl php-curl php-openssl && \
  rm -f /var/cache/apk/* && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer && \
  chmod +x /var/lib/nginx -R

COPY conf/nginx/app.conf /etc/nginx/conf.d/app.conf
COPY conf/php/php.ini /etc/php/php.ini
COPY conf/php/php-fpm.conf /etc/php/php-fpm.conf

COPY scripts /scripts
RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh"]
