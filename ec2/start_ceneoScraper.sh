#!/bin/bash

#How to start:
#ssh ec2-user@18.196.80.165 -i id_student 'sudo bash -s' < ~/aws/ec2/start_ceneoScraper.sh

MY_NAME=${MY_NAME:-"Szymon"}
PACKAGES_TO_BE_INSTALLED='cowsay mc tree'
MY_APP_URL=${MY_APP_URL:="https://github.com/szymonkonopek/Ceneo-Webscraper/releases/download/v2.0/Ceneo_Webscraper-1.9-py3-none-any.whl"}
echo "hello $MY_NAME"
#download package .whl
wget -O Ceneo_Webscraper-1.9-py3-none-any.whl "https://github.com/szymonkonopek/Ceneo-Webscraper/releases/download/v2.0/Ceneo_Webscraper-1.9-py3-none-any.whl"

#install pip3
yum -y install python3-pip

#activate venv
. .venv/bin/activate
pip3 install waitress

#install package
pip3 install Ceneo_Webscraper-1.9-py3-none-any.whl

#server
waitress-serve --call 'flaskr:create_app'


