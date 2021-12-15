#!/bin/bash

# 環境変数で渡されたユーザー、グループ情報をechoする。（アプリケーション実行ユーザー）
echo ${USER_NAME}
echo ${USER_ID}
echo ${GROUP_NAME}
echo ${GROUP_ID}

# 環境変数で渡されたユーザー、グループを作成する。
groupadd -g ${GROUP_ID} ${GROUP_NAME} 
useradd -u ${USER_ID} -g ${GROUP_ID} -m -s /bin/bash ${USER_NAME}

# php-fpm実行ユーザーを変更する。
sed -i -E "s/^user = .+$/user = ${USER_NAME}/g" /usr/local/etc/php-fpm.d/www.conf
sed -i -E "s/^group = .+$/group = ${GROUP_NAME}/g" /usr/local/etc/php-fpm.d/www.conf

# startup-user.shを作成したユーザーのホームディレクトリへ複製し、所有者を変更する。
/bin/cp /root/startup-user.sh /home/${USER_NAME}/
chown ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}/startup-user.sh

# startup-user.shを実行する。
echo "call ${USER_NAME} startup script"
su - ${USER_NAME} -c "/home/${USER_NAME}/startup-user.sh"
echo "end ${USER_NAME} startup script"

# php-fpmを実行する。
php-fpm
