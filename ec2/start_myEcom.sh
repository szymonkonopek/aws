#!/bin/bash

#How to start:
#ssh ec2-user@18.196.80.165 -i id_student 'sudo bash -s' < ~/aws/ec2/start_myEcom.sh

MY_NAME=${MY_NAME:-"Szymon"}
PACKAGES_TO_BE_INSTALLED='cowsay mc tree'
MY_APP_URL=${MY_APP_URL:="https://github.com/szymonkonopek/myEcom/releases/download/v1.31/my-ecommerce-0.1.jar"}
MY_APP_DIR=/opt/ecommerce

echo "hello $MY_NAME"
dnf install -y -q ${PACKAGES_TO_BE_INSTALLED} #y zgadza się na wszystko

#Install java
dnf -y -q install java-17-amazon-corretto

#dir structure
mkdir -p /opt/ecommerce

##Going to download app jar
wget -O /opt/ecommerce/app.jar ${MY_APP_URL} #pobiera to 2 raz jezeli juz jest
java -Dserver.port=80 -jar /opt/ecommerce/app.jar

cowsay 'it works 🐄'

#get mysql mariadb, install server
# sudo dnf install mariadb105-server -y -q
# systemctl enable mariadb
# systemctl status mariadb
# systemctl start mariadb
# sudo mysql -u root

# create database my_db;
# use my_db;