#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "
Installation de ROCM HIP et OPENCL Runtimes
" ; sleep 2

localdir=$(pwd)
echo "Copie de la clé du dépot AMD"
cp $localdir/src/rocm-keyring.gpg /etc/apt/trusted.gpg.d/
sleep 1

echo "Ajout des dépots rocm et amdgpu"
echo "deb https://repo.radeon.com/amdgpu/latest/ubuntu jammy main" > /etc/apt/sources.list.d/amdgpu.list
echo "deb [arch=amd64] https://repo.radeon.com/rocm/apt/latest jammy main" > /etc/apt/sources.list.d/rocm.list
echo "Package: *
Pin: release o=repo.radeon.com
Pin-Priority: 600" > /etc/apt/preferences.d/repo-radeon-pin-600
sleep 1

echo "Rafraichissement des dépôts"
apt update > /dev/null 2>&1

echo "Installation de OPENCL"
apt install -y rocm-opencl-runtime > /dev/null 2>&1

echo "Installation de HIP. Cela peut être TRES long ! (2Go)"
apt install -y rocm-hip-runtime

echo "Ajout de l'utilisateur aux groupes Video et Render"
usermod -aG video,render $(who | grep tty | cut -d " " -f 1) > /dev/null 2>&1
sleep 1

echo "
Job done
"; sleep 2
