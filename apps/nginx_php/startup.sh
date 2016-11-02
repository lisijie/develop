#!/bin/sh
set -e

echo "xdebug.remote_host=$XDEBUG_HOST" > /usr/local/etc/conf.d/xdebug.ini

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf