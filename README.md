# unblibraries/nginx-php [![](https://badge.imagelayers.io/unblibraries/nginx-php:latest.svg)](https://imagelayers.io/?images=unblibraries/nginx-php:latest 'Get your own badge on imagelayers.io')

Docker image : leverages phusion/baseimage to deploy a baseline FastCGI PHP supported Nginx container.

## Usage
```
docker run \
       --rm \
       --name nginx-php \
       -v /local/dir:/usr/share/nginx \
       -p 80:80 \
       unblibraries/nginx-php
```

## License
- unblibraries/nginx-php is licensed under the MIT License:
  - http://opensource.org/licenses/mit-license.html
- Attribution is not required, but much appreciated:
  - `Nginx PHP Docker Image by UNB Libraries`

## Credit
- Original work for this image was based on that of [Chris Fidao](https://github.com/fideloper/docker-nginx-php).c
