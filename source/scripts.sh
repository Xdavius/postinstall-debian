#!/bin/bash

function nvidia-stable() {
bash ./data/nvidia-stable.sh
sleep 2
nvidia1
}

function nvidia-testing() {
bash ./data/nvidia-testing.sh
sleep 2
nvidia1
}

function nvidia-rollback() {
bash ./data/nvidia-rollback.sh
sleep 2
nvidia1
}

function secureboot() {
bash ./data/secureboot.sh
sleep 2
nvidia1
}

function mesa-kisak() {
bash ./data/mesa-kisak-fresh.sh
sleep 2
amd1
}

function amd-vulkan() {
clear
bash ./data/amd-vulkan.sh
sleep 2
amd1
}

function deb-get() {
clear
bash ./data/deb-get.sh
sleep 2
tools1
}

function wine-staging() {
clear
bash ./data/wine-staging.sh
sleep 2
tools1
}

function install-sid() {
clear
bash ./data/install-sid.sh
sleep 2
tools1
}

function pacstall() {
clear
bash ./data/pacstall.sh
sleep 2
tools1
}

function add-ppa-debian() {
clear
echo "------------------------------------------------------
"
read -p 'Saisir le nom du ppa au format "ppa:nom/repository" : ' $1
bash ./data/add-ppa-debian.sh $1
sleep 2
tools1
}
