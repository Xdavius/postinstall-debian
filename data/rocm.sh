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
cp $localdir/data/keyring/rocm-keyring.gpg /etc/apt/trusted.gpg.d/

echo "Ajout des dépots rocm et amdgpu"
echo "deb https://repo.radeon.com/amdgpu/latest/ubuntu jammy main" > /etc/apt/sources.list.d/amdgpu.list
echo "deb [arch=amd64] https://repo.radeon.com/rocm/apt/latest jammy main" > /etc/apt/sources.list.d/rocm.list
echo "Package: *
Pin: release o=repo.radeon.com
Pin-Priority: 600" > /etc/apt/preferences.d/repo-radeon-pin-600

apt update
echo "Installation de OPENCL"
apt install rocm-opencl-runtime
echo "Installation de HIP. Cela peut être TRES long ! (2Go)"
apt install rocm-hip-runtime

echo "
Job done
"

sleep 2
