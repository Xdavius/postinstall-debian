#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi


echo "
Installation de Vulkan AMD/Intel
"
sleep 2

dpkg --add-architecture i386
apt-add-repository -y contrib
apt-add-repository -y non-free

apt install -y libgl1-mesa-dri libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386

echo "
Job done.
"
