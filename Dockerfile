# Use a imagem base do PHP com Apache
FROM php:8.2-apache

# Habilite o módulo de reescrita do Apache
RUN a2enmod rewrite

# Instale dependências adicionais para o Laravel e PostgreSQL
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev git unzip \
    libpq-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_pgsql

# Defina o diretório de trabalho
WORKDIR /var/www/html

# Copie o código da aplicação Laravel para dentro do contêiner
COPY . .

# Altere as permissões para o Apache
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Instale o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instale as dependências do Laravel via Composer
RUN composer install --no-dev --optimize-autoloader

# Defina o Apache para servir a pasta 'public'
RUN echo '<VirtualHost *:80>' > /etc/apache2/sites-available/000-default.conf && \
    echo '    DocumentRoot /var/www/html/public' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    <Directory /var/www/html/public>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        AllowOverride All' >> /etc/apache2/sites-available/000-default.conf && \
    echo '        Require all granted' >> /etc/apache2/sites-available/000-default.conf && \
    echo '    </Directory>' >> /etc/apache2/sites-available/000-default.conf && \
    echo '</VirtualHost>' >> /etc/apache2/sites-available/000-default.conf

# Exponha a porta do Apache
EXPOSE 80

# Defina o comando de inicialização
CMD ["apache2-foreground"]
