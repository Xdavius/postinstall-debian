# POSTINSTALL-DEBIAN - Configurer Facilement Debian !

Cet outils a été conçu pour être lus facilement utilisable avec les ISO Lives de Debian et l'installateur graphique.
Les isos lives sont disponibles ici :

      https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/

Le mot de passe ROOT/SUDO des Isos live est : **live**

**L'interface GUI à été pensée pour fonctionner avec GNOME et KDE. Une compatibilié est en cours pour prendre en charge CINNAMON,
et a terme, un support complet pour Linux Mint Debian Edition.**

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

- pour exécuter l'application :

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
      
- Suivez les indication à l'écran. Renseignez votre nom lorsque demandé puis, renseignez le mot de passe à usage unique.

  ATTENTION A QWERTY/AZERTY ! Vous pouvez utiliser uniquement la lettre "t" ou "r" ou bien le mot "root". Ce mot de passe ne servant qu'une seule fois.

- Redémarrez la machine. Vous aurais un écran bleu. Appuyez sur une touche dans les 10 secondes puis
  choissez ENROLL MOK, puis CONTINUE, puis YES (Suivez les instructions en Anglais hélas) le mot de passe à usage unique vous sera demandé.
  
- Il n'y a pas d'avertissement de reussite mais la première option aura disparu, choisissez REBOOT


## Contenu des scripts :


- install-sb :                Installer la configuration pour utiliser Secureboot de façon transparente. **ATTENTION** le paquet DKMS se fait patcher !
                              **POUR LA MIGRATION VERS UNE NOUVELLE VERSION DE DKMS, IL FAUDRA DÉBLOQUER LE PAQUET ET RECOMMENCER LA PROCEDURE !**
                              **UTILISEZ : sudo apt-mark unhold dkms**

- nvidia-stable :             Installer le driver Nvidia officiel Debian Stable **RECOMMANDÉ** (Actuellement : Branche 525)
- nvidia-cuda :               Installer le driver Nvidia Curent Stable en provenance des dépots de NVIDIA (Actuellement : Branche 535)
                              **NVIDIA RECOMMANDE UN KERNEL LTS, PEUT FONCTIONNER AVEC KERNEL CURRENT, MAIS PEUT AUSSI CASSER**
- nvidia-experimental :       Installer le dépôt EXPERIMENTAL pour debian pour avoir le dernier driver EXPERIMENTAL (Actuellement : Branche 530-dev)
                              **NECESSITE D'AVOIR ACTIVER LE DEPOT SID EN PIN 10 MINIMUM, POUR LES AVENTURIERS**
                              **NECESSITE DE RELANCER LA PROCÉDURE SECUREBOOT SI ACTIVE !**
  
- nvidia-testing-on-stable :  Installer le FUTUR driver Nvidia pour Debian Stable +1
                              **AJOUTE LE TEPOT TESTING EN PIN 10, POUR LES TESTEURS !**
                              **PEUT NECESSITER UNE MISE A JOUR DE DKMS ! SI UTILISÉ AVEC SECUREBOOT, MEFIANCE !**
- nvidia-rollback :           Desinstaller vos drivers Nvidia et faire le ménage !
  
- mesa-kisak-fresh :          Installer le dernier Mesa Stable pour AMD/INTEL
- amd-vulkan :                Installe Vulkan pour les GPU AMD/INTEL
- rocm :                      Installe le dépot AMD et installe ROCM Opencl et HIP.

- steam :                     Installe le Steam-Installer pour procéder à l'installation de steam et des dépendances.
- lutris-latest :             Installer la dernière version de lutris et le dépôt officiel 
- wine-staging :              Installer la dernière version de wine ainsi que toutes les dépendances nécessaire, et le dépôt officiel 

- deb-get :                   Installer deb-get pour installer facilement des logiciels .deb externe aux dépots Debian (heroic, discord, lutris (github version), et d'autres) (UNIQUEMENT POUR DEBIAN STABLE)
                              (https://github.com/wimpysworld/deb-get)
  
- pacstall :                  Une alternative à deb-get, parmet d'accèder à de nombreux logiciels supplémentaires et de les maintenir à jour
                              (https://github.com/pacstall/pacstall - https://pacstall.dev/packages?page=0&size=25&sortBy=default&sort=asc&filter=&filterBy=name)

- backports :                 Permet d'activer le dépôt stable-backports. Celui ci est activé en mode Rolling. Lorsque une nouvelle version de Debian sortira, il ne sera pas nécessaire de le reconfigurer.
                              Il est recommandé de passer votre sources.list en branche Stable pour en profiter de façon optimale.
- update-firmware :           Met à jour les firmwares Linux à la dernière version GIT (Support du matériel très récent comme les dernière cartes Wifi ou les derniers GPU)
- install-sid :               Configure Sid avec un Pin 10 (Debian stable ou Testing)


## REMERCIEMENTS :

Merci à Bazogueur Tobal, cptcavern, Pandatomikk, christophe et la Team GLF Pour leur participations et tests sur ce projet !

**Merci à tous les développeurs sur GitHub qui partagent leur travail sans lesquels ce projet n'aurait jamais abouti !**
