# Usar a imagem oficial do PHP com Apache
FROM php:8.2-apache

# Habilitar o módulo de reescrita do Apache (necessário para Laravel)
RUN a2enmod rewrite

# Instalar dependências do sistema para Laravel e PostgreSQL
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    unzip \
    libpq-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_pgsql

# Definir o diretório de trabalho
WORKDIR /var/www/html

# Copiar o código da aplicação Laravel para o contêiner
COPY . .

# Alterar as permissões para o Apache acessar os arquivos
RUN chown -R www-data:www-data /var/www/html

# Instalar o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar as dependências do Laravel via Composer
RUN composer install --no-dev --optimize-autoloader

# Expor a porta 80
EXPOSE 80

# Definir o comando de inicialização do Apache
CMD ["apache2-foreground"]



