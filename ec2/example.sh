#!/bin/bash

#IP: 3.71.202.94
#ssh ec2-user@3.71.202.94 -i id_student echo 'hello'

MY_NAME=${MY_NAME:-"Szymon"}
PACKAGES_TO_BE_INSTALLED='cowsay mc tree'

echo "hello $MY_NAME"
dnf install ${PACKAGES_TO_BE_INSTALLED}



