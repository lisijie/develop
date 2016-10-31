FROM php:7.0-fpm

MAINTAINER lisijie lsj86@qq.com

RUN docker-php-ext-install pdo_mysql

RUN pecl install redis && docker-php-ext-enable redis

RUN pecl install xdebug && docker-php-ext-enable xdebug

CMD /usr/local/sbin/php-fpm