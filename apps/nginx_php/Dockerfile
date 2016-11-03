FROM nginx

MAINTAINER lisijie lsj86@qq.com

############# 安装PHP 5.6 #############

# PHP版本
ENV PHP_VERSION 5.6.27

# PHP源码下载地址
ENV PHP_URL="https://secure.php.net/get/php-${PHP_VERSION}.tar.xz/from/this/mirror"

# php配置文件路径
ENV PHP_INI_DIR /usr/local/etc
RUN mkdir -p $PHP_INI_DIR/conf.d

# 下载PHP并解压源码
RUN apt-get update && apt-get install -y --no-install-recommends wget xz-utils; \
	mkdir -p /usr/src/php; \
	cd /usr/src; \
	wget -O php.tar.xz "$PHP_URL"; \
	tar -Jxf /usr/src/php.tar.xz -C /usr/src/php --strip-components=1; \
	rm -f php.tar.xz; \
	rm -r /var/lib/apt/lists/*; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false wget xz-utils

# 编译安装PHP, 并安装redis,xdebug扩展
ENV PHPIZE_DEPS \
	autoconf \
	file \
	g++ \
	gcc \
	libc-dev \
	make \
	pkg-config \
	re2c \
	ca-certificates \
	curl \
	libsqlite3-0

RUN apt-get update && apt-get install -y \
		$PHPIZE_DEPS \
		libedit2 \
		libxml2 \
		libcurl4-openssl-dev \
		libedit-dev \
		libsqlite3-dev \
		libssl-dev \
		libxml2-dev \
		mcrypt \
		libmcrypt-dev \
		libjpeg-dev \
		libpng-dev \
		libfreetype6-dev \
	--no-install-recommends \
	&& rm -r /var/lib/apt/lists/* \
	&& cd /usr/src/php \
	&& ./configure \
		--with-config-file-path="$PHP_INI_DIR" \
		--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
		--disable-cgi \
		--enable-mbstring \
		--enable-mysqlnd \
		--with-curl \
		--with-libedit \
		--with-openssl \
		--with-zlib \
		--with-mcrypt \
		--with-iconv \
		--enable-fpm \
		--with-mysql=mysqlnd \
		--with-mysqli=mysqlnd \
		--with-pdo-mysql=mysqlnd \
		--enable-sockets \
		--enable-zip \
		--enable-opcache \
		--with-openssl \
		--enable-pcntl \
		--with-gd \
		--with-fpm-user=www-data \
		--with-fpm-group=www-data \
	&& make \
	&& make install \
	&& make clean \
	&& pecl install redis-2.2.8 \
	&& pecl install xdebug \
	&& echo 'extension=redis.so' >  $PHP_INI_DIR/conf.d/redis.ini \
	&& rm -rf /tmp/pear \
	&& rm -rf /usr/src/php \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $PHPIZE_DEPS

# 创建数据目录
RUN mkdir -p /data/logs /data/htdocs; \
	echo '<?php phpinfo();' > /data/htdocs/index.php

############# 复制配置文件 #############

COPY nginx.conf /etc/nginx/nginx.conf
COPY fastcgi.conf /etc/nginx/fastcgi.conf
COPY php-fpm.conf $PHP_INI_DIR/php-fpm.conf
COPY php.ini $PHP_INI_DIR/php.ini

############# 安装supervisor #############	

#RUN apt-get update && apt-get install -y --no-install-recommends supervisor \
#	&& rm -r /var/lib/apt/lists/*
#
#COPY supervisord.conf /etc/supervisor/supervisord.conf

############# 其他配置&启动命令 #############

# 工作目录
WORKDIR /data/htdocs

# 导出端口
EXPOSE 80

# 启动命令
COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh
CMD ["startup.sh"]