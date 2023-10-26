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
apt install -f dkms patch > /var/log/$LOGNAME.auto-update.txt 2>&1

kernel_ver=$(uname -r)
srcdir=$(pwd)
export srcdir
chmod +x $srcdir/SECUREBOOT/data/*.sh
chmod +x $srcdir/SECUREBOOT/data/src/zz-signing

echo "
installation de sign-file pour les Kernels Customs...
" ; sleep 1
mkdir -p /opt/signtool/
cp /lib/modules/$kernel_ver/build/scripts/sign-file /opt/signtool

echo "
Patch de dkms pour les kernels Customs, blocage des mises à jour du paquet
" ; sleep 1
# patch -i $srcdir/data/dkms.patch /usr/sbin/dkms
# En cas de changement de version de dkms
cp $srcdir/SECUREBOOT/data/src/dkms.patched /usr/sbin/dkms
chmod +x /usr/sbin/dkms
apt-mark hold dkms

echo "
Installation...
" ; sleep 1
cd $srcdir

source $srcdir/SECUREBOOT/data/secureboot.sh
source $srcdir/SECUREBOOT/data/install-kernel-autosign.sh

echo "
Job done
" ; sleep 2

read -n1 -p "Appuyer sur Entrée pour quitter, puis, pensez à redémarrer !" end
if [[ $end = "" ]] ; then
    exit 1
fi
exit 1
