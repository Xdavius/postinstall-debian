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

read -n 1 -p "Appuyez sur ENTRER pour CONTINUER, CTRL+C pour ANNULER *** " select

if [[ $select == "" ]];
	then
        dpkg --add-architecture i386
        add-apt-repository -y contrib
        add-apt-repository -y non-free

        apt install -y linux-headers-amd64 build-essential dkms libglvnd-dev firmware-misc-nonfree pkg-config

	apt install -y wget
	echo "deb http://deb.debian.org/debian experimental non-free-firmware contrib non-free main" > /etc/apt/sources.list.d/experimental.list
	apt update
	apt install -y -t experimental nvidia-driver libvulkan* firmware-misc-nonfree
	apt install -y -t experimental libvulkan*:i386 nvidia-driver-libs:i386
	apt install -y -t experimental nvidia-cuda-toolkit nvidia-cuda-dev
	apt autoremove -y
	echo "Job done"
	echo "Veuillez REBOOT la machine !!"
	else
	exit 2
fi

exit 1
