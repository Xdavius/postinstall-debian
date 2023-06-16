# postinstall-debian

Scripts to quickly setting up Debian for gaming !




Décompressez le zip, ouvrez un terminal puis rendre exécutable tous les scripts :

    sudo chmod +x *.sh
  
Vous devez exécuter les script depuis un terminal en root :
Pour passer root : 

    sudo -i (ou su) (ou en sudo)

pour exécuter un script :

    ./nom_du_script.sh

# Contenu des scripts :

- mesa-kisak-fresh : Installer le dernier Mesa pour AMD/INTEL
- nvidia-base : Installer le driver Nvidia officiel Debian
- nvidia-upgrade : Installer le dépôt officiel Nvidia pour debian pour avoir le dernier driver Stable officiel
- wine-staging : Installer la dernière version de wine ainsi que toutes les dépendances nécessaire
- deb-get : Installer deb-get pour installer facilement des logiciels .deb externe aux dépots Debian (heroic, discord, lutris (github version), et d'autres)
