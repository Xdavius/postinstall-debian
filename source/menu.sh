#!/bin/bash
# foncitons


function yad_progress () {
yadid=$(pgrep yad)
sudo -S kill $yadid
yad --progress --pulsate --title "installation de $app_name" --progress-text="installation en cours " --width 300 --height 50 --no-buttons &
yadid=$(pgrep yad)
echo $password | sudo -S "$data_loc"
sudo -S kill $yadid
yad --info --width 500 --height 170 --text="installation terminée"
}

function ferme_yad () { PidYad=$(pgrep yad); kill -s SIGUSR1 "$PidYad";}

function NVIDIA () {
COM_STABLE="Installer driver Nvidia Stable (Recommandé)"
COM_AUTRE="Autres drivers Nvidia (Pour utilisateurs Expérimentés !!)"
COM_SECUREBOOT="Configurer Secureboot pour Nvidia"
COM_REMOVE="Supprimer driver Nvidia"
NVIDIA=$(yad --title="Gestionnaire NVIDIA" --width 500 --height 170 --text-align="center" --list --radiolist --column=" " --column="installer" --column="espace" --column="commentaire" True "STABLE" "   " "$COM_STABLE" False "AUTRE" "   " "$COM_AUTRE" False "SECUREBOOT" "   " "$COM_SECUREBOOT" False "REMOVE" "   " "$COM_REMOVE"  --no-headers )
if [ "$(echo "$NVIDIA" | cut -d'|' -f2)" = "STABLE" ]; then
    app_name="STABLE"
    data_loc="./data/nvidia-stable.sh"
    yad_progress
elif [ "$(echo "$NVIDIA" | cut -d'|' -f2)" = "AUTRE" ]; then
    NVIDIA2
elif [ "$(echo "$NVIDIA" | cut -d'|' -f2)" = "REMOVE" ]; then
    app_name="REMOVE"
    data_loc="./data/nvidia-rollback.sh"
    yad_progress
elif [ "$(echo "$NVIDIA" | cut -d'|' -f2)" = "SECUREBOOT" ]; then
    app_name="SECUREBOOT"
    data_loc="./data/secureboot.sh"
    yad_progress
fi
}

function NVIDIA2 () {
COM_EXPERIMENTAL="Installer driver Nvidia Experimental"
COM_CUDA="Installer driver depuis le depot Nvidia Cuda (Compatible Secureboot)"
COM_TESTING="nstaller driver Nvidia de Testing en pin 10 (Pour Debian Stable)"
NVIDIA2=$(yad --title="Gestionnaire NVIDIA" --width 500 --height 170 --text-align="center" --list --radiolist --column=" " --column="installer" --column="espace" --column="commentaire" True "EXPERIMENTAL" "   " "$COM_STABLE" False "CUDA" "   " "$COM_AUTRE" False "TESTING" "   " "$COM_SECUREBOOT" --no-headers )
if [ "$(echo "$NVIDIA2" | cut -d'|' -f2)" = "EXPERIMENTAL" ]; then
    app_name="STABLE"
    data_loc="./extra/nvidia-experimental.sh"
    yad_progress
elif [ "$(echo "$NVIDIA2" | cut -d'|' -f2)" = "CUDA" ]; then
    app_name="REMOVE"
    data_loc="./extra/nvidia-cuda.sh"
    yad_progress
elif [ "$(echo "$NVIDIA2" | cut -d'|' -f2)" = "TESTING" ]; then
    app_name="REMOVE"
    data_loc="./extra/nvidia-testing-on-stable.sh"
    yad_progress
fi
}

function AMD () {
COM_VULKAN="Installer Mesa Kisak Fresh"
COM_KISAK="Installer AMD Vulkan"
AMD=$(yad --title="Gestionnaire AMD" --width 500 --height 170 --text-align="center" --list --radiolist --column=" " --column="installer" --column="espace" --column="commentaire" True "AMD_VULKAN" "   " "$COM_VULKAN" False "MESA_KISAK_FRESH" "   " "$COM_KISAK" --no-headers)
if [ "$(echo "$AMD" | cut -d'|' -f2)" = "AMD_VULKAN" ]; then
    app_name="backport"
    data_loc="./data/amd-vulkan.sh"
    yad_progress
elif [ "$(echo "$AMD" | cut -d'|' -f2)" = "MESA_KISAK_FRESH" ]; then
    app_name="backport"
    data_loc="./data/mesa-kisak-fresh.sh"
    yad_progress
fi
}

function Utilitaire () {
COM_DEBGET="Installer deb-get (Debian Stable uniquement)"
COM_WINE="Installer wine-staging"
COM_PACSTALL="Installer pacstall"
COM_PPA="Utiliser l'outil d'ajout de PPA pour Debian"
COM_SID="Installer les repository de Sid (pin 10) pour Debian Testing"
Utilitaire=$(yad --title="Gestionnaire des app utilitaires" --width 500 --height 170 --text-align="center" --list --radiolist --column=" " --column="installer" --column="espace" --column="commentaire" True "DEB-GET" "   " "$COM_DEBGET" False "WINE" "   " "$COM_WINE" False "PACSTALL" "   " "$COM_PACSTALL" False "PPA" "   " "$COM_PPA" False "SID" "   " "$COM_SID" --no-headers)
if [ "$(echo "$Utilitaire" | cut -d'|' -f2)" = "DEB-GET" ]; then
    app_name="deb-get"
    data_loc="./data/deb-get.sh"
    yad_progress
elif [ "$(echo "$Utilitaire" | cut -d'|' -f2)" = "WINE" ]; then
    app_name="backport"
    data_loc="./data/wine-staging.sh"
    yad_progress
elif [ "$(echo "$Utilitaire" | cut -d'|' -f2)" = "PACSTALL" ]; then
    app_name="PACSTALL"
    data_loc="./data/pacstall.sh"
    yad_progress
elif [ "$(echo "$Utilitaire" | cut -d'|' -f2)" = "PPA" ]; then
    app_name="backport"
    data_loc="./data/add-ppa-debian.sh"
    yad_progress
elif [ "$(echo "$Utilitaire" | cut -d'|' -f2)" = "SID" ]; then
    app_name="SID"
    data_loc="./data/install-sid.sh"
    yad_progress
fi
}

function menu() {
export -f ferme_yad
export -f NVIDIA
export -f AMD
export -f Utilitaire
export -f yad_progress
export -f NVIDIA2

CG=$(yad --title="Driver installer" --width 500 --height 170 --text-align="center" \
 --form \
 --field "Gesiton des pilotes Nvidia:btn" "bash -c NVIDIA" \
 --field "Gesiton des pilotes AMD:btn" "bash -c AMD" \
 --field "Gestion des programmes utilitaires:btn" "bash -c Utilitaire" \
 "echo 'NVIDIA'" "echo 'AMD'" "echo 'Utilitaire'"
 )
}
