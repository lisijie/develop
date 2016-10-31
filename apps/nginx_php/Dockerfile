FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY fastcgi.conf /etc/nginx/fastcgi.conf

############# 安装PHP 5.6 ####################

# PHP版本
ENV PHP_VERSION 5.6.27

# PHP源码下载地址
ENV PHP_URL="https://secure.php.net/get/php-${PHP_VERSION}.tar.xz/from/this/mirror"

# php.ini路径
ENV PHP_INI_DIR /usr/local/etc/php

# 安装依赖库
RUN apt-get update && apt-get install -y \
		wget \
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
		libedit2 \
		libsqlite3-0 \
		libxml2 \
		xz-utils \
		libcurl4-openssl-dev \
		libedit-dev \
		libsqlite3-dev \
		libssl-dev \
		libxml2-dev \
		mcrypt \
		libmcrypt-dev \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

# 下载PHP源码
RUN mkdir -p /usr/src/php/conf.d; \
	cd /usr/src; \
	wget -O php.tar.xz "$PHP_URL";

# 解压源码
RUN tar -Jxf /usr/src/php.tar.xz -C /usr/src/php --strip-components=1

# 编译PHP并安装
RUN cd /usr/src/php \
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
		--with-fpm-user=www-data \
		--with-fpm-group=www-data \
	&& make \
	&& make install \
	&& make clean

# 复制配置文件
COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY php.ini /usr/local/etc/php.ini

# 安装redis扩展
RUN pecl install redis-2.2.8 \
	&& echo 'extension=redis.so' >  /usr/src/php/conf.d/redis.ini

# 创建数据目录
RUN mkdir -p /data/logs \
	&& mkdir -p /data/htdocs

# 工作目录
WORKDIR /data/htdocs

# 导出端口
EXPOSE 80 9000

# 启动命令
CMD ["php-fpm && nginx", "-g", "daemon off;"]