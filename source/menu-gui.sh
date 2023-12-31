#!/bin/bash
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR MENU PRINCIPALE
#
#--------------------------------------------------------------------------------------------------------------------------------------------------
set -a
source ./source/gui_functions.sh

function menu() {

export count
if [[ $count == 1 ]] ; then
ferme_yad
fi
count=1
localdir=$(pwd)
export localdir
logo
CG=$(yad --center --window-icon="$logo" --title="POSTINSTALL FOR DEBIAN" --width 500 --height 140 --text-align="center" --no-buttons \
 --form \
 --field " Configurer SECUREBOOT !./source/secureboot.png!:fbtn" "bash -c secureboot" \
 --field "Gestion des pilotes NVIDIA !./source/nvidia_logo.png!:fbtn" "bash -c nvidia" \
 --field "Gestion des pilotes AMD !./source/amd_logo.png:fbtn" "bash -c amd" \
 --field "Applications et Utilitaires !./source/package_debian.png!:fbtn" "bash -c utilitaire"\
)
}

set +a

menu
