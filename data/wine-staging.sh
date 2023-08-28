#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

echo "Job start : Installing wine-staging

Patientez...
" 
sleep 2 > /var/log/$LOGNAME.auto-update.txt 2>&1

dpkg --add-architecture i386
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
apt update >> /var/log/$LOGNAME.auto-update.txt 2>&1
apt install -y python3-gi-cairo >> /var/log/$LOGNAME.auto-update.txt 2>&1
apt install -y --install-recommends winehq-staging >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Job done"
