# Use CLI image and copy composer from official composer image
FROM php:8.2-cli

WORKDIR /app

# bring composer into the image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# copy project files
COPY . /app

# install composer dependencies if composer.json exists
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader --no-interaction; fi

# make start script executable
RUN chmod +x ./start.sh

# expose a port (informational)
EXPOSE 8080

# runtime entrypoint (start.sh will read $PORT)
CMD ["./start.sh"]