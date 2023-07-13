#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

echo "Job start : Uninstalling Nvidia Drivers
"
sleep 2

clear
echo "---------------------------------------------------------------------

POUR REINSTALLER LA VERSION ORIGINALE DE VOTRE BRANCHE RELANCEZ :

nvidia-base.sh

-------------------------------------------------------------------------
"
read -n 1 -p "Appuyez sur ENTRER pour CONTINUER, CTRL+C pour ANNULER *** " select

if [[ $select == "" ]];
	then
	# rm /etc/apt/sources.list.d/experimental.list
	
	apt autopurge -y cuda-keyring* nvidia-cuda-toolkit nvidia-cuda-dev nvidia-cuda-mps
	apt autopurge -y nvidia-driver vulkan-tools firmware-misc-nonfree nvidia-settings libglvnd-dev libvulkan*:i386 nvidia-driver-libs:i386 nvidia-cuda-toolkit nvidia-cuda-dev nvidia-cuda-mps
	echo "Job done"
	echo "Veuillez REBOOT la machine !!"
	else
	exit 2
fi

sleep 10
