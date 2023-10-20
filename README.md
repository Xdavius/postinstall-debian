# POSTINSTALL-DEBIAN - Configurer Facilement Debian !

Cet outil a été conçu pour être plus facilement utilisable avec les ISOs Lives de Debian et l'installateur graphique.
Les isos lives sont disponibles ici :

      https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/

Le mot de passe ROOT/SUDO des Isos live est : **live**

**L'interface GUI a été pensée pour fonctionner avec GNOME et KDE. Une compatibilié est en cours pour prendre en charge CINNAMON,
et à terme, un support complet pour Linux Mint Debian Edition.**


***Vidéos sur postinstall-debian :***

[**Un programme de post install debian en graphique ! by Davius**](https://www.youtube.com/watch?v=6h65fzd0yBE)

[**Installation Debian + Script post-installation feat Davius**](https://youtu.be/jQMO9XDORp0?si=EZZWUi24OyEwvwQ8)

## AVANT DE COMMENCER :


**Il est nécessaire d'avoir configuré SUDO pour utiliser la version GUI.**

SI VOUS AVEZ INSTALLÉ DEBIAN DEPUIS UNE **ISO LIVE**, SUDO EST DÉjÀ CONFIGURÉ !

   - Ouvrez un terminal puis copier coller cette commande :

         su - -c "usermod -aG sudo $(who | grep tty | cut -d " " -f 1)"

   - Entrez le mot de passe **ROOT (Super Utilisateur)** pour valider la commande puis **redémarrez la machine**.


## INSTALLATION


**UTILISATION AVEC INTERFACE GRAPHIQUE :**


L'interface graphique est optimisée pour GNOME et KDE uniquement.

   - Rendez-vous dans la section **"Releases"** puis télécharger le logiciel (**postinstall-debian-{VERSION}.zip**)

   - Décompressez le zip, puis double cliquez sur **"postinstall-debian-gui.run"**
   
***Ce logiciel dépend de YAD. Son installation s'effectue automatiquement de façon transparente.***
***L'activation du Multilib, Contrib et Non-free est effectuée au lancement de la GUI pour améliorer l'expérience utilisateur. Si vous ne le souhaitez pas, utilisez la TUI***

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



**POUR CEUX SOUHAITANT UTILISER L'INTERFACE TUI :**

  
Vous devez exécuter l'application depuis un terminal en root :

- Pour passer root : 

       sudo -i (ou su -)

- Pour exécuter l'application :

       bash postinstall-debian-tui

- Alternativement, vous pouvez aussi lancer en sudo :
   
       sudo bash postinstall-debian-tui


## INSTALLATION AVEC SECUREBOOT ACTIF (A EFFECTUER AVANT TOUT AUTRE INSTALLATION DE KERNEL OU DRIVER) :

**Pour GNOME/KDE :**

- Vous pouvez utiliser **POSTINSTALL-DEBIAN-GUI**.


***Une compatibilité existe si vous avez Zenity d'installé sur votre système.***

**Pour les autres DE :**

- Utilisez **POSTINSTALL-DEBIAN-TUI**

**Instruction et aide pour Secureboot :**
      
- Suivez les indications à l'écran. Renseignez votre nom lorsque demandé puis, renseignez le mot de passe à usage unique.

  **ATTENTION A QWERTY/AZERTY !** Vous pouvez utiliser uniquement la lettre "t" ou "r" ou bien le mot "root". Ce mot de passe ne servant qu'une seule fois.

- Redémarrez la machine. Vous aurez un écran bleu. Appuyez sur une touche dans les 10 secondes puis
  choissez ENROLL MOK, puis CONTINUE, puis YES (Suivez les instructions en Anglais hélas) le mot de passe à usage unique vous sera demandé (celui que vous avez choisi un peu plus tôt).
  
- Il n'y a pas d'avertissement de réussite mais la première option aura disparu, choisissez REBOOT

**ATTENTION !**


**LE PAQUET DKMS DEVRA ÊTRE PATCHÉ ET BLOQUÉ ! POUR LA MIGRATION VERS UNE NOUVELLE VERSION DE DKMS OU UNE MISE A NIVEAU DE DEBIAN, IL FAUDRA DÉBLOQUER LE PAQUET ET RECOMMENCER LA PROCEDURE**

**UTILISEZ : "sudo apt-mark unhold dkms"**

**AFIN DE DÉBLOQUER LE PAQUET**


## Kernels Customs

Il existe 3 principaux fournisseurs de Kernels Gaming :

- Liquorix
- Xanmod
- TKG

Si vous avez une carte graphique NVIDIA, il se peut que des incompatibilités se produise et que le pilote Nvidia ne soit pas encore rendu compatible avec ces kernels très récents et mis a jour en continu.

**Je vous recommande plutôt l'utilisation du Xanmod-lts, ou bien de faire des kernels TKG vous mêmes afin de vous assurer que tout se passe bien à l'installation.**

Si vous avez besoin d'un kernel plus récent, privilégiez avant tout les backports.

Les Kernels Customs sont entièrement supportés avec secureboot activé après avoir configuré celui-ci.

## Kernel Backports

Pour utiliser les backports, vous pouvez les configurer en 1 clic dans la section Utilitaires.

Pour mettre à niveau votre kernel en 1 commande :

      sudo apt install -t stable-backports linux-image-amd64 linux-headers-amd64 

Une fois terminé, redémarrez la machine.


## Contenu des scripts :

## Secure Boot


- install-sb :                Installe la configuration pour utiliser Secureboot de façon transparente. **ATTENTION** le paquet DKMS se fait patcher !
                              **POUR LA MIGRATION VERS UNE NOUVELLE VERSION DE DKMS OU UNE MISE A NIVEAU DE DEBIAN,**
                              **IL FAUDRA DÉBLOQUER LE PAQUET ET RECOMMENCER LA PROCEDURE !**
                              **UTILISEZ : sudo apt-mark unhold dkms**

## Nvidia

- nvidia-stable :             Installe le driver Nvidia officiel Debian Stable **RECOMMANDÉ** (Actuellement : Branche 525)
  
- nvidia-cuda :               Installe le driver Nvidia Curent Stable en provenance des dépots de NVIDIA (Actuellement : Branche 545)
                              **NVIDIA RECOMMANDE UN KERNEL LTS, PEUT FONCTIONNER AVEC KERNEL CURRENT, MAIS PEUT AUSSI CASSER**
  
- nvidia-experimental :       Installe le dépôt EXPERIMENTAL pour debian pour avoir le dernier driver EXPERIMENTAL (Actuellement : Branche 530-dev)
                              **NECESSITE D'AVOIR ACTIVER LE DEPOT SID EN PIN 10 MINIMUM, POUR LES AVENTURIERS**
                              **NECESSITE DE RELANCER LA PROCÉDURE SECUREBOOT SI ACTIVE !**
  
- nvidia-testing-on-stable :  Installe le FUTUR driver Nvidia pour Debian Stable +1
                              **AJOUTE LE DEPOT TESTING EN PIN 10, POUR LES TESTEURS !**
                              **PEUT NECESSITER UNE MISE A JOUR DE DKMS ! SI UTILISÉ AVEC SECUREBOOT, MEFIANCE !**
  
- nvidia-rollback :           Desinstalle vos drivers Nvidia et fait le ménage !

## AMD / Intel

- mesa-kisak-fresh :          Installe le dernier Mesa Stable pour AMD/INTEL
  
- amd-vulkan :                Installe Vulkan pour les GPU AMD/INTEL

## ROCM https://www.amd.com/fr/graphics/servers-solutions-rocm
  
- rocm :                      Installe le dépot AMD et installe ROCM Opencl et HIP.

## Jeux :

- steam :                     Installe le Steam-Installer pour procéder à l'installation de steam et des dépendances.
  
- lutris-latest :             Installe la dernière version de lutris et le dépôt officiel

- wine-staging :              Installe la dernière version de wine ainsi que toutes les dépendances nécessaire, et le dépôt officiel
      
## gestionaires de paquets

- deb-get :                   Installer deb-get pour installer facilement des logiciels .deb externe aux dépots Debian (heroic, discord, lutris (github version),
                              et d'autres) (UNIQUEMENT POUR DEBIAN STABLE)
                              (https://github.com/wimpysworld/deb-get)
  
- pacstall :                  Une alternative à deb-get, parmet d'accèder à de nombreux logiciels supplémentaires et de les maintenir à jour
                              (https://github.com/pacstall/pacstall - https://pacstall.dev/packages?page=0&size=25&sortBy=default&sort=asc&filter=&filterBy=name)

## firmware

- update-firmware :           Met à jour les firmwares Linux à la dernière version GIT (Support du matériel très récent comme les dernières cartes Wifi ou les
                              derniers GPU)

## Backport ou Sid

- backports :                 Permet d'activer le dépôt stable-backports. Celui-ci est activé en mode Rolling. Lorsque une nouvelle version de Debian sortira,
                              il ne sera pas nécessaire de le reconfigurer.
                              Il est recommandé de passer votre sources.list en branche Stable pour en profiter de façon optimale.
  
- install-sid :               Configure Sid avec un Pin 10, cette moddification utile sur Debian **Stable** et **Testing** permet en cas de dépendances cassées de permettre à votre Debian d'aller chercher uniquement les paquets nécéssaires dans Sid. https://debian-facile.org/doc:systeme:apt:pinning


## REMERCIEMENTS :

Merci à Bazogueur Tobal, Cptcavern, Pandatomikk, Christophe et la Team GLF Pour leur participations et tests sur ce projet !

**Merci à tous les développeurs sur GitHub qui partagent leur travail sans lesquels ce projet n'aurait jamais abouti !**
