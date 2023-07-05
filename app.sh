#!/bin/bash
password=$(zenity --title "Password" --text="Entrez votre mot de passe root" --password)
chmod +x *.sh
chkroot=$(echo $password | sudo -S whoami)
if [ "$password" = "" ]; then
exit
elif [ "$chkroot" != "root" ]; then
zenity --error --title "Wrong password" --text="Mauvais mot de passe"
exit
fi
CG=$(zenity --list  --title "Driver installer" --radiolist  --column "ID" --column="Name" 1 NVIDIA 2 AMD 3 Utilitaire)
if [ "$CG" = "NVIDIA" ]; then
    NVIDIA=$(zenity --list  --title "NVIDIA" --radiolist  --column "ID" --column="Name" 1 STABLE 2 TESTING 3 REMOVE)
elif [ "$CG" = "AMD" ]; then
    AMD=$(zenity --list  --title "AMD" --radiolist  --column "ID" --column="Name" 1 AMD_VULKAN 2 MESA_KISAK_FRESH)
elif [ "$CG" = "Utilitaire" ]; then
    Utilitaire=$(zenity --list  --title "UTILITAIRE" --radiolist  --column "ID" --column="Name" 1 DEB-GET 2 WINE 3 SECUREBOOT)
fi

if [ "$NVIDIA" = "STABLE" ]; then
    echo $password | sudo -S "./nvidia-stable.sh"
elif [ "$NVIDIA" = "TESTING" ]; then
    echo $password | sudo -S "./nvidia-testing.sh"
elif [ "$NVIDIA" = "REMOVE" ]; then
    echo $password | sudo -S "./nvidia-rollback.sh"
fi

if [ "$AMD" = "AMD_VULKAN" ]; then
    echo $password | sudo -S "./amd-vulkan.sh"
elif [ "$AMD" = "MESA_KISAK_FRESH" ]; then
    echo $password | sudo -S "./mesa-kisak-fresh.sh"
fi

if [ "$Utilitaire" = "DEB-GET" ]; then
    echo $password | sudo -S "./deb-get.sh"
elif [ "$Utilitaire" = "WINE" ]; then
    echo $password | sudo -S "./wine-staging.sh"
elif [ "$Utilitaire" = "SECUREBOOT" ]; then
    echo $password | sudo -S "./secureboot.sh"
fi
