#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear 
echo "Job start : Uninstalling Nvidia Drivers
"; sleep 2

echo "Désinstallation des clés"
apt autopurge -y cuda-keyring nvidia-cuda-toolkit nvidia-cuda-dev nvidia-cuda-mps > /var/log/$LOGNAME.auto-update.txt 2>&1
echo "Désinstallation des drivers"
apt autopurge -y nvidia-driver cuda cuda-drivers vulkan-tools firmware-misc-nonfree nvidia-settings libglvnd-dev libvulkan*:i386 nvidia-driver-libs:i386 nvidia-cuda-toolkit nvidia-cuda-dev nvidia-cuda-mps >> /var/log/$LOGNAME.auto-update.txt 2>&1
echo "Purge des traces éventuelles"
apt autopurge -y cuda-* nvidia-* libnvidia* >> /var/log/$LOGNAME.auto-update.txt 2>&1
echo "Suppression des sources résiduelles"
rm /etc/apt/sources.list.d/cuda*.list
if [[ -f /etc/modprobe.d/nvidia.conf ]]; then
    rm /etc/modprobe.d/nvidia.conf
fi
echo "Raffraichissement des dépôts"
apt update >> /var/log/$LOGNAME.auto-update.txt 2>&1

echo "Veuillez REBOOT la machine !!"; sleep 1

echo "
Job done
"; sleep 2
