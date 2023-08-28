#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Job start : Installing mesa-kisak-fresh" > /var/log/$LOGNAME.auto-update.txt 2>&1
sleep 2

echo "deb https://ppa.launchpadcontent.net/kisak/kisak-mesa/ubuntu jammy main" > /etc/apt/sources.list.d/mesa-kisak-fresh.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F63F0F2B90935439 && \
mv /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d/mesa-kisak-fresh.gpg &&\
apt-get update >> /var/log/$LOGNAME.auto-update.txt 2>&1 &&\
apt-get full-upgrade -y >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Job done.
"

sleep 1
