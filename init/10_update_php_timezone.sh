#!/usr/bin/env bash

# Set timezone to UTC
sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/fpm/php.ini
sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/cli/php.ini
