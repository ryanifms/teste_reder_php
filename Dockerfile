# Usa a imagem oficial do PHP com Apache
FROM php:8.2-apache

# Instala extensões necessárias
RUN apt-get update && apt-get install -y \
    libpq-dev unzip git curl \
    && docker-php-ext-install pdo pdo_pgsql

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia os arquivos do Laravel
COPY . .

# Instala as dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Configura permissões
RUN chmod -R 775 storage bootstrap/cache

# Define o DocumentRoot para a pasta public
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -i "s|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|" /etc/apache2/sites-available/000-default.conf

# Habilita o mod_rewrite
RUN a2enmod rewrite

# Expõe a porta 80
EXPOSE 80

# Garante que as configurações do Laravel sejam recarregadas
RUN php artisan config:clear && php artisan cache:clear && php artisan config:cache

# Inicia o Apache
CMD ["apache2-foreground"]
