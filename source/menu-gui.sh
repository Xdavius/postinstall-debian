#!/bin/bash
# FONCTIONS
function logo () {
logo="./source/logo.png"
}

#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR LANCER LES INSTALLATIONS ET LES CHARGEMENTS
#
#--------------------------------------------------------------------------------------------------------------------------------------------------

function yad_progress () {

# Variable pour stocker le nombre de lignes dans temp_script.sh
#max_line=0

# Compter le nombre de lignes dans temp_script.sh
#max_line=$(wc -l .$data_loc | cut -d " " -f 1)

# Calculer le pourcentage correspondant à une seule ligne avec bc
#one_line_percent=$(echo "scale=4; 100 / $max_line" | bc)

#     max_line=$(wc -l $data_loc | cut -d " " -f 1)
#     one_line_percent=$(echo "scale=4; 100 / $max_line" | bc -l)
#     counter=$(echo "$counter + $one_line_percent" | bc -l)
#     counter=$(echo $counter | cut -d "." -f 1)

# Compteur pour afficher le chiffre dans le sous-processus
counter=0

$data_loc | while read -r line ;
    do
    echo "# ${line}"
    max_line=$(wc -l $data_loc | cut -d " " -f 1)
    max_line2=$(echo "$max_line / 2" | bc -l)
    one_line_percent=$(echo "scale=4; 100 / $max_line2" | bc -l)
    counter=$(echo "$counter + $one_line_percent" | bc -l)
    counter=$(echo $counter | cut -d "." -f 1)
    echo $counter ;
        if [ "${line}" = "Job done" ]; then
        counter="100"
        echo $counter
        sleep 5
        yad --window-icon="$logo" --width 300 --height 170 --title="FINI" --text-align="center" --text="Installation terminée" --button="OK:bash -c menu"
        fi
    done | yad --progress --percentage=$counter --title "installation de $app_name" --progress-text="installation en cours " --width 500 --height 200 --no-buttons --enable-log --log-expanded
}

function ferme_yad () { PidYad=$(pgrep yad); kill $PidYad;}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR BOUTTONS DU MENU nvidia
#
#--------------------------------------------------------------------------------------------------------------------------------------------------

function nvidia_stable () {
    app_name="STABLE"
    data_loc="./data/nvidia-stable.sh"
    yad_progress
}
function nvidia_autre() {
    nvidia2
}
function nvidia_remove () {
    app_name="REMOVE"
    data_loc="./data/nvidia-rollback.sh"
    yad_progress
}
function nvidia_secureboot () {
    app_name="SECUREBOOT"
    data_loc="./data/secureboot.sh"
    yad_progress
}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR BOUTTONS DU MENU nvidia2
#
#--------------------------------------------------------------------------------------------------------------------------------------------------

function nvidia_exp () {
    app_name="NVIDIA-EXPERIMENTAL"
    data_loc="./extra/nvidia-experimental.sh"
    yad_progress
}
function nvidia_cuda () {
    app_name="NVIDIA-CUDA"
    data_loc="./extra/nvidia-cuda.sh"
    yad_progress
}
function nvidia_test () {
    app_name="NVIDIA-TESTING"
    data_loc="./extra/nvidia-testing-on-stable.sh"
    yad_progress
}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR BOUTTONS DU MENU amd
#
#--------------------------------------------------------------------------------------------------------------------------------------------------


function amd_vulkan () {
    app_name="AMD-VULKAN"
    data_loc="./data/amd-vulkan.sh"
    yad_progress
}
function amd_kisak () {
    app_name="MESA-KISAK"
    data_loc="./data/mesa-kisak-fresh.sh"
    yad_progress
}
function amd_rocm () {
    app_name="ROCM OPENCL & HIP"
    data_loc="./data/rocm.sh"
    yad_progress
}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR BOUTTONS DU MENU UTILITAIRES
#
#--------------------------------------------------------------------------------------------------------------------------------------------------
function deb_get () {
    app_name="DEB-GET"
    data_loc="./data/deb-get.sh"
    yad_progress
}
function steam () {
    app_name="STEAM"
    data_loc="./data/steam.sh"
    yad_progress
}
function wine () {
    app_name="WINE-STAGING"
    data_loc="./data/wine-staging.sh"
    yad_progress
}
function lutris () {
    app_name="LUTRIS-LATEST (Repos OBS)"
    data_loc="./data/lutris-latest.sh"
    yad_progress
}
function pacstall () {
    app_name="pacstall"
    data_loc="./data/pacstall.sh"
    yad_progress
}
function backports () {
    app_name="Stable Backports"
    data_loc="./extra/backports.sh"
    yad_progress
}
function update-firmware () {
    app_name="LINUX-FIRMWARE-GIT"
    data_loc="./extra/update-firmware.sh"
    yad_progress
}
function ppa () {
    app_name="ADD-PPA"
    data_loc="./data/add-ppa-debian.sh"
    yad_progress
}
function sid () {
    app_name="Ajouter dépôt SID (PIN 10)"
    data_loc="./data/install-sid.sh"
    yad_progress
}

#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   SOUS MENU POUR ACCEDER A L'EXECUTION DES SCTIPTS
#
#--------------------------------------------------------------------------------------------------------------------------------------------------
function secureboot () {
if [[ -f /usr/bin/konsole ]] ; then
    ferme_yad
    app_name="INSTALLATION DE SECUREBOOT"
    var1="bash -c $localdir/SECUREBOOT/install-sb-gui.sh"
    konsole -- -e $var1
    menu
elif [[ -f /usr/bin/gnome-terminal ]] ; then
    ferme_yad
    app_name="INSTALLATION DE SECUREBOOT"
    var1="bash -c $localdir/SECUREBOOT/install-sb-gui.sh"
    gnome-terminal -x $var1
    menu
else
yad --window-icon="$logo" --width 300 --height 170 --title="Désolé..." --text-align="center" --text="La GUI ne supporte que KDE. Utilisez la version TUI." --button="OK:bash -c menu"
fi
}

function nvidia() {
logo
ferme_yad
COM_STABLE="Installer driver Nvidia Stable (Recommandé)"
COM_AUTRE="Autres drivers Nvidia (Pour utilisateurs Expérimentés !!)"
COM_SECUREBOOT="Configurer Secureboot pour Nvidia"
COM_REMOVE="Supprimer driver Nvidia"
nvidia=$(yad --window-icon="$logo" --title="Gestionnaire nvidia" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="Quitter:1" \
 --form \
 --field "Installer le driver Nvidia + Cuda de Debian (RECOMMANDÉ) ! ! $COM_STABLE:fbtn" "bash -c nvidia_stable" \
 --field "Autres options ! ! $COM_AUTRE:fbtn" "bash -c nvidia_autre" \
 --field "Supprimer le driver Nvidia ! ! $COM_REMOVE:fbtn" "bash -c nvidia_remove"\
)
}

function nvidia2 () {
logo
ferme_yad
COM_EXPERIMENTAL="Installer driver Nvidia Experimental (Necessite l'activation de Sid pin 10)"
COM_CUDA="Installer le dépôt Officiel Nvidia et le dernier driver Nvidia Officiel"
COM_TESTING="Installer driver Nvidia de Testing en pin 10 (Pour Debian Stable)"
nvidia2=$(yad --window-icon="$logo" --title="Gestionnaire nvidia" --width 500 --height 170 --text-align="center" --button="Retour:bash -c nvidia" --button="Quitter:1" \
 --form \
 --field "Installer le driver Officiel Nvidia (Debian stable ou plus)! ! $COM_CUDA:fbtn" "bash -c nvidia_cuda" \
 #--field "Nvidia Experimental (Debian Sid)! ! $COM_EXPERIMENTAL:fbtn" "bash -c nvidia_exp" \
 #--field "Nvidia Testing (Debian Stable)! ! $COM_TESTING:fbtn" "bash -c nvidia_test"\
)
}

function amd () {
logo
ferme_yad
COM_VULKAN="Installer Vulkan pour les cartes AMD ou Intel"
COM_KISAK="Installer le dépôt Mesa Kisak Fresh pour être sur le dernier Mesa Stable"
COM_ROCM="Installer Rocm OpenCL et Hip (DavinciResolve, Blender,InvokeAI etc...)"
amd=$(yad --window-icon="$logo" --title="Gestionnaire amd" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="Quitter:1" \
 --form \
 --field "Installer le driver Vulkan ! ! $COM_VULKAN:fbtn" "bash -c amd_vulkan" \
 --field "Installer Mesa-Kisak Fresh ! ! $COM_KISAK:fbtn" "bash -c amd_kisak" \
 --field "Installer AMD ROCm OpenCL et HIP ! ! $COM_ROCM:fbtn" "bash -c amd_rocm"\
)
}

function utilitaire () {
logo
ferme_yad
COM_Deb_get="Installer deb-get (Debian Stable uniquement)"
COM_Steam="Installer Steam et toutes ses dépendances"
COM_Wine="Installer wine-staging et son dépôt officiel"
COM_Lutris="Installer Lutris et son dépôt officiel de OBS"
COM_Pacstall="Installer pacstall"
COM_Backports="Installer le dépôt Backports pour debian Stable"
COM_Linux_Firmware_GIT="Mettre à jour les firmwares Linux pour le support du matériel dernière génération"
COM_PPA="Utiliser l'outil d'ajout de PPA pour Debian"
COM_sid="Installer les repository de Sid (pin 10) pour Debian Testing"
utilitaire=$(yad --window-icon="$logo" --title="Gestionnaire des app utilitaires" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="Quitter:1" \
 --form \
 --field "Installer Steam ! ! $COM_Steam:fbtn" "bash -c steam" \
 --field "Installer Wine-Staging ! ! $COM_Wine:fbtn" "bash -c wine" \
 --field "Installer Lutris-latest ! ! $COM_Lutris:fbtn" "bash -c lutris" \
 --field "Installer Deb-get (Debian Stable) ! ! $COM_Deb_get:fbtn" "bash -c deb_get" \
 --field "Installer Pacstall ! ! $COM_Pacstall:fbtn" "bash -c pacstall" \
 --field "Activer le dépôt Stable Backports ! ! $COM_Backports:fbtn" "bash -c backports" \
 --field "Installer Linux-Firmware-GIT ! ! $COM_Linux_Firmware_GIT:fbtn" "bash -c update-firmware" \
 --field "Ajouter le Dépot SID pour Testing (pin 10) ! ! $COM_sid:fbtn" "bash -c sid"\
)
}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR MENU PRINCIPALE
#
#--------------------------------------------------------------------------------------------------------------------------------------------------
function menu() {
export -f ferme_yad
export -f secureboot
export -f nvidia
export -f amd
export -f utilitaire
export -f yad_progress
export -f nvidia2
export -f menu
export -f logo
export -f nvidia_stable
export -f nvidia_autre
export -f nvidia_remove
export -f nvidia_secureboot
export -f nvidia_exp
export -f nvidia_cuda
export -f nvidia_test
export -f amd_vulkan
export -f amd_kisak
export -f amd_rocm
export -f deb_get
export -f steam
export -f wine
export -f lutris
export -f pacstall
export -f backports
export -f update-firmware
export -f ppa
export -f sid
export count

if [[ $count == 1 ]] ; then
ferme_yad
fi
count=1
localdir=$(pwd)
echo $localdir
export localdir
logo
CG=$(yad --window-icon="$logo" --title="POSTINSTALL FOR DEBIAN" --width 500 --height 140 --text-align="center" --no-buttons \
 --form \
 --field "Configurer SECUREBOOT:fbtn" "bash -c secureboot" \
 --field "Gestion des pilotes NVIDIA:fbtn" "bash -c nvidia" \
 --field "Gestion des pilotes AMD:fbtn" "bash -c amd" \
 --field "Applications et Utilitaires:fbtn" "bash -c utilitaire"\
)
}
menu
