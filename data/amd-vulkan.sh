#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "Installation de Vulkan AMD/Intel
"; sleep 2

echo "Vérification des dépôts additionnels"; sleep 1
dpkg --add-architecture i386
apt-add-repository -y contrib > /var/log/"$LOGNAME".auto-update.txt 2>&1
apt-add-repository -y non-free >> /var/log/"$LOGNAME".auto-update.txt 2>&1

echo "Installation..."
apt install -y libgl1-mesa-dri libgl1-mesa-dri:i386 mesa-vulkan-drivers mesa-vulkan-drivers:i386 vulkan-tools >> /var/log/"$LOGNAME".auto-update.txt 2>&1

echo "
Job done
"; sleep 2
