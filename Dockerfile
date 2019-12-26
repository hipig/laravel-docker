FROM php:7.3.13-fpm-alpine

LABEL maintainer="205270006@qq.com"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# Install dev dependencies
RUN apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    curl-dev \
    imagemagick-dev \
    libtool \
    libxml2-dev \
    postgresql-dev \
    sqlite-dev

# Install production dependencies
RUN apk add --no-cache \
    bash \
    curl \
    g++ \
    gcc \
    git \
    imagemagick \
    libc-dev \
    libpng-dev \
    make \
    mysql-client \
    nodejs \
    nodejs-npm \
    yarn \
    openssh-client \
    postgresql-libs \
    rsync \
    zlib-dev \
    libzip-dev

# Install PECL and PEAR extensions
# RUN pecl install imagick

# Install and enable php extensions
# RUN docker-php-ext-enable imagick
RUN docker-php-ext-configure zip --with-libzip
RUN docker-php-ext-install \
    calendar \
    curl \
    exif \
    iconv \
    mbstring \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite \
    pcntl \
    tokenizer \
    xml \
    gd \
    zip \
    bcmath

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

# 修改 composer 为国内镜像
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

# Installing prestissimo
RUN composer global require "hirak/prestissimo"

# Cleanup dev dependencies
RUN apk del -f .build-deps

# Changing Workdir
WORKDIR /var/www
