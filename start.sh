#!/bin/sh -e
uwsgi --ini /opt/loris/uwsgi.ini --master --enable-threads &
exec nginx -g 'daemon off;'
