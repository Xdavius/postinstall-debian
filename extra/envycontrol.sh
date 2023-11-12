#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear

echo "Installation de Envycontrol
"; sleep 2

wget https://github.com/Xdavius/envycontrol/releases/download/3.3/python3-envycontrol_3.3.1-1_all.deb
apt install ./python3-envycontrol_3.3.1-1_all.deb
rm python3-envycontrol_3.3.1-1_all.deb

echo "
Job done
"; sleep 2
