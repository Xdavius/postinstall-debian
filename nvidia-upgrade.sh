#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

echo "Job start : Cleaning previous Nvidia Pro Drivers
"
sleep 1

apt autopurge -y cuda-keyring

echo "Job start : Installing Nvidia Pro Drivers
"
sleep 2

read -n 1 -p "*** Vous devez avoir installer le script nvidia-base avant celui-ci et avoir reboot votre machine. Appuyez sur ENTRER pour CONTINUER, CTRL+C pour ANNULER *** " select

if [[ $select == "" ]];
	then
 	apt install -y wget
	wget https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/cuda-keyring_1.0-1_all.deb && sudo dpkg -i cuda-keyring_1.0-1_all.deb
	apt update
	apt full-upgrade -y
	rm cuda-keyring_1.0-1_all.deb	
	echo "Job done"
	echo "Veuillez REBOOT la machine !!"
	else
	exit 2
fi

exit 1
