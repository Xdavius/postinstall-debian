#!/bin/bash
password=$(zenity --title "password" --text="entrez votre mot de passe root" --entry --hide-text)
chmod +x *.sh
echo $password | sudo -S "apt install zenity"
CG=$(zenity --list  --title "Driver installer" --radiolist  --column "ID" --column="Name" 1 NVIDIA 2 AMD 3 Utilitaire)
if [ "$CG" = "NVIDIA" ]; then
    NVIDIA=$(zenity --list  --title "NVIDIA" --radiolist  --column "ID" --column="Name" 1 STABLE 2 TESTING 3 REMOVE)
elif [ "$CG" = "AMD" ]; then
    AMD=$(zenity --list  --title "AMD" --radiolist  --column "ID" --column="Name" 1 AMD_VULKAN 2 MESA_KISAK_FRESH)
elif [ "$CG" = "Utilitaire" ]; then
    Utilitaire=$(zenity --list  --title "UTILITAIRE" --radiolist  --column "ID" --column="Name" 1 DEB-GET 2 WINE 3 SECUREBOOT)
else
exit
fi
if [ "$NVIDIA" = "STABLE" ]; then
    echo $password | sudo -S "./nvidia-stable.sh"
elif [ "$NVIDIA" = "TESTING" ]; then
    echo $password | sudo -S "./nvidia-testing.sh"
elif [ "$NVIDIA" = "REMOVE" ]; then
    echo $password | sudo -S "./nvidia-rollback.sh"
else
exit
fi
if [ "$AMD" = "AMD_VULKAN" ]; then
    echo $password | sudo -S "./amd_vulkan.sh"
elif [ "$AMD" = "MESA_KISAK_FRESH" ]; then
    echo $password | sudo -S "./mesa-kisak-fresh.sh"
else
exit
fi
if [ "$Utilitaire" = "DEB-GET" ]; then
    echo $password | sudo -S "./deb-get.sh"
elif [ "$Utilitaire" = "WINE" ]; then
    echo $password | sudo -S "./wine-staging.sh"
elif [ "$Utilitaire" = "SECUREBOOT" ]; then
    echo $password | sudo -S "./secureboot.sh"
else
exit
fi
