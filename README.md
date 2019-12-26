# laravel-docker
学习 docker-compose 为 Laravel 搭建的环境。

## 概述
环境包括：
- PHP 7.3.13-fpm-alpine
- Nginx alpine
- MYSQL 5.7.28
- redis alpine
- composer （已配置阿里云镜像）

## 安装

``` shell
$ docker-compose run --rm --no-deps app composer install
$ docker-compose run --rm --no-deps app php artisan key:generate
$ docker-compose run --rm --no-deps app php artisan storage:link
$ docker-compose up -d
```