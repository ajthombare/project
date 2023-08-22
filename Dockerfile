# Use an official PHP and Apache base image
FROM php:7.4-apache

LABEL maintainer="your-email@example.com"

# Set environment variables for DVWA
ENV MYSQL_PASS="p@ssw0rd"

# Update packages and install necessary tools
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone DVWA repository from GitHub
RUN git clone https://github.com/digininja/DVWA /var/www/html

# Configure Apache
RUN echo "AllowEncodedSlashes On" >> /etc/apache2/apache2.conf && \
    sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

# Enable mod_rewrite and mod_headers
RUN a2enmod rewrite headers

# Create the config file with the provided defaults
RUN cp /var/www/html/config/config.inc.php.dist /var/www/html/config/config.inc.php && \
    sed -i "s/''/'${MYSQL_PASS}'/g" /var/www/html/config/config.inc.php

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose ports
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]


