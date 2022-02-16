# unb-libraries/docker-nginx-php  [![](https://github.com/unb-libraries/docker-nginx-php/workflows/build-test-deploy/badge.svg?branch=2.x)](https://github.com/unb-libraries/docker-nginx-php/actions?query=workflow%3Abuild-test-deploy) [![GitHub license](https://img.shields.io/github/license/unb-libraries/docker-nginx-php)](https://github.com/unb-libraries/lib.unb.ca/blob/prod/LICENSE) ![GitHub repo size](https://img.shields.io/github/repo-size/unb-libraries/docker-nginx-php?label=lean%20repo%20size)
A lightweight extensible nginx-php docker image, suitable for development or production deployments.

## Usage
This image offers relatively no useful functionality on its own, but serves well as the base of other images. For an example how we extend this image, please see [unb-libraries/docker-nginx-drupal](https://github.com/unb-libraries/docker-drupal).

## Branches/Tags
The only currently maintained tag is **ghcr.io/unb-libraries/nginx-php:2.x**. The 1.x tag exists for legacy purposes only.

|                  Tag                   | Nginx | Alpine | PHP | Composer |
|:--------------------------------------:|-------|--------|-----|----------|
|  ghcr.io/unb-libraries/nginx-php:2.x   | 1.20  | 1.15   | 7.4 | 2.x      |
|  ghcr.io/unb-libraries/nginx-php:1.x   | 1.18  | 1.13   | 7.3 | 1.x      |

## Author / Contributors
This application was created at [![UNB Libraries](https://github.com/unb-libraries/assets/raw/master/unblibbadge.png "UNB Libraries")](https://lib.unb.ca) by the following humans:

<a href="https://github.com/JacobSanford"><img src="https://avatars.githubusercontent.com/u/244894?v=3" title="Jacob Sanford" width="128" height="128"></a>

## License
- As part of our 'open' ethos, UNB Libraries licenses its applications and workflows to be freely available to all whenever possible.
- Consequently, the contents of this repository [unb-libraries/docker-nginx-php] are licensed under the [MIT License](http://opensource.org/licenses/mit-license.html). This license explicitly excludes:
  - Any website content, which remains the exclusive property of its author(s).
  - The UNB logo and any of the associated suite of visual identity assets, which remains the exclusive property of the University of New Brunswick.
