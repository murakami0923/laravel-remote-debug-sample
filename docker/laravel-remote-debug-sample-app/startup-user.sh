#!/bin/bash

cd /var/www/html/

# composerのパッケージをインストールする。
composer install

# .envのAPP_KEYを生成する。
php artisan key:generate
php artisan cache:clear

