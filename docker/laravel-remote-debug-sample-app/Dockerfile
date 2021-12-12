FROM php:8.0-fpm

RUN apt-get update

# phpのmysql拡張をインストールする
RUN docker-php-ext-install pdo_mysql
# xdebugをインストールする
# RUN pecl install xdebug
# RUN ls -l /usr/local/etc/php/

RUN apt-get install -y zlib1g-dev mariadb-client libzip-dev libpq-dev
# RUN docker-php-ext-install zip

RUN mkdir -p /usr/src/php/ext/ \
    && curl -L http://pecl.php.net/get/xdebug-2.3.3.tgz >> /usr/src/php/ext/xdebug.tgz \
    && tar -xf /usr/src/php/ext/xdebug.tgz -C /usr/src/php/ext/

RUN ls -l /usr/src/php/ext/
RUN docker-php-ext-install xdebug-2.3.3

# Laravel実行に必要なパッケージをインストール
RUN apt-get install -y git zip unzip

# composerをインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
# バージョンを指定する場合はこちら。（開発時点最新：2.2）
# もし、latestで最新のcomposerを使って、動作しない場合は、バージョンを明示してお試しください。
# COPY --from=composer:2.2 /usr/bin/composer /usr/bin/composer

# 起動時のスクリプトを設置
COPY startup-root.sh /root/
COPY startup-user.sh /root/
RUN chmod a+x /root/startup-root.sh
RUN chmod a+x /root/startup-user.sh

VOLUME ["/var/run/php-fpm"]

ENTRYPOINT ["/root/startup-root.sh"]
