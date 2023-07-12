# postinstall-debian

## ATTENTION : Seul postinstall-debian-tui est fonctionnel, postinstall-gui est toujours en travaux, ne pas l'utiliser encore !!!!

Configurer Facilement sa Debian !!!

Décompressez le zip, ouvrez un terminal puis rendre exécutable l'application :

    sudo chmod +x postinstall-debian-tui
  
Vous devez exécuter l'application depuis un terminal en root :
Pour passer root : 

    sudo -i (ou su -)

pour exécuter l'application :

    ./postinstall-debian-tui

Alternativement, vous pouvez aussi lancer en sudo :
    
    sudo postinstalldebian-tui

# Contenu des scripts :

- secureboot : Crée la clé MOK, configure l'auto-signature pour DKMS, et l'enroll (Indispensable pour Nvidia avec Secureboot)
- nvidia-stable : Installer le driver Nvidia officiel Debian Stable
- nvidia-testing : Installer le dépôt EXPERIMENTAL pour debian pour avoir le dernier driver EXPERIMENTAL
- nvidia-rollback : Desinstaller nvidia-base-upgrade et/ou nvidia-testing
  
- mesa-kisak-fresh : Installer le dernier Mesa Stable pour AMD/INTEL
- amd-vulkan : Installe Vulkan pour les GPU AMD/INTEL

- wine-staging : Installer la dernière version de wine ainsi que toutes les dépendances nécessaire
- deb-get : Installer deb-get pour installer facilement des logiciels .deb externe aux dépots Debian (heroic, discord, lutris (github version), et d'autres)

# REMERCIEMENTS :

Merci à Alternatux, Bazogueur Tobal, cptcavern, Pandatomikk, christophe et la Team GLF Pour leur participations et tests sur ce projet !
