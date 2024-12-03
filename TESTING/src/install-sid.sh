#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Installation des repos Sid en pin 10 pour Debian Testing
" ; sleep 2

if [ ! -f /etc/apt/preferences.d/testing ]
then
	echo "Package : *" > /etc/apt/preferences.d/testing
	echo "Pin : release a=testing" >> /etc/apt/preferences.d/testing
	echo "Pin-Priority : 990" >> /etc/apt/preferences.d/testing
else
	echo "Le fichier /etc/apt/preferences.d/testing existe déjà !!"
 	echo "Installation annulée"
  	exit 1
fi

if [ ! -f /etc/apt/sources.list.d/sid.list ]
then
	echo "deb http://deb.debian.org/debian/ sid main contrib non-free-firmware non-free" >> /etc/apt/sources.list.d/sid.list
else
	echo "Le fichier /etc/apt/sources.list.d/sid.list existe déjà !!"
fi

if [ ! -f /etc/apt/preferences.d/sid ]
then
	echo "Package : *" > /etc/apt/preferences.d/sid
	echo "Pin : release a=unstable" >> /etc/apt/preferences.d/sid
	echo "Pin-Priority : 10" >> /etc/apt/preferences.d/sid
else
	echo "Le fichier /etc/apt/preferences.d/sid existe déjà !!"
fi

echo "Rafraichissemnt des dépôts"; sleep 1
apt update > /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Job done
"; sleep 2
