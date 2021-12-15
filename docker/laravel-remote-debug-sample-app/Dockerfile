FROM php:8.0-fpm

RUN apt-get update

# phpのmysql拡張をインストールする
RUN docker-php-ext-install pdo_mysql

# Laravel実行に必要なパッケージをインストール
RUN apt-get install -y git zip unzip

# xdebugをインストールする
# 参考
# https://github.com/mlocati/docker-php-extension-installer/issues/189
# https://github.com/mlocati/docker-php-extension-installer#supported-php-extensions
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions gd xdebug

COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

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
