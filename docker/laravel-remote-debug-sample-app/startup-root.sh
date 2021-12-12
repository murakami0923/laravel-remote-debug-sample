#!/bin/bash

# useradd -s /bin/bash -m ${USER_NAME}
# export HOME=/home/${USER_NAME}
# usermod -u ${USER_ID} ${USER_NAME}
# groupadd -g ${GROUP_ID} ${GROUP_NAME} 
# usermod -g ${GROUP_NAME} ${USER_NAME}

echo ${USER_NAME}
echo ${USER_ID}
echo ${GROUP_NAME}
echo ${GROUP_ID}

groupadd -g ${GROUP_ID} ${GROUP_NAME} 
useradd -u ${USER_ID} -g ${GROUP_ID} -m -s /bin/bash ${USER_NAME}

sed -i -E "s/^user = .+$/user = ${USER_NAME}/g" /usr/local/etc/php-fpm.d/www.conf
sed -i -E "s/^group = .+$/group = ${GROUP_NAME}/g" /usr/local/etc/php-fpm.d/www.conf

/bin/cp /root/startup-user.sh /home/${USER_NAME}/
chown ${USER_NAME}:${GROUP_NAME} /home/${USER_NAME}/startup-user.sh

echo "call ${USER_NAME} startup script"
su - ${USER_NAME} -c "/home/${USER_NAME}/startup-user.sh"
echo "end ${USER_NAME} startup script"

php-fpm
