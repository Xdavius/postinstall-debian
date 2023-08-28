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
        ferme_yad
        yad --window-icon="$logo" --width 300 --height 170 --title="FINI" --text-align="center" --text="Installation terminée" -button="OK:0"
        fi
        #if [ "${line}" = "END" ]; then
        #fi
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
    app_name="EXPERIMENTAL"
    data_loc="./extra/nvidia-experimental.sh"
    yad_progress
}
function nvidia_cuda () {
    app_name="CUDA"
    data_loc="./extra/nvidia-cuda.sh"
    yad_progress
}
function nvidia_test () {
    app_name="TESTING"
    data_loc="./extra/nvidia-testing-on-stable.sh"
    yad_progress
}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR BOUTTONS DU MENU amd
#
#--------------------------------------------------------------------------------------------------------------------------------------------------


function amd_vulkan () {
    app_name="backport"
    data_loc="./data/amd-vulkan.sh"
    yad_progress
}
function amd_kisak () {
    app_name="backport"
    data_loc="./data/mesa-kisak-fresh.sh"
    yad_progress
}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR BOUTTONS DU MENU UTILITAIRES
#
#--------------------------------------------------------------------------------------------------------------------------------------------------
function deb_get () {
    app_name="deb-get"
    data_loc="./data/deb-get.sh"
    yad_progress
}
function wine () {
    app_name="backport"
    data_loc="./data/wine-staging.sh"
    yad_progress
}
function pacstall () {
    app_name="pacstall"
    data_loc="./data/pacstall.sh"
    yad_progress
}
function backport () {
    app_name="backport"
    data_loc="./data/add-ppa-debian.sh"
    yad_progress
}
function sid () {
    app_name="sid"
    data_loc="./data/install-sid.sh"
    yad_progress
}

#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   SOUS MENU POUR ACCEDER A L'EXECUTION DES SCTIPTS
#
#--------------------------------------------------------------------------------------------------------------------------------------------------
function nvidia() {
logo
ferme_yad
COM_STABLE="Installer driver Nvidia Stable (Recommandé)"
COM_AUTRE="Autres drivers Nvidia (Pour utilisateurs Expérimentés !!)"
COM_SECUREBOOT="Configurer Secureboot pour Nvidia"
COM_REMOVE="Supprimer driver Nvidia"
nvidia=$(yad --window-icon="$logo" --title="Gestionnaire nvidia" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="OK:0" --button="Cancel:1" \
 --form \
 --field "Stable ! ! $COM_STABLE:fbtn" "bash -c nvidia_stable" \
 --field "Autre ! ! $COM_AUTRE:fbtn" "bash -c nvidia_autre" \
 #--field "Secureboot ! ! $COM_SECUREBOOT:fbtn" "bash -c nvidia_secureboot" \
 --field "Remove ! ! $COM_REMOVE:fbtn" "bash -c nvidia_remove" \
 )
}

function nvidia2 () {
logo
COM_EXPERIMENTAL="Installer driver Nvidia Experimental"
COM_CUDA="Installer driver depuis le depot Nvidia Cuda (Compatible Secureboot)"
COM_TESTING="nstaller driver Nvidia de Testing en pin 10 (Pour Debian Stable)"
nvidia2=$(yad --window-icon="$logo" --title="Gestionnaire nvidia" --width 500 --height 170 --text-align="center" --button="Retour:bash -c nvidia" --button="OK:0" --button="Cancel:1" \
 --form \
 --field "Experimental ! ! $COM_EXPERIMENTAL:fbtn" "bash -c nvidia_exp" \
 --field "Cuda ! ! $COM_CUDA:fbtn" "bash -c nvidia_cuda" \
 --field "Testing ! ! $COM_TESTING:fbtn" "bash -c nvidia_test" \
 )
}

function amd () {
logo
ferme_yad
COM_VULKAN="Installer Mesa Kisak Fresh"
COM_KISAK="Installer amd Vulkan"
amd=$(yad --window-icon="$logo" --title="Gestionnaire amd" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="OK:0" --button="Cancel:1" \
 --form \
 --field "Vulkan ! ! $COM_VULKAN:fbtn" "bash -c amd_vulkan" \
 --field "Mesa Kisak ! ! $COM_KISAK:fbtn" "bash -c amd_kisak" \
 )
}

function utilitaire () {
logo
ferme_yad
COM_DEBGET="Installer deb-get (Debian Stable uniquement)"
COM_wine="Installer wine-staging"
COM_pacstall="Installer pacstall"
COM_PPA="Utiliser l'outil d'ajout de PPA pour Debian"
COM_sid="Installer les repository de Sid (pin 10) pour Debian Testing"
utilitaire=$(yad --window-icon="$logo" --title="Gestionnaire des app utilitaires" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="OK:0" --button="Cancel:1" \
 --form \
 --field "Deb-get ! ! $COM_DEBGET:fbtn" "bash -c deb_get" \
 --field "Wine ! ! $COM_wine:fbtn" "bash -c wine" \
 --field "Pacstall ! ! $CCOM_pacstall:fbtn" "bash -c pacstall" \
 --field "PPA ! ! $COM_PPA:fbtn" "bash -c backport" \
 --field "sid ! ! $COM_sid:fbtn" "bash -c sid" \
 )
}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCIOTNS POUR MENU PRINCIPALE
#
#--------------------------------------------------------------------------------------------------------------------------------------------------
function menu() {
export -f ferme_yad
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
export -f deb_get
export -f wine
export -f pacstall
export -f backport
export -f sid
export count

if [[ $count == 1 ]] ; then
ferme_yad
fi
count=1
logo
CG=$(yad --window-icon="$logo" --title="Driver installer" --width 500 --height 140 --text-align="center" --no-buttons \
 --form \
 --field "Gesiton des pilotes Nvidia:fbtn" "bash -c nvidia" \
 --field "Gesiton des pilotes amd:fbtn" "bash -c amd" \
 --field "Gestion des programmes utilitaires:fbtn" "bash -c utilitaire" \
 "echo 'nvidia'" "echo 'amd'" "echo 'utilitaire'"
 )
}
menu
