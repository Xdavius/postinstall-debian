# POSTINSTALL-DEBIAN - Configurer Facilement Debian !

**CE PROJET EST MAINTENANT EN FIN DE VIE. VEUILLEZ VOUS TOURNER VERS LE PROJET VORTEX. PLUS D'INFOS SUR LE DISCORD GLF.
**LE PROJET EST TOUJOURS UTILISABLE EN L'ETAT, MAIS SON UTILISATION N'EST PLUS RECOMMANDÉE CAR IL NE COUVRE PAS CERTAINES
**AMELIORATIONS CONCERNANT LA MAINTENANCE, LES DEPOTS ADDITIONNELS, ET LA MISE A NIVEAU DU SYSTEME.
**MERCI A TOUS CEUX QUI L'ONT SOUTENU.

## XDAVIUS

[**English version**](https://github.com/Cardiacman13/postinstall-debian/blob/main/lang/README.en.md)

Cet outil a été conçu pour être plus facilement utilisable avec les ISOs Lives de Debian et l'installateur graphique.
Les ISOs lives sont disponibles ici :

      https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/

Le mot de passe ROOT/SUDO des ISOs live est : **live**

**L'interface GUI a été pensée pour fonctionner avec GNOME et KDE et Debian 12/Stable. Une compatibilié est en cours pour prendre en charge CINNAMON,
et à terme, un support complet pour Linux Mint Debian Edition.**


***Vidéos sur postinstall-debian :***

[**Un programme de post install debian en graphique ! by Davius**](https://www.youtube.com/watch?v=6h65fzd0yBE)

[**Installation Debian + Script post-installation feat Davius**](https://youtu.be/jQMO9XDORp0?si=EZZWUi24OyEwvwQ8)


## AVANT DE COMMENCER :

**Il est nécessaire d'avoir configuré SUDO pour utiliser la version GUI.**

SI VOUS AVEZ INSTALLÉ DEBIAN DEPUIS UNE **ISO LIVE**, SUDO EST DÉjÀ CONFIGURÉ !

   - Ouvrez un terminal, puis copier coller cette commande :

         su - -c "usermod -aG sudo $(who | grep tty | cut -d " " -f 1)"

   - Entrez le mot de passe **ROOT (Super Utilisateur)** pour valider la commande, puis **redémarrez la machine**.

**Utiliser la console de dépannage avec Debian**

Si vous avez installé Debian avec sudo sans compte root, il faudra l'activer après l'installation pour avoir accès à 
la console de dépannage (menu avancé de grub) ou bien en cas d'une erreur sur un fichier de configuration empèchant
le démarrage du système. Pour activer le compte ROOT (Superutilisateur) :

      sudo passwd root

Saisissez un nouveau mot de passe. Puis vérifiez que tout est OK en vous connectant :
      
      su -

Pour quitter l'invite de commande root, tapez 'exit'.


## INSTALLATION :


**UTILISATION AVEC INTERFACE GRAPHIQUE (MODE SIMPLIFIÉ/Débutants - Debian 12/STABLE Uniquement) :**


**L'utilisation de la GUI est volairement bloquée sur Testing/Sid.**
**Si vous utilisez ces version, c'est que vous avez déjà les bases. Vous devrez alors utiliser la TUI**


L'interface graphique est optimisée pour GNOME et KDE uniquement.

   - Rendez-vous dans la section **"Releases"** puis télécharger le logiciel (**postinstall-debian-{VERSION}.zip**)

   - Décompressez le zip, puis double cliquez sur **"postinstall-debian-gui.run"**


**NOTE IMPORTANTE !!**

***- Ce logiciel dépend de YAD. Son installation s'effectue automatiquement de façon transparente.***

***- Bash-completions et curl sont installés automatiquements pour combler les différences entre l'installation live et en ligne.***

***- Si Gnome est détecté, l'installation et configuration de flatpak sera effectuée.***
     ***Pour KDE, l'installation se fait en 3 clics dans Discover/Configuration.***

***- L'activation du Multilib, Contrib et Non-free est effectuée au lancement de la GUI pour améliorer l'expérience utilisateur.***

***- La valeure vm_map.max.count est automatiquement montée pour assurer la meilleure compatibilitée pour les jeux vidéos.***

***- KDE est livré avec PulseAudio et Wayland, contrairement à Gnome. Le script remplacera automatiquement PulseAudio par Pipewire.***

***SI VOUS NE LE SOUHAITEZ PAS, UTILISEZ LA TUI !!***

----------------------------------------------------------------------------------------------------------------------------------------------------------------



**POUR CEUX SOUHAITANT UTILISER L'INTERFACE TUI (MODE EXPERT) :**
  
Vous devez exécuter l'application depuis un terminal en root ou en utilisateur :

- Pour exécuter l'application :

       bash postinstall-debian-tui

- Alternativement, vous pouvez aussi lancer en sudo ou en root (su -) :
   
       sudo bash postinstall-debian-tui


## INSTALLATION AVEC SECUREBOOT ACTIF (À EFFECTUER AVANT TOUTE AUTRE INSTALLATION DE KERNEL OU DRIVER) :

**Pour GNOME/KDE :**

- Vous pouvez utiliser **POSTINSTALL-DEBIAN-GUI**.


***Une compatibilité existe si vous avez Zenity d'installé sur votre système.***

**Pour les autres DE :**

- Utilisez **POSTINSTALL-DEBIAN-TUI**.

**Instruction et aide pour Secureboot :**
      
- Suivez les indications à l'écran. Renseignez votre nom lorsque demandé, puis renseignez le mot de passe à usage unique.

  **ATTENTION A QWERTY/AZERTY !** Vous pouvez utiliser uniquement la lettre "t" ou "r" ou bien le mot "root". Ce mot de passe ne servant qu'une seule fois.

- Redémarrez la machine. Vous aurez un écran bleu. Appuyez sur une touche dans les 10 secondes puis
  choissez ENROLL MOK, puis CONTINUE, puis YES (Suivez les instructions en Anglais hélas) le mot de passe à usage unique vous sera demandé (celui que vous avez choisi un peu plus tôt).
  
- Il n'y a pas d'avertissement de réussite mais la première option aura disparu, choisissez REBOOT.

## Debian Testing/Sid

Si vous utilisez ces versions, il est recommandé d'utiliser le script **Postinstall-Testing AIO** depuis l'interface TUI.
Toutefois pour les plus experts, les autres options restent disponible malgrès le risque d'incompatibilités.

Le script est toujours en Bêta et de nouvelles options vont continuer à arriver.
Si vous avez besoin des derniers firmwares AMD/Linux, choisissez les options 4 puis 6 de l'interface TUI.

**N'utilisez pas DEBIAN TESTING/SID sans avoir acquis les bases de Debian**

## Kernels Customs :

Il existe 2 principaux fournisseurs de Kernels Gaming :

- [**TKG**](https://github.com/Frogging-Family/linux-tkg)
- [**Liquorix**](https://liquorix.net/)

Si vous avez une carte graphique NVIDIA, il se peut que des incompatibilités se produisent et que le pilote Nvidia ne soit pas encore rendu compatible avec ces kernels très récents et mis à jour en continu.
COMPATIBLE UNIQUEMENT AVEC LE DRIVER FOURNIT PAR NVIDIA !

**Je vous recommande plutôt l'utilisation du kernel TKG avec Nvidia, à installer vous mêmes, afin de vous assurer que tout se passe bien à l'installation. Il ne se metra pas à jour tout seul et permet de choisir la branche LTS ou Current voir une branche intermédiaire. Cela offre plus de contrôle et permet d'éviter la casse.**

Si vous possédez une carte AMD, le Liquorix est plus simple à mettre en place (Une ligne à copier coller dans le terminal, nécessite d'avoir installé curl)

## SECUREBOOT + Kernels Customs :

***Seul le kernel TKG est entièrement supportés avec secureboot activé après avoir configuré celui-ci avec l'outil fourni par cet utilitaire. L'outil ne prend plus en charge Liquorix ni Xanmod !***

## Kernels Backports Debian Stable :

Pour utiliser les backports, vous pouvez les configurer en 1 clic dans la section Utilitaires.

Pour mettre à niveau votre kernel en 1 commande :

    sudo apt install -t stable-backports linux-image-amd64 linux-headers-amd64 

Une fois terminé, redémarrez la machine.

## Astuces/Dépannage :

- Pour les pocesseurs de carte graphique non supportés, Utilisez l'installation expert puis avant de finir l'installation, sélectionnez :
  - Démarrer un sheel
  - faites :
    
          chroot /target bash
          cd /root
          apt install git wget
          git clone -b dev https://github.com/xdavius/postinstall-debian.git
          cd postinstall-debian
          bash postinstall-debian-tui
  
  - Puis installez les linux-firmwares-git (option 4 puis 6)
  - Installez un kernel récent au besoin (exemple liquorix, sans secureboot)
    
          apt install curl
          curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash

## Contenu des scripts :

## SecureBoot :


- install-sb :                Installe la configuration pour utiliser Secureboot de façon transparente. **ATTENTION** le paquet DKMS se fait patcher !

                              
## Nvidia :

- nvidia-stable :             Installe le driver Nvidia officiel Debian Stable **RECOMMANDÉ/KERNEL LTS UNIQUEMENT**. (Actuellement : Branche 525)
  
- nvidia-cuda :               Installe le driver Nvidia Curent Stable en provenance des dépots de NVIDIA. (Actuellement : Branche 545)
                              **NVIDIA CONSEILLE UN KERNEL LTS ou BACKPORTÉ, PEUT FONCTIONNER AVEC KERNEL CURRENT (Liquorix/TKG), MAIS PEUT AUSSI CASSER !**
  
- nvidia-experimental :       Installe le dépôt EXPERIMENTAL pour debian pour avoir le dernier driver EXPERIMENTAL de Debian
                              **NECESSITE D'AVOIR ACTIVER LE DEPOT SID EN PIN 10 MINIMUM, POUR LES AVENTURIERS ! RISQUE TRES ELEVE DE CASSE !**
                              **NECESSITE DE RELANCER LA PROCÉDURE SECUREBOOT SI ACTIVE !**
  
- nvidia-testing-on-stable :  Installe le FUTUR driver Nvidia pour Debian Stable +1.
                              **AJOUTE LE DEPOT TESTING EN PIN 10, POUR LES TESTEURS ! Supporte les kernels en provencance de stable-backports**
                              **PEUT NECESSITER UNE MISE A JOUR DE DKMS !**
  
- nvidia-rollback :           Désinstalle vos drivers Nvidia et fait le ménage !

## AMD / Intel :

- mesa-kisak-fresh :          Installe le dernier Mesa Stable pour AMD/INTEL. **RECOMMANDÉ**
  
- amd-vulkan :                Installe Vulkan pour les GPU AMD/INTEL. **RECOMMANDÉ**

## ROCM : 
[**Page officielle ROCM**](https://www.amd.com/fr/graphics/servers-solutions-rocm)
  
- rocm :                      Installe le dépot AMD et installe ROCM Opencl et HIP.

## Jeux :

- steam :                     Installe le Steam-Installer pour procéder à l'installation de steam et des dépendances.
  
- lutris-latest :             Installe la dernière version de lutris et le dépôt officiel.

- wine-staging :              Installe la dernière version de wine ainsi que toutes les dépendances nécessaire, et le dépôt officiel.
  
- Discord :                   Installe le dépôt automatique de Javinator9889 pour avoir discord toujours à jour.
                              [**Github javinator9889**](https://github.com/Javinator9889/Discord-PPA)
      
## Gestionaires de paquets

- deb-get :                   Installer deb-get pour installer facilement des logiciels .deb externes aux dépots Debian (heroic, discord, lutris (github version),
                              et d'autres), pour Debian Stable uniquement.
                              [**Github deb-get**](https://github.com/wimpysworld/deb-get).
  
- pacstall :                  Une alternative à deb-get, permet d'accèder à de nombreux logiciels supplémentaires et de les maintenir à jour.
                              [**Github pacstall**](https://github.com/pacstall/pacstall) / [**Liste des paquets pacstall**](https://pacstall.dev/packages?page=0&size=25&sortBy=default&sort=asc&filter=&filterBy=name).

## Firmwares :

- update-firmware :           Met à jour les firmwares Linux à leurs dernières versions GIT (Support du matériel très récent comme les dernières cartes Wifi ou les
                              derniers GPU)

## Backports ou Sid :

- backports :                 Permet d'activer le dépôt stable-backports. Celui-ci est activé en mode Rolling. Lorsque une nouvelle version de Debian sortira,
                              il ne sera pas nécessaire de le reconfigurer.
                              Il est recommandé de passer votre sources.list en branche Stable pour en profiter de façon optimale.
  
- install-sid :               Configure Sid avec un Pin 10, cette moddification utile sur Debian **Stable** et **Testing** permet en cas de dépendances cassées de permettre à votre Debian d'aller chercher uniquement les paquets                                          nécéssaires dans Sid. [**Explication de pinning par Debian Facile**](https://debian-facile.org/doc:systeme:apt:pinning).

## Laptops

- envycontrol :                Permet de controler un laptop Optimus et de chosir le mode dédié/hybride. Fonctionne pour laptops nvidia/intel et amd/amd.
                               Le dossier ENVYCONTROL-GUI contient des scripts d'installations d'extensions graphiques pour GNOME et KDE 
                               [**Documantation Complète ICI**](https://github.com/Xdavius/envycontrol/blob/main/README.md)

## REMERCIEMENTS :

Merci à Bazogueur Tobal, Cptcavern, Pandatomikk, Christophe, Cfrancky77, Piaf-jaune pour le logo de l'application, et toute la Team GLF pour leur participation et tests sur ce projet !

**Merci à tous les développeurs sur GitHub qui partagent leur travail sans lesquels ce projet n'aurait jamais abouti !**
