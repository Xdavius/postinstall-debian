#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi
clear
echo "
Configuration du système SECUREBOOT

Installation des dépendances...
" ; sleep 1
apt install -y dkms patch > /var/log/$LOGNAME.auto-update.txt 2>&1

kernel_ver=$(uname -r)
srcdir=$(pwd)
export srcdir
chmod +x $srcdir/SECUREBOOT/data/*.sh
chmod +x $srcdir/SECUREBOOT/data/src/zz-signing

#echo "
#installation de sign-file pour les Kernels Customs...
#" ; sleep 1
#mkdir -p /opt/signtool/
#cp /lib/modules/$kernel_ver/build/scripts/sign-file /opt/signtool


echo "
Installation...
" ; sleep 1

find_securebootsh=$(find . -name secureboot.sh)
source $find_securebootsh

echo "
Job done
" ; sleep 2

