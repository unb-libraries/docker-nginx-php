FROM unblibraries/nginx:alpine
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV COMPOSER_PATH /usr/local/bin

RUN apk --update add php-fpm php-json php-zlib php-xml php-phar php-gd php-iconv php-mcrypt curl php-openssl && \
  rm -f /var/cache/apk/* && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
  chmod +x /var/lib/nginx -R

ADD conf/nginx/app.conf /etc/nginx/conf.d/app.conf
ADD conf/php/php.ini /etc/php/php.ini
ADD conf/php/php-fpm.conf /etc/php/php-fpm.conf

ADD scripts /scripts
RUN chmod -R 755 /scripts

CMD ["/scripts/run.sh"]
