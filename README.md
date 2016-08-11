# unblibraries/nginx-php:alpine [![](https://images.microbadger.com/badges/image/unblibraries/nginx-php:alpine.svg)](http://microbadger.com/images/unblibraries/nginx-php:alpine "Get your own image badge on microbadger.com") [![Build Status](https://travis-ci.org/unb-libraries/docker-nginx-php.svg?branch=alpine)](https://travis-ci.org/unb-libraries/docker-nginx-php)

Deploy a baseline ```php-fpm``` supported ```nginx``` app container with ```composer``` support.

## Repository Tags
Two configurations are available:

|                 Tag                | PHP   | Size                                                                                                                                                                                 | Status                                                                                                                                               |
|:----------------------------------:|-------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| unblibraries/nginx-php:alpine      | 5.6.x | [![](https://images.microbadger.com/badges/image/unblibraries/nginx-php:alpine.svg)](http://microbadger.com/images/unblibraries/nginx-php:alpine "Get your own image badge on microbadger.com")           | [![Build Status](https://travis-ci.org/unb-libraries/docker-nginx-php.svg?branch=alpine)](https://travis-ci.org/unb-libraries/docker-nginx-php)      |
| unblibraries/nginx-php:alpine-php7 | 7.0.x | [![](https://images.microbadger.com/badges/image/unblibraries/nginx-php:alpine-php7.svg)](http://microbadger.com/images/unblibraries/nginx-php:alpine-php7 "Get your own image badge on microbadger.com") | [![Build Status](https://travis-ci.org/unb-libraries/docker-nginx-php.svg?branch=alpine-php7)](https://travis-ci.org/unb-libraries/docker-nginx-php) |

## Usage
```
docker run \
       --rm \
       --name nginx-php \
       -v /local/dir:/app/html \
       -p 80:80 \
       unblibraries/nginx-php:alpine
```

## License
- unblibraries/nginx-php is licensed under the MIT License:
  - http://opensource.org/licenses/mit-license.html
- Attribution is not required, but much appreciated:
  - `Nginx PHP Docker Image by UNB Libraries`
