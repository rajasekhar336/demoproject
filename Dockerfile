# Use official PHP image as base
FROM php:7.4-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set upload_max_filesize to 256M

#COPY php/php.ini /usr/local/etc/php/
#RUN sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 256M/' /usr/local/etc/php/php.ini-production
#RUN sed -i 's/^upload_max_filesize = .*/upload_max_filesize = 256M/' /usr/local/etc/php/php.ini-development
# Copy CodeIgniter files into the container
COPY src/detsci /var/www/html/

# Configure virtual host
COPY apache-config/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY php/custom-php.ini /usr/local/etc/php/conf.d/custom-php.ini
# Expose port 80
EXPOSE 80

# Start Apache
#CMD ["apache2-foreground"]
# Start Apache HTTP Server
CMD ["apache2ctl", "-D", "FOREGROUND"]



