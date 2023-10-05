#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear

echo "Job start : Installation de Steam
"; sleep 2
echo "
Préparation des dépendances :
"; sleep 2

dpkg --add-architecture i386 > /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y contrib >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y non-free >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Installation... Veuillez patienter
"; sleep 2

apt install -y steam >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Job done
"; sleep 2
