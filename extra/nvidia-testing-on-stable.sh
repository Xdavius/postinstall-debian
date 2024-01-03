#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Installation des drivers Debian Nvidia Testing Driver + Cuda
"; sleep 2

echo "*** BUG DEBIAN 12 LIVE ISOS :

Le paquet raspi-firmware installé par défaut dans ces isos est cassée, empêchant la mise à jour de l'initramfs.
Par sécurité, il sera désinstallé et nettoyé. Si vous en avez besoin, considérez le bug et prenez un paquet plus récent en provenance de Sid sur pkgs.org ***

NOTE : Un clean de vulkan/mesa/nvidia sera effectué pour éviter tout conflit. En cas de necessité, vous devrez reinstaller mesa-vulkan-drivers mesa-vulkan-drivers:i386 (INTEL/AMD).

"; sleep 5

apt autopurge -y raspi-firmware > /var/log/$LOGNAME.auto-update.txt 2>&1
rm /etc/initramfs/post-update.d/z50-raspi-firmware

echo "Nettoyage du système 
"; sleep 2

apt autopurge -y nvidia-driver nvidia-settings nvidia-driver-libs:i386 cuda cuda-* nvidia-gds mesa-vulkan-drivers mesa-vulkan-drivers:i386 nvidia-* nvidia*:i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1


echo "Préparation des dépendances 
"; sleep 2

dpkg --add-architecture i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y contrib >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y non-free >> /var/log/$LOGNAME.auto-update.txt 2>&1

apt install -y linux-headers-amd64 build-essential dkms libglvnd-dev firmware-misc-nonfree pkg-config wget >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Ajout du dépôt testing 
"; sleep 2

if [ ! -x /etc/apt/sources.list.d/testing.list ]
then
	echo "deb http://deb.debian.org/debian/ testing main contrib non-free-firmware non-free" >> /etc/apt/sources.list.d/testing.list
else
	echo "Le fichier /etc/apt/sources.list.d/testing.list existe déjà !!"
fi

if [ ! -x /etc/apt/preferences.d/testing ]
then
	echo "Package : *" > /etc/apt/preferences.d/testing
	echo "Pin : release a=testing" >> /etc/apt/preferences.d/testing
	echo "Pin-Priority : -1" >> /etc/apt/preferences.d/testing
else
	echo "Le fichier /etc/apt/preferences.d/testing existe déjà !!"
fi

echo "Rafraichissement des dépôts
"; sleep 2

dpkg --add-architecture i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
apt update >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Installation du driver et de Vulkan + Lib32 (LONG !)
"; sleep 2

export DEBIAN_FRONTEND=noninteractive
apt-mark unhold dkms
mkdir -p /var/run/nvpd/
apt install -y -t testing dkms nvidia-driver vulkan-tools libglvnd-dev firmware-misc-nonfree linux-headers-amd64 linux-image-amd64 >> /var/log/$LOGNAME.auto-update.txt 2>&1
apt install -y -t testing nvidia-driver-libs:i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1

#echo "Installation de Cuda (LONG !)
#"; sleep 2

#apt install -y -t testing nvidia-cuda-toolkit nvidia-cuda-dev >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Installation drm-modeset=1
"

if [[ -f /etc/modprobe.d/nvidia.conf ]]; then
    rm /etc/modprobe.d/nvidia.conf
fi
touch /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf

echo "SI VOUS UTILISEZ SECUREBOOT, VEUILLEZ RELANNCER LA PROCEDURE !

Veuillez REBOOT la machine !!
"; sleep 2

echo "
Job done
"; sleep 2
