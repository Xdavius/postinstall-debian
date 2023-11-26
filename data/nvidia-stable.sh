#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear

echo "Installation des Nvidia Drivers Stable + Cuda 
"; sleep 2

echo "*** BUG DEBIAN 12 LIVE ISOS :

Le paquet raspi-firmware installé par défaut dans ces isos est cassée, empêchant la mise à jour de l'initramfs.
Par sécurité, il sera désinstallé et nettoyé. Si vous en avez besoin, considérez le bug et prenez un paquet plus récent en provenance de Sid sur pkgs.org ***

NOTE : Un clean de vulkan/mesa/nvidia sera effectué pour éviter tout conflit. En cas de necessité, vous devrez reinstaller mesa-vulkan-drivers mesa-vulkan-drivers:i386 (INTEL/AMD).

Veuillez patienter...
"; sleep 5

apt autopurge -y raspi-firmware > /var/log/$LOGNAME.auto-update.txt 2>&1
rm /etc/initramfs/post-update.d/z50-raspi-firmware

echo "
Nettoyage du système :
"; sleep 2

apt autopurge -y nvidia-* libnvidia* cuda-* nvidia*:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
rm /etc/apt/sources.list.d/cuda*.list 

echo "
Préparation des dépendances :
"; sleep 2

dpkg --add-architecture i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y contrib >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y non-free >> /var/log/$LOGNAME.auto-update.txt 2>&1

apt install -y linux-headers-amd64 build-essential dkms libglvnd-dev pkg-config firmware-misc-nonfree pkg-config wget >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Installation du driver et de Vulkan + Lib32 :
"; sleep 2

mkdir -p /var/run/nvpd/
apt install -y nvidia-driver vulkan-tools nvidia-settings >> /var/log/$LOGNAME.auto-update.txt 2>&1
apt install -y vulkan-tools:i386 nvidia-driver-libs:i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Installation de Cuda :
"; sleep 2

apt install -y nvidia-cuda-toolkit nvidia-cuda-dev >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Installation drm-modeset=1
"
if [[ -f /etc/modprobe.d/nvidia.conf ]]; then
    rm /etc/modprobe.d/nvidia.conf
fi
touch /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf

echo "Veuillez REBOOT la machine !!"

echo "
Job done
"; sleep 2
