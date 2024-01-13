#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Vous devez executer la commande en root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear

echo "Installation des drivers Nvidia
"; sleep 2

echo "Nettoyage du système...
"; sleep 2

apt autopurge -y cuda-keyring nvidia-driver nvidia-settings nvidia-driver-libs:i386 cuda nvidia-gds mesa-vulkan-drivers mesa-vulkan-drivers:i386 cuda-* nvidia-* libnvidia* >> /var/log/$LOGNAME.auto-update.txt 2>&1
rm /etc/apt/sources.list.d/cuda*.list 

echo "Préparation des dépendances...
"; sleep 2

dpkg --add-architecture i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y contrib >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y non-free >> /var/log/$LOGNAME.auto-update.txt 2>&1

apt install -y linux-headers-amd64 build-essential dkms firmware-misc-nonfree wget >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Installation du driver Nvidia

"; sleep 2

echo "Préparation et ajout du dépôt..."
wget https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb 
rm cuda-keyring_1.1-1_all.deb

echo "Rafraichissement des dépôts..."
apt update >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Mise à niveau du système..."
apt full-upgrade -y >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Installation du driver Nvidia. Patientez..."
apt install -y nvidia-driver nvidia-settings nvidia-driver-libs:i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Ajout de l'option kernel nvidia-drm modeset=1
"

touch /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf

echo "
Installation réussie, veuillez redémarrer l'ordinateur !!
"

"; sleep 2
