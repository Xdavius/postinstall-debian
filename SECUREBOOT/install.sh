#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi
clear
echo "Configuration du système SECUREBOOT

Installation des dépendances...
"
apt install -f dkms patch > /var/log/$LOGNAME.auto-update.txt 2>&1

kernel_ver=$(uname -r)
srcdir=$(pwd)
chmod +x data/*.sh
chmod +x data/src/zz-signing

echo "installation de sign-file pour les Kernels Customs"
mkdir -p /opt/signtool/
cp /lib/modules/$kernel_ver/build/scripts/sign-file /opt/signtool

echo "Patch de dkms pour les kernels Customs, blocage des mises à jour du paquet"
patch -i $srcdir/data/dkms.patch /usr/sbin/dkms
apt-mark hold dkms

echo "Installation..."
source $srcdir/data/secureboot.sh
source $srcdir/data/install-kernel-autosign.sh
