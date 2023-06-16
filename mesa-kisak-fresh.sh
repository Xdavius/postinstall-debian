#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

echo "Job start : Installing mesa-kisak-fresh"
sleep 2

echo "deb https://ppa.launchpadcontent.net/kisak/kisak-mesa/ubuntu jammy main" > /etc/apt/sources.list.d/mesa-kisak-fresh.list && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F63F0F2B90935439 && \
mv /etc/apt/trusted.gpg /etc/apt/trusted.gpg.d/mesa-kisak-fresh.gpg &&\
apt-get update &&\
apt-get full-upgrade -y

echo "
Installation de Mesa + Drivers AMD/Intell Vulkan
"
sleep 2

sudo apt install -y libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386

echo "
Job done.
"
