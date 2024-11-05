#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

echo "Job start : Installing Lutris Latest
" ; sleep 2

apt-get install -y gpg
dpkg --add-architecture i386

echo "Ajout du dépôt lutris.list"
echo "deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null

echo "Installation de la clé GPG"
wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null

echo "Rafraichissement des dépôts"
apt update > /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Installation de Lutris"
apt install -y wine wine32 >> /var/log/$LOGNAME.auto-update.txt 2>&1
apt install -y python3-gi-cairo >> /var/log/$LOGNAME.auto-update.txt 2>&1
apt install -y lutris >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Job done
"; sleep 2
