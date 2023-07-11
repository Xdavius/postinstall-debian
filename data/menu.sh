#!/bin/bash
# foncitons
function ferme_yad () { PidYad=$(pgrep yad); kill -s SIGUSR1 "$PidYad";}

function NVIDIA () {
    NVIDIA=$(yad --title="Gestionnaire NVIDIA" --width 500 --height 170 --text-align="center" --list --radiolist --column=" " --column="installer" --column="commentaire" True "STABLE" "Installation des pilotes présent dans le dépot Debian stable" False "TESTING" "Installation des pilotes présent dans le dépot Debian testing" False "REMOVE" "Suppression des pilotes Nvidia et réactivation de Nouveau" )
if [ "$(echo "$NVIDIA" | cut -d'|' -f2)" = "STABLE" ]; then
    echo $password | sudo -S "./data/nvidia-stable.sh" 
elif [ "$(echo "$NVIDIA" | cut -d'|' -f2)" = "TESTING" ]; then
    echo $password | sudo -S "./data/nvidia-testing.sh"
elif [ "$(echo "$NVIDIA" | cut -d'|' -f2)" = "REMOVE" ]; then
    echo $password | sudo -S "./data/nvidia-rollback.sh"
fi
}
function AMD () {
    AMD=$(yad --title="Gestionnaire AMD" --width 500 --height 170 --text-align="center" --list --radiolist --column=" " --column="installer" --column="commentaire" True "AMD_VULKAN" "Installation des pilotes AMD Vulkan" False "MESA_KISAK_FRESH" "Installation des pilotes présent dans le dépot KISAK" )
if [ "$(echo "$AMD" | cut -d'|' -f2)" = "AMD_VULKAN" ]; then
    echo $password | sudo -S "./data/amd-vulkan.sh"
elif [ "$(echo "$AMD" | cut -d'|' -f2)" = "MESA_KISAK_FRESH" ]; then
    echo $password | sudo -S "./data/mesa-kisak-fresh.sh"
fi
}
function Utilitaire () {
    Utilitaire=$(yad --title="Gestionnaire des app utilitaires" --width 500 --height 170 --text-align="center" --list --radiolist --column=" " --column="installer" --column="commentaire" True "DEB-GET" "" False "WINE" "" False "SECUREBOOT" "" )
if [ "$(echo "$Utilitaire" | cut -d'|' -f2)" = "DEB-GET" ]; then
    echo $password | sudo -S "./data/deb-get.sh"
elif [ "$(echo "$Utilitaire" | cut -d'|' -f2)" = "WINE" ]; then
    echo $password | sudo -S "./data/wine-staging.sh"
elif [ "$(echo "$Utilitaire" | cut -d'|' -f2)" = "SECUREBOOT" ]; then
    echo $password | sudo -S apt install neofetch -y
fi
}

export -f ferme_yad
export -f NVIDIA
export -f AMD
export -f Utilitaire

CG=$(yad --title="Driver installer" --width 500 --height 170 --text-align="center" \
 --form \
 --field "Gesiton des pilotes Nvidia:btn" "bash -c NVIDIA" \
 --field "Gesiton des pilotes AMD:btn" "bash -c AMD" \
 --field "Gestion des programmes utilitaires:btn" "bash -c Utilitaire" \
 "echo 'NVIDIA'" "echo 'AMD'" "echo 'Utilitaire'"
 )
