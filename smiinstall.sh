#!/bin/bash
################################################################################
# Script for installing SMI 1.0.6 on Debian9 Attention not tested in ubuntu
# Author: Serge Mata copyrate a tout le monde SMOM Tools
#-------------------------------------------------------------------------------
# This script will install on your SMI 1.0.6 Debian Stretch server.
# Debian de base installée DE BASE J'insiste.. Debian minimal.
#-------------------------------------------------------------------------------
#  Basculer en root en utilisant la commande su 
#  On dois se retrouver en root 
#  Creer un nouveau fichier 
#  nano setup.sh ou smiinstall.sh
#       Placez ce contenu dedans 
#       Execute the script to install SMI 1.0.6:
#  sh setup.sh ou sh smiinstall.sh
#  Sélectionner la version MySQL désirée. Jessie 5.6
################################################################################

#Post install
#Debian 9
#-------------------------------------------------------------------------------
echo "Debian 9  S.M.I installation "
echo "Installation des outils Serveur "
apt-get install mc openssh-server net-tools -y
apt-get install build-essential -y
apt-get install libxml2-dev libcurl4-openssl-dev libjpeg-dev libpng-dev libxpm-dev libpq-dev libicu-dev libfreetype6-dev libldap2-dev libfcgi-dev libfcgi0ldbl libmcrypt-dev libssl-dev -y
#-------------------------------------------------------------------------------
echo "Installation apache2 "
apt-get install apache2 apache2-dev -y
echo "Recuperation du Mysql community "
echo "Sélectionner la version MySQL Jessie 5.6 "
wget http://dev.mysql.com/get/mysql-apt-config_0.8.0-1_all.deb
dpkg -i mysql-apt-config_0.8.0-1_all.deb
# L’utilitaire de configuration des dépôts s’affiche.
# Sélectionner la version MySQL désirée. Jessie 5.6
# Sélectionner « Ok »
# Un fichier /etc/apt/sources.list.d/mysql.list est généré.
# Reste à faire une mise à jour d’apt-get :
apt-get update
apt-get install mysql-community-server
#-------------------------------------------------------------------------------
echo "Depot de jessie dans sources.list " 
mv /etc/apt/sources.list /etc/apt/sources.list.stretch
# mcedit /etc/apt/sources.list
touch /etc/apt/sources.list
echo "        deb http://ftp.debian.org/debian/ jessie main contrib non-free  " >> /etc/apt/sources.list
echo "        deb-src http://ftp.debian.org/debian/ jessie main contrib non-free " >> /etc/apt/sources.list
echo "        deb http://security.debian.org/ jessie/updates main contrib non-free " >> /etc/apt/sources.list
echo "        deb-src http://security.debian.org/ jessie/updates main contrib non-free " >> /etc/apt/sources.list
apt-get update
apt-get upgrade 
#-------------------------------------------------------------------------------
echo "Installation du php 5 " 
apt-get install php5 php5-pgsql php5-gd php5-curl php5-cli 
apt-get install libapache2-mod-php5 php5-common php5-idn php-pear php5-imagick php5-imap php5-json php5-mcrypt php5-memcache php5-mhash php5-mysql php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl
#-------------------------------------------------------------------------------
echo "Retour au sources stretch " 
mv /etc/apt/sources.list /etc/apt/sources.list.jessie
mv /etc/apt/sources.list.stretch /etc/apt/sources.list  
apt-get update
apt-get upgrade
#------------------------------------------------------------------------------- 
/etc/init.d/apache2 stop
/etc/init.d/apache2 start
#-------------------------------------------------------------------------------
echo "Telechargement des sources smi 1.0.6 "
# wget http://smi.no-ip.org/down/smi_1.0.6.zip
# Je soulage le serveur smi.no-ip
wget https://datapacket.dl.sourceforge.net/project/s-m-i/s-m-i/SMI%201.0.6/smi_1.0.6.zip
echo "Installation de smi 1.0.6 "
mkdir /var/www/html/smi
mkdir /var/www/html/telechgt && mkdir /var/www/html/telechgt/fictec && mkdir /var/www/html/svg && mkdir /var/www/html/logos
unzip  smi_1.0.6.zip -d  /var/www/html/smi/
chmod -R 777 /var/www/html/smi && chmod -R 777 /var/www/html/telechgt && chmod -R 777 /var/www/html/telechgt/fictec && chmod -R 777 /var/www/html/svg && chmod -R 777 //var/www/html/logos
#-------------------------------------------------------------------------------
cp  /var/www/html/smi/install/prm.inc.php /var/www/html/smi/inc/prm.inc.php
#-------------------------------------------------------------------------------
echo "Creation base de donnee smi "
mysqladmin -u root -p create smi
echo "Installation de la base de donnee "
mysql -u root -p smi < /var/www/html/smi/install/sql/smi_1.0.4.sql;
mysql -u root -p smi < /var/www/html/smi/install/sql/smi_1.0.4_to_1.0.5.sql;
mysql -u root -p smi < /var/www/html/smi/install/sql/smi_1.0.5_to_1.0.6.sql;
# mysql -u root -p smi < /var/www/html/smi/install/sql/smi_1.0.6.sql;
mv /var/www/html/smi/install /var/www/html/smi/install.bak
#-------------------------------------------------------------------------------
echo "Compléter les lignes prm.inc.php  "
# ci dessou une version de feignasse prete a l'emploi pour test
# il suffit de décommenter les 2 ligne suivante
# wget http://91.121.52.109/svg/prm.inc.php.zip
# cp prm.inc.php.zip /var/www/html/smi/inc/prm.inc.php

nano /var/www/html/smi/inc/prm.inc.php
#-------------------------------------------------------------------------------  
chmod 644 /var/www/html/smi/inc/prm.inc.php
chmod 755 /var/www/html/smi/inc
#-------------------------------------------------------------------------------
clear
echo "This the End "
echo "That's all folks"
echo  "Test du php5-apache-Mysql "
php --version && apache2 -v && mysql -V && uname -a
 
