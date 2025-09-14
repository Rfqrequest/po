#!/bin/sh
set -e

PORT=${PORT:-8080}
echo "Starting PHP built-in server on 0.0.0.0:$PORT (document root: public/)"
exec php -S 0.0.0.0:$PORT -t public