#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Installation de Discord
"; sleep 2

echo "Installation de la clé du dépôt"
gpg --no-default-keyring --keyring=/usr/share/keyrings/javinator9889-ppa-keyring.gpg --keyserver keyserver.ubuntu.com --recv-keys A2A43BD5139A4173 > /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Ajout du dépot"
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/javinator9889-ppa-keyring.gpg] https://ppa.javinator9889.com all main" | tee /etc/apt/sources.list.d/javinator9889-ppa.list >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Rafraîchissement des dépôts"
apt update -y >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Installation de Discord"
apt install -y discord >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Job done
"; sleep 2
