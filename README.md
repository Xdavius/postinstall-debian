# POSTINSTALL-DEBIAN - Configurer Facilement sa Debian !


## AVANT DE COMMENCER :


Il est nécessaire d'avoir configuré SUDO pour utiliser ce logiciel.

SI VOUS AVEZ INSTALLÉ DEBIAN DEPUIS UNE ISO LIVE, SUDO EST DÉjÀ CONFIGURÉ !

- Ouvrez un terminal puis copier coller cette commande :

    su - -c "usermod -aG sudo $(who | grep tty | cut -d " " -f 1)"

- Entrez le mot de passe ROOT (Super Utilisateur) pour valider la commande puis redémarrez la machine.

## INSTALLATION AVEC SECUREBOOT ACTIF (A EFFECTUER AVANT TOUT AUTRE INSTALLATION DE KERNEL OU DRIVER) :

La procédure est la suivante :

- Rendez-vous dans le dossier SECUREBOOT puis ouvrez un terminal et exécutez ces lignes :

      sudo bash install-sb.sh
      
- Suivez les indication à l'écran. Renseignez votre nom lorsque demandé puis, renseignez le mot de passe à usage unique.

  ATTENTION A QWERTY/AZERTY ! Vous pouvez utiliser uniquement la lettre "t" ou "r" ou bien le mot "root". Ce mot de passe ne servant qu'une seule fois.

- Redémarrez la machine. Vous aurais un écran bleu. Appuyez sur une touche dans les 10 secondes puis
  choissez ENROLL MOK, puis CONTINUE, puis YES (Suivez les instructions en Anglais hélas) le mot de passe à usage unique vous sera demandé.
  
- Il n'y a pas d'avertissement de reussite mais la première option aura disparu, choisissez REBOOT

## INSTALLATION


- UTILISATION AVEC INTERFACE GRAPHIQUE :


Rendez-vous dans la section "Releases" puis télécharger le logiciel (postinstall-debian.zip)

Décompressez le zip, puis double cliquez sur "postinstall-debian-gui.run"

* Ce logiciel dépend de YAD. Son installation s'effectue automatiquement de façon transparente. *


- POUR CEUX SOUHAITANT UTILISER L'INTERFACE TUI :

  
Vous devez exécuter l'application depuis un terminal en root :
Pour passer root : 

    sudo -i (ou su -)

pour exécuter l'application :

    bash postinstall-debian-tui

Alternativement, vous pouvez aussi lancer en sudo :
    
    sudo bash postinstall-debian-tui


## Contenu des scripts :

Certains scripts ne sont pas accessible via l'application GUI (bugs) Mais ils sont utilisables via le TUI ou en stand-alone.

- nvidia-stable : Installer le driver Nvidia officiel Debian Stable
- nvidia-testing : Installer le dépôt EXPERIMENTAL pour debian pour avoir le dernier driver EXPERIMENTAL
- nvidia-rollback : Desinstaller nvidia-base-upgrade et/ou nvidia-testing
  
- mesa-kisak-fresh : Installer le dernier Mesa Stable pour AMD/INTEL
- amd-vulkan : Installe Vulkan pour les GPU AMD/INTEL

- wine-staging : Installer la dernière version de wine ainsi que toutes les dépendances nécessaire
- deb-get : Installer deb-get pour installer facilement des logiciels .deb externe aux dépots Debian (heroic, discord, lutris (github version), et d'autres) (UNIQUEMENT POUR DEBIAN STABLE)
- pacstall : Une alternative à deb-get, parmet d'accèder à de nombreux logiciels supplémentaires et de les maintenir à jour

- update-firmware : Met à jour les firmwares Linux à la dernière version GIT (Support du matériel très récent comme les dernière cartes Wifi ou les derniers GPU)
- install-sid : Configure Sid avec un Pin 10 (UNIQUEMENT POUR DEBIAN TESTING)

## REMERCIEMENTS :

Merci à Alternatux, Bazogueur Tobal, cptcavern, Pandatomikk, christophe et la Team GLF Pour leur participations et tests sur ce projet !
