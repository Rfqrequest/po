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

# Install PHP dependencies
RUN if [ -f composer.json ]; then composer install --no-dev --optimize-autoloader --no-interaction; fi

# Make start script executable
RUN chmod +x ./start.sh

# Expose port for Render
EXPOSE 8080

# Run start script
CMD ["./start.sh"]