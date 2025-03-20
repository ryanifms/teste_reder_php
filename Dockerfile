# Use a imagem base do PHP com Apache
FROM php:8.2-apache

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    unzip \
    git \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip \
    && a2enmod rewrite

# Instalar o Composer (gerenciador de dependências PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configurar o diretório de trabalho
WORKDIR /var/www/html

# Copiar o conteúdo do seu projeto para dentro do contêiner
COPY . .

# Instalar as dependências do Laravel
RUN composer install --optimize-autoloader --no-dev

# Ajustar permissões de diretórios (para evitar problemas com permissões no Linux)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expor a porta 80
EXPOSE 80

# Iniciar o Apache no contêiner
CMD ["apache2-foreground"]



