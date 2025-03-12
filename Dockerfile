FROM elliotjreed/symfony-php-fpm-docker:8.3

ENV XDEBUG_VERSION="3.4.2"

ENV TZ='Europe/London'

LABEL Description="PHP FPM Docker image with OPCache, APCu, Intl., PDO MySQL, MBString, and Yaml extensions, with XDebug. Used for development or building Symfony / Laravel applications." Vendor="Elliot J. Reed" Version="3.0"

USER root

COPY ./php-ini-overrides.ini /usr/local/etc/php/conf.d/99-overrides.ini

RUN apk add --update --no-cache --virtual .build-deps $PHPIZE_DEPS linux-headers && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    pecl clear-cache && \
    docker-php-source delete && \
    { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } && \
    apk del .build-deps && \
    rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*

USER www-data

EXPOSE 9000
EXPOSE 9003
