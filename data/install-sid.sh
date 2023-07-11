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
    cp ./sid.list /etc/apt/sources.list.d/sid.list
fi

echo "Le fichier /etc/apt/sources.list.d/sid.list existe déjà !!"

if [ ! -x /etc/apt/preferences.d/sid ]
then
    cp ./sid /etc/apt/preferences.d/sid
fi

echo "Le fichier /etc/apt/preferences.d/sid existe déjà !!"

apt update

echo "
Job done.
"
