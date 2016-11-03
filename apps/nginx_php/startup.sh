#!/bin/sh
set -e

echo "xdebug.remote_host=$XDEBUG_HOST" > /usr/local/etc/conf.d/xdebug.ini

if [ -e "/usr/bin/supervisord" ]; then
	/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
else
	/usr/local/sbin/php-fpm
	/usr/sbin/nginx -g 'daemon off;'
fi