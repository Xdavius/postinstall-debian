#!/bin/bash
function logo () {
logo="./source/logo.png"
}

#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCTIONS POUR LANCER LES INSTALLATIONS ET LES CHARGEMENTS
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
ferme_yad
$data_loc | while read -r line ;
    do
    logo2="./source/logo.png"
    export logo2
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
        sleep 2
        yad --center --window-icon="$logo2" --width 300 --height 170 --title="Installation terminée !" --text-align="center" --text="
        
        Les informations complémentaires d'installation sont accessibles dans /var/log/root.auto-update.txt
        
        N'OUBLIEZ PAS DE REDÉMARRER L'ORDINATEUR !!" --button="OK:bash -c menu"
        fi
    done | yad --center --window-icon=/tmp/logo.png --progress --percentage=$counter --title "installation de $app_name" --progress-text="installation en cours " --width 500 --height 200 --no-buttons --enable-log --log-expanded
}

function ferme_yad () { PidYad=$(pgrep yad); kill $PidYad;}
#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCTIONS POUR BOUTTONS DU MENU nvidia
#
#--------------------------------------------------------------------------------------------------------------------------------------------------

function nvidia_stable () {
    app_name="NVIDIA LTS STABLE"
    data_loc="./data/nvidia-stable.sh"
    yad_progress
}

function nvidia_remove () {
    app_name="NVIDIA REMOVE"
    data_loc="./data/nvidia-rollback.sh"
    yad_progress
}

#--------------------------------------------------------------------------------------------------------------------------------------------------
#
#                   FONCTIONS POUR BOUTTONS DU MENU nvidia2
#
#--------------------------------------------------------------------------------------------------------------------------------------------------

function nvidia_exp () {
    app_name="NVIDIA-EXPERIMENTAL"
    data_loc="./extra/nvidia-experimental.sh"
    yad_progress
}
function nvidia_cuda () {
    app_name="NVIDIA DRIVER (LATEST)"
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
#                   FONCTIONS POUR BOUTTONS DU MENU amd
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
#                   FONCTIONS POUR BOUTTONS DU MENU UTILITAIRES
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
function discord () {
    app_name="DISCORD"
    data_loc="./data/discord.sh"
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
    app_name="PACSTALL"
    data_loc="./data/pacstall.sh"
    yad_progress
}
function backports () {
    app_name="STABLE BACKPORTS"
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
    app_name="DEPOT SID (PIN 10)"
    data_loc="./data/install-sid.sh"
    yad_progress
}
function envycontrol () {
    app_name="EVYCONTROL"
    data_loc="./extra/envycontrol.sh"
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
    var1="bash -c $localdir/SECUREBOOT/install-sb.sh"
    konsole -- -e $var1
    menu
elif [[ -f /usr/bin/gnome-terminal ]] ; then
    ferme_yad
    app_name="INSTALLATION DE SECUREBOOT"
    var1="bash -c $localdir/SECUREBOOT/install-sb.sh"
    gnome-terminal -x $var1
    menu
else
yad --center --window-icon="$logo" --width 300 --height 170 --title="Désolé..." --text-align="center" --text="La GUI ne supporte pas vôtre DE. Utilisez la version TUI." --button="OK:bash -c menu"
fi
}

function nvidia() {
logo
ferme_yad
COM_STABLE="Installer driver Nvidia Stable fournit par Debian, ainsi que CUDA (Recommandé)"
COM_AUTRE="Autres drivers Nvidia (Pour utilisateurs Expérimentés !!)"
nvidia=$(yad --center --window-icon="$logo" --title="Gestionnaire NVIDIA" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="Quitter:1" \
 --form \
 --field "Installer le driver Nvidia de Debian (RECOMMANDÉ) !./source/debian_logo.png! $COM_STABLE:fbtn" "bash -c nvidia_stable" \
 --field "Options avancée (EXPERT) !./source/package_debian.png! $COM_AUTRE:fbtn" "bash -c nvidia2" \
)
}

function nvidia2() {
logo
ferme_yad
COM_EXPERIMENTAL="Installer driver Nvidia Experimental (Necessite l'activation de Sid pin 10)"
COM_CUDA="Installer le dépôt Officiel Nvidia et le dernier driver Nvidia Officiel ainsi que le dernier CUDA"
COM_TESTING="Installer driver Nvidia de Testing en pin 10 (Pour Debian Stable)"
COM_REMOVE="Supprimer le driver Nvidia Propriétaire et nettoyer le système"
nvidia2=$(yad --center --window-icon="$logo" --title="Gestionnaire NVIDIA" --width 500 --height 170 --text-align="center" --button="Retour:bash -c nvidia" --button="Quitter:1" \
 --form \
 --field "Installer le driver (DERNIERE VERSION) + dépôt Nvidia !./source/nvidia_logo.png! $COM_CUDA:fbtn" "bash -c nvidia_cuda" \
 --field "Purger les drivers Nvidia !./source/package-delete.png! $COM_REMOVE:fbtn" "bash -c nvidia_remove"\
)
}

function amd () {
logo
ferme_yad
COM_VULKAN="Installer Vulkan pour les cartes AMD ou Intel"
COM_KISAK="Installer le dépôt Mesa Kisak Fresh pour être sur le dernier Mesa Stable"
COM_ROCM="Installer Rocm OpenCL et Hip (DavinciResolve, Blender,InvokeAI etc...)"
amd=$(yad --center --window-icon="$logo" --title="Gestionnaire AMD" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="Quitter:1" \
 --form \
 --field "Installer le driver Vulkan !./source/debian_logo.png! $COM_VULKAN:fbtn" "bash -c amd_vulkan" \
 --field "Installer Mesa-Kisak Fresh !./source/package_debian.png! $COM_KISAK:fbtn" "bash -c amd_kisak" \
 --field "Installer AMD ROCm OpenCL et HIP !./source/amd_logo.png! $COM_ROCM:fbtn" "bash -c amd_rocm"\
)
}

function utilitaire () {
logo
ferme_yad
utilitaire=$(yad --center --window-icon="$logo" --title="Utilitaires" --width 500 --height 170 --text-align="center" --button="Retour:bash -c menu" --button="Quitter:1" \
 --form \
 --field " Applications Gaming !./source/joystick.png!:fbtn" "bash -c gaming" \
 --field " Magasins d'Applications !./source/software_debian.png!:fbtn" "bash -c software_manager" \
 --field " Configuration Système !./source/debian_logo.png!:fbtn" "bash -c system" \
)
}

function software_manager () {
logo
ferme_yad
COM_Deb_get="Installer deb-get (Debian Stable uniquement)"
COM_Pacstall="Installer pacstall"
software_manager=$(yad --center --window-icon="$logo" --title="Gestionnaires de Paquets" --width 500 --height 170 --text-align="center" --button="Retour:bash -c utilitaire" --button="Quitter:1" \
 --form \
 --field " Installer Deb-get !./source/software_debian.png! $COM_Deb_get:fbtn" "bash -c deb_get" \
 --field " Installer Pacstall !./source/software_debian.png! $COM_Pacstall:fbtn" "bash -c pacstall" \
)
}

function gaming () {
logo
ferme_yad
COM_Steam="Installer Steam et toutes ses dépendances"
COM_Wine="Installer wine-staging et son dépôt officiel"
COM_Lutris="Installer Lutris et son dépôt officiel de OBS"
COM_Discord="Installer Discord et le dépôt Javinator9889"
gaming=$(yad --center --window-icon="$logo" --title="Applications Gaming" --width 500 --height 170 --text-align="center" --button="Retour:bash -c utilitaire" --button="Quitter:1" \
 --form \
 --field " Installer Discord !./source/discord.png! $COM_Discord:fbtn" "bash -c discord" \
 --field " Installer Steam !./source/steam.png! $COM_Steam:fbtn" "bash -c steam" \
 --field " Installer Lutris-latest !./source/lutris.png! $COM_Lutris:fbtn" "bash -c lutris" \
 --field " Installer Wine-Staging !./source/wine.png! $COM_Wine:fbtn" "bash -c wine" \

)
}

function system () {
logo
ferme_yad
COM_Backports="Installer le dépôt Backports pour debian Stable"
COM_Linux_Firmware_GIT="Mettre à jour les firmwares Linux pour le support du matériel dernière génération"
COM_Envycontrol="Installer Envycontrol pour les Laptop Optimus"

system=$(yad --center --window-icon="$logo" --title="Configuration du Système" --width 500 --height 170 --text-align="center" --button="Retour:bash -c utilitaire" --button="Quitter:1" \
 --form \
 --field " Ajouter le dépôt Backports !./source/debian_logo.png! $COM_Backports:fbtn" "bash -c backports" \
 --field " Installer Linux-Firmware-GIT !./source/package_debian.png! $COM_Linux_Firmware_GIT:fbtn" "bash -c update-firmware"\
 --field " Installer Envycontrol !./source/package_debian.png! $COM_Envycontrol:fbtn" "bash -c envycontrol"\
)
}
