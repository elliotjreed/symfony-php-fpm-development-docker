FROM elliotjreed/symfony-php-fpm-docker:latest

LABEL Description="PHP FPM Docker image with OPCache, APCu, Intl., PDO MySQL, MBString, and Yaml extensions. Used for development or building Symfony / Laravel applications." Vendor="Elliot J. Reed" Version="1.0"

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug && \
    { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } && \
    apk del .build-deps && \
    rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*
