#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Mise à jour des linux-firmware vers la dernière version git
"; sleep 2

echo "installation des dépendances...
"; sleep 2
apt-get install wget tar gzip > /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Téléchargement en cours...
"; sleep 2
wget --no-check-certificate -c https://gitlab.com/kernel-firmware/linux-firmware/-/archive/main/linux-firmware-main.tar.gz -O - | tar -xz

echo "Installation...
"; sleep 2
cp -rf linux-firmware-main/* /usr/lib/firmware

echo "Nettoyage...
"; sleep 2
rm -rf linux-firmware-main

echo "
Veuillez REBOOT la machine !!
"
echo "
Job done
"; sleep 2
