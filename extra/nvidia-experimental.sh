#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Job start : Installing Nvidia Experimental Drivers
"; sleep 2

echo "Nettoyage du système 
"; sleep 2

apt autopurge -y nvidia-driver nvidia-settings nvidia-driver-libs:i386 cuda nvidia-gds mesa-vulkan-drivers mesa-vulkan-drivers:i386 nvidia-* nvidia*:i386 cuda-* > /var/log/$LOGNAME.auto-update.txt 2>&1

if [ ! -x /etc/apt/sources.list.d/experimental.list ]
then
    echo "deb http://deb.debian.org/debian experimental non-free-firmware contrib non-free main" > /etc/apt/sources.list.d/experimental.list
fi
apt update -y >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Préparation des dépendances 
"
sleep 2
apt-get install -y software-properties-common >> /var/log/$LOGNAME.auto-update.txt 2>&1
dpkg --add-architecture i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y contrib >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y non-free >> /var/log/$LOGNAME.auto-update.txt 2>&1


apt install -y linux-headers-amd64 build-essential dkms libglvnd-dev firmware-misc-nonfree pkg-config wget >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Installation du driver et de Vulkan + Lib32 (LONG !)
"; sleep 2

export DEBIAN_FRONTEND=noninteractive
apt update >> /var/log/$LOGNAME.auto-update.txt 2>&1
apt-mark unhold dkms
mkdir -p /var/run/nvpd/
apt install -y -t sid dkms
apt install -y -t experimental nvidia-driver vulkan-tools firmware-misc-nonfree nvidia-settings libglvnd-dev
apt install -y -t experimental nvidia-driver-libs:i386 

#echo "Installation de Cuda (LONG !)
#"; sleep 2

#apt install -y -t experimental nvidia-cuda-toolkit

echo "
Installation drm-modeset=1
"

if [[ -f /etc/modprobe.d/nvidia.conf ]]; then
    rm /etc/modprobe.d/nvidia.conf
fi
touch /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf

echo "SI VOUS UTILISEZ SECUREBOOT, VEUILLEZ RELANCER LA PRECEDURE !

Veuillez REBOOT la machine !!
"; sleep 2

echo "
Job done
"; sleep 2
