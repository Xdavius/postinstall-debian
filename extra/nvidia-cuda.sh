#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Installation des drivers Nvidia Cuda LTS (dépôt Nvidia)
"; sleep 2

echo "*** BUG DEBIAN 12 LIVE ISOS :

Le paquet raspi-firmware installé par défaut dans ces isos est cassée, empêchant la mise à jour de l'initramfs.
Par sécurité, il sera désinstallé et nettoyé. Si vous en avez besoin, considérez le bug et prenez un paquet plus récent en provenance de Sid sur pkgs.org ***

NOTE : Un clean de vulkan/mesa/nvidia sera effectué pour éviter tout conflit. En cas de necessité, vous devrez reinstaller mesa-vulkan-drivers mesa-vulkan-drivers:i386 (INTEL/AMD).
"; sleep 5

apt autopurge -y raspi-firmware > /var/log/$LOGNAME.auto-update.txt 2>&1
rm /etc/initramfs/post-update.d/z50-raspi-firmware

echo "Préparation des dépendances :
"; sleep 2

dpkg --add-architecture i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y contrib >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y non-free >> /var/log/$LOGNAME.auto-update.txt 2>&1

apt install -y linux-headers-amd64 build-essential dkms firmware-misc-nonfree pkg-config wget >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Nettoyage du système :
"; sleep 2

apt autopurge -y nvidia-driver nvidia-settings nvidia-driver-libs:i386 cuda nvidia-gds mesa-vulkan-drivers mesa-vulkan-drivers:i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
 

echo "
Installation du driver Nvidia LTS Cuda FROM Nvidia, Vulkan + Lib32 :

OPERATION TRÈS LONGUE. NE PAS FERMER LA FENÊTRE !!!!
"; sleep 2

echo "Préparation et ajout du dépôt"
wget https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb 
rm cuda-keyring_1.1-1_all.deb

echo "Rafraichissement des dépôts"
apt update >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Mise à niveau du système"
apt full-upgrade -y >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Installation... (LONG !)
mkdir -p /var/run/nvpd/
apt install -y cuda nvidia-driver nvidia-settings vulkan-tools libglvnd-dev nvidia-driver-libs:i386
# apt install nvidia-gds

echo "
Veuillez REBOOT la machine !!
"

echo "
Job done
"; sleep 2
