#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Configuration des Backports
"; sleep 2

if [ ! -x /etc/apt/sources.list.d/backports.list ]
then
	echo "deb http://deb.debian.org/debian/ stable-backports main contrib non-free-firmware non-free" > /etc/apt/sources.list.d/backports.list
 	echo "Package: *
Pin: release a=stable-backports
Pin-priority: 999" > /etc/apt/preferences.d/backports
else
	echo "Le fichier /etc/apt/sources.list.d/backports.list existe déjà !!"
fi

echo "Rafraichissement des dépôts"
apt update -y > /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Installation de synaptic"
apt install -y synaptic > /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Job done
"; sleep 2
