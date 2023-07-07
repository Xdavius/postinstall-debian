# postinstall-debian

Scripts to quickly setting up Debian for gaming !

## via le GUI
Décompressez le zip, allez ouvrez un terminal puis rendre exécutable le script ;

    sudo chmod +x postinstall-debian-gui.sh
    
Installez zenity s'il n'est pas déjà présent : ( présent par défaut dans GNOME et s'installe automatiquement avec steam)

        sudo apt install zenity -y

Exécutez le script depuis le terminal ou en cliquant dessus dans le gestionnaire de fichiers

        ./postinstall-debian-gui.sh

## via la CLI
Décompressez le zip, allez dans data, ouvrez un terminal puis rendre exécutable tous les scripts :

    sudo chmod +x *.sh
  
Vous devez exécuter les script depuis un terminal en root :
Pour passer root : 

    sudo -i (ou su -)

pour exécuter un script :

    ./nom_du_script.sh

# Contenu des scripts :

- secureboot : Crée la clé MOK, configure l'auto-signature pour DKMS, et l'enroll (Indispensable pour Nvidia avec Secureboot)
- nvidia-stable : Installer le driver Nvidia officiel Debian Stable
- nvidia-testing : Installer le dépôt EXPERIMENTAL pour debian pour avoir le dernier driver EXPERIMENTAL
- nvidia-rollback : Desinstaller nvidia-base-upgrade et/ou nvidia-testing
  
- mesa-kisak-fresh : Installer le dernier Mesa Stable pour AMD/INTEL
- amd-vulkan : Installe Vulkan pour les GPU AMD/INTEL

- wine-staging : Installer la dernière version de wine ainsi que toutes les dépendances nécessaire
- deb-get : Installer deb-get pour installer facilement des logiciels .deb externe aux dépots Debian (heroic, discord, lutris (github version), et d'autres)

# REMERCIELENTS :

Merci à Alternatux, Bazogueur Tobal, cptcavern, Pandatomikk et la Team GLF Pour leur participations et tests sur ce projet !
