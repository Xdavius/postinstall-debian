#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "
----------------------------------------------------

Job start : Installing Nvidia Experimental Drivers

----------------------------------------------------

"
sleep 2

echo "*** BUG DEBIAN 12 LIVE ISOS :

Le paquet raspi-firmware installé par défaut dans ces isos est cassée, empêchant la mise à jour de l'initramfs.
Par sécurité, il sera désinstallé et nettoyé. Si vous en avez besoin, considérez le bug et prenez un paquet plus récent en provenance de Sid sur pkgs.org ***

NOTE : Un clean de vulkan/mesa/nvidia sera effectué pour éviter tout conflit. En cas de necessité, vous devrez reinstaller mesa-vulkan-drivers mesa-vulkan-drivers:i386 (INTEL/AMD).


"
sleep 5

apt autopurge -y raspi-firmware
rm /etc/initramfs/post-update.d/z50-raspi-firmware

echo "
Préparation des dépendances :
"
sleep 2
dpkg --add-architecture i386
add-apt-repository -y contrib
add-apt-repository -y non-free

apt install -y linux-headers-amd64 build-essential dkms libglvnd-dev firmware-misc-nonfree pkg-config wget

echo "
Nettoyage du système :
"
sleep 2

apt autopurge -y nvidia-driver nvidia-settings nvidia-driver-libs:i386 cuda nvidia-gds

if [ ! -x /etc/apt/sources.list.d/experimental.list ]
then
    echo "deb http://deb.debian.org/debian experimental non-free-firmware contrib non-free main" > /etc/apt/sources.list.d/experimental.list
fi
apt update

echo "
Installation du driver et de Vulkan + Lib32 :
"
sleep 2

apt update
apt install -y -t experimental nvidia-driver vulkan-tools vulkan-tools firmware-misc-nonfree nvidia-settings libglvnd-dev
apt install -y -t experimental nvidia-driver-libs:i386

echo "
Installation de Cuda :
"
sleep 2

apt install -y -t experimental nvidia-cuda-toolkit nvidia-cuda-dev nvidia-cuda-mps
apt autoremove -y

echo "

Job done
"

echo "
Veuillez REBOOT la machine !!
"

sleep 10
