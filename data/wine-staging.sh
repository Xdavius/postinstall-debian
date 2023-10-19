#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

echo "Installation de wine-staging
"; sleep 2

echo "Verification du multilib"
dpkg --add-architecture i386

echo "Installation du dépôt"
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources

echo "Rafraîchissement des dépôts"
apt update > /var/log/"$LOGNAME".auto-update.txt 2>&1

echo "Installation..."
apt install -y --install-recommends winehq-staging >> /var/log/"$LOGNAME".auto-update.txt 2>&1

echo "
Job done
"; sleep 2
