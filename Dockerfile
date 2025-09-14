# Use official PHP image with CLI
FROM php:8.2-cli

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    zip unzip git libzip-dev \
    && docker-php-ext-install zip

# Copy project files
COPY . .

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Install PHP dependencies
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader --no-interaction; fi

# Make the start script executable
RUN chmod +x ./start.sh

# Expose port for Render
EXPOSE 8080

# Run start script
CMD ["./start.sh"]