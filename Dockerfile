# Use official PHP image with CLI
FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Composer (if not already in image)
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Install PHP extensions needed by your project here (example: zip, pdo_mysql)
# RUN apt-get update && apt-get install -y libzip-dev zip unzip && docker-php-ext-install zip pdo pdo_mysql

# Install PHP dependencies
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader --no-interaction; fi

# Make the start script executable
RUN chmod +x ./start.sh

# Expose port for Render (match your app's port)
EXPOSE 8080

# Run start script
CMD ["./start.sh"]