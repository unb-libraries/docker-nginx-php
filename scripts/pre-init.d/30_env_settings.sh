#!/usr/bin/env sh

# Inject deploy env into nginx.
sed -i "s|DEPLOY_ENV|$DEPLOY_ENV|g" /etc/nginx/conf.d/app.conf
