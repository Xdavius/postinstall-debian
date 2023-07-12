#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

echo "
Installation des repos Sid en pin 10 pour Debian Testing
"
sleep 2

if [ ! -x /etc/apt/sources.list.d/sid.list ]
then
	echo "deb http://deb.debian.org/debian/ sid main contrib non-free-firmware non-free" >> /etc/apt/sources.list.d/sid.list
else
	echo "Le fichier /etc/apt/sources.list.d/sid.list existe déjà !!"
fi

if [ ! -x /etc/apt/preferences.d/sid ]
then
	echo "Package : *" > /etc/apt/sources.list.d/sid.list
	echo "Pin : release a=unstable" >> /etc/apt/sources.list.d/sid.list
	echo "Pin-Priority : 10" >> /etc/apt/sources.list.d/sid.list
else
	echo "Le fichier /etc/apt/preferences.d/sid existe déjà !!"
fi

apt update

echo "
Job done.
"

echo "
Job done.
"
