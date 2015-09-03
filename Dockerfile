FROM phusion/baseimage
MAINTAINER Jacob Sanford <jsanford_at_unb.ca>

ENV COMPOSER_PATH=/usr/bin
ENV WEBTREE_ROOT /usr/share/nginx
ENV WEBTREE_WEBROOT $WEBTREE_ROOT/html

# Locate setup
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install nginx and php-fpm packages.
RUN apt-get update && \
  DEBIAN_FRONTEND="noninteractive" apt-get install --yes php5-cli php5-fpm \
  php5-mysql php5-pgsql php5-sqlite php5-curl php5-gd php5-mcrypt php5-intl \
  php5-imap php5-tidy
RUN DEBIAN_FRONTEND="noninteractive" apt-get install --yes nginx
RUN service nginx stop

# Install Composer.
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=${COMPOSER_PATH} --filename=composer

# Add conf files.
ADD conf/nginx/default.conf /etc/nginx/sites-available/default
ADD conf/php5/fpm/php.ini /etc/php5/fpm/php.ini

# Add phusion baseimage inits and services.
CMD ["/sbin/my_init"]
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh

# Clean up.
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
