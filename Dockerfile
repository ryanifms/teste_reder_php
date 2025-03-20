# Usando imagem oficial do PHP com Apache
FROM php:8.2-apache

# Instalar extensões necessárias para o PostgreSQL e outras dependências
RUN apt-get update && apt-get install -y \
    libpq-dev unzip git curl \
    && docker-php-ext-install pdo pdo_pgsql

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configura o diretório de trabalho
WORKDIR /var/www/html

# Copia todos os arquivos para dentro do container
COPY . .

# Instala as dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Configura permissões para as pastas storage e bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache
RUN chown -R www-data:www-data storage bootstrap/cache

# Configura o Apache para usar o DocumentRoot na pasta "public"
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN sed -i "s|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|" /etc/apache2/sites-available/000-default.conf

# Habilita o módulo rewrite do Apache
RUN a2enmod rewrite

# Expõe a porta 80 para o servidor
EXPOSE 80

# Rodar o comando do Laravel para otimizar a configuração
RUN php artisan config:clear && php artisan cache:clear && php artisan config:cache

# Habilita o Laravel para rodar em produção (opcional)
RUN php artisan key:generate --force

# Inicia o Apache no primeiro plano
CMD ["apache2-foreground"]


