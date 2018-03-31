#!/bin/bash
echo "Debian 9  S.M.I installation "
echo "Installation des outils Serveur "
apt-get install mc openssh-server net-tools -y
apt-get install build-essential -y
apt-get install libxml2-dev libcurl4-openssl-dev libjpeg-dev libpng-dev libxpm-dev libpq-dev libicu-dev libfreetype6-dev libldap2-dev libfcgi-dev libfcgi0ldbl libmcrypt-dev libssl-dev -y
clear
echo "This the End "
echo "That's all folks"
echo  "Test du php5-apache-Mysql "
php --version && apache2 -v && mysql -V && uname -a
