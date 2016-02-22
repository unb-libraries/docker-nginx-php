# unblibraries/nginx-php:alpine [![](https://badge.imagelayers.io/unblibraries/nginx-php:alpine.svg)](https://imagelayers.io/?images=unblibraries/nginx-php:alpine 'Get your own badge on imagelayers.io')

Deploy a baseline ```php-fpm``` supported ```nginx``` app container with ```composer``` support.

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
