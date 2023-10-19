#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear 
echo "Job start : Désinstallation des drivers Nvidia
"; sleep 2

apt autopurge -y cuda-keyring nvidia-cuda-toolkit nvidia-cuda-dev nvidia-cuda-mps > /var/log/"$LOGNAME".auto-update.txt 2>&1
apt autopurge -y nvidia-driver vulkan-tools firmware-misc-nonfree nvidia-settings libglvnd-dev libvulkan*:i386 nvidia-driver-libs:i386 nvidia-cuda-toolkit nvidia-cuda-dev nvidia-cuda-mps >> /var/log/"$LOGNAME".auto-update.txt 2>&1

echo "Veuillez REBOOT la machine !!"

echo "
Job done
"; sleep 2
