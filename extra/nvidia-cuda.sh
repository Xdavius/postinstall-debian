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

echo "Nettoyage du système...
"; sleep 2

apt autopurge -y cuda-keyring nvidia-driver nvidia-settings nvidia-driver-libs:i386 cuda nvidia-gds mesa-vulkan-drivers mesa-vulkan-drivers:i386 cuda-* nvidia-* libnvidia* >> /var/log/$LOGNAME.auto-update.txt 2>&1
rm /etc/apt/sources.list.d/cuda*.list 

echo "Préparation des dépendances...
"; sleep 2

apt-get install -y software-properties-common > /var/log/$LOGNAME.auto-update.txt 2>&1
dpkg --add-architecture i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y contrib >> /var/log/$LOGNAME.auto-update.txt 2>&1
add-apt-repository -y non-free >> /var/log/$LOGNAME.auto-update.txt 2>&1

apt install -y linux-headers-amd64 build-essential dkms firmware-misc-nonfree pkg-config libglvnd-dev wget >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "
Installation du driver Nvidia LTS Cuda FROM Nvidia, Vulkan + Lib32 

OPERATION TRÈS LONGUE. NE PAS FERMER LA FENÊTRE !!!!
"; sleep 2

echo "Préparation et ajout du dépôt..."
wget https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb 
rm cuda-keyring_1.1-1_all.deb

echo "Ajout compatibilité Testing/Sid..."
wget http://ftp.de.debian.org/debian/pool/main/n/ncurses/libtinfo5_6.4-4_amd64.deb
dpkg -i libtinfo5_6.4-4_amd64.deb
rm libtinfo5_6.4-4_amd64.deb

#echo "Workarround des conneries Nvidia..."
#apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub
#cp /etc/apt/trusted.gpg /usr/share/keyrings/cuda-archive-keyring.gpg
#rm /etc/apt/trusted.gpg

rm /etc/apt/sources.list.d/cuda-debian11-x86_64.list
echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /" > /etc/apt/sources.list.d/cuda-debian12-x86_64.list

echo "Rafraichissement des dépôts..."
apt update >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Mise à niveau du système..."
apt full-upgrade -y >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Installation... (LONG !)"
mkdir -p /var/run/nvpd/
echo "Installation du driver vidéo. Patientez..."
apt install -y cuda-drivers nvidia-driver nvidia-settings vulkan-tools libglvnd-dev nvidia-driver-libs:i386 >> /var/log/$LOGNAME.auto-update.txt 2>&1

#echo "Installation de Cuda... Patientez ENCORE !! (Très long !)"
#apt install -y cuda

echo "
Installation drm-modeset=1
"

if [[ -f /etc/modprobe.d/nvidia.conf ]]; then
    rm /etc/modprobe.d/nvidia.conf
fi
touch /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1" > /etc/modprobe.d/nvidia.conf

echo "
Veuillez REBOOT la machine !!
"

echo "
Job done
"; sleep 2
