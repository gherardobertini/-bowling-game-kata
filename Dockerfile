ARG COMPOSER_FLAGS="--no-interaction --no-suggest --no-progress --ansi"

###### base stage ######
FROM php:7.4-apache as base

RUN apt-get update && apt-get install -y \
    default-mysql-client \
    libssl-dev \
    libzip-dev \
    vim \
    && rm -rf /var/lib/apt \
    && docker-php-ext-install mysqli pdo_mysql zip

# Composer LTS 2.2 for PHP 7.1 #
COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

###### dev stage ######
FROM base as dev

ARG COMPOSER_FLAGS
ARG PHP_CS_FIXER_VERSION="v3.1.0"
ARG PHPSTAN_VERSION="1.2.0"
ARG COMPOSER_REQUIRE_CHECKER_VERSION="2.0.0"
# ARG XDEBUG_ENABLER_VERSION="facd52cdc1a09fe7e82d6188bb575ed54ab2bc72"
ARG XDEBUG_VERSION="3.1.0"

# xdebug
RUN pecl install xdebug-$XDEBUG_VERSION \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/php.ini

# www-data
RUN groupadd dev -g 1000
RUN useradd dev -g dev -d /home/dev -m
RUN echo '%dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER dev:dev

# global composer dependencies
# RUN composer global require \
#       friendsofphp/php-cs-fixer:$PHP_CS_FIXER_VERSION \
#       phpstan/phpstan:$PHPSTAN_VERSION \
#       phpstan/phpstan-beberlei-assert \
#       phpstan/phpstan-phpunit \
#       maglnet/composer-require-checker:$COMPOSER_REQUIRE_CHECKER_VERSION

# project composer dependencies
# COPY composer.json ./
# RUN composer install $COMPOSER_FLAGS --no-scripts --no-autoloader

# copy project sources
COPY . ./

# rerun composer to trigger scripts and dump the autoloader
# RUN composer install $COMPOSER_FLAGS

USER root:root
# RUN chown www-data:www-data ./public ./public/log
RUN usermod -a -G www-data dev

###### production stage ######
FROM base

ARG COMPOSER_FLAGS

# project composer dependencies
COPY composer.* ./
RUN composer install $COMPOSER_FLAGS --no-scripts --no-autoloader --no-dev

# copy project sources
COPY . ./
# copy project sources cherry picking only production files
# COPY index.php ./
# COPY src ./src

RUN addgroup -S app && adduser -D -G app -S app && chown app:app .
USER app
ENV HOME=/var/www/html