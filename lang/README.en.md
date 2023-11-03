# POSTINSTALL-DEBIAN - Easily Configure Debian!

This tool has been designed to be more user-friendly with Debian Live ISOs and the graphical installer.
Live ISOs are available here:

      https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/

The ROOT/SUDO password for the live ISOs is: **live**

**The GUI interface is designed to work with GNOME and KDE. Compatibility for CINNAMON is underway,
and full support for Linux Mint Debian Edition will eventually be provided.**


***Videos on postinstall-debian:***

[**A post-install debian program in graphics! by Davius**](https://www.youtube.com/watch?v=6h65fzd0yBE)

[**Debian Installation + Post-installation Script feat Davius**](https://youtu.be/jQMO9XDORp0?si=EZZWUi24OyEwvwQ8)


## BEFORE YOU BEGIN:


**It is necessary to have configured SUDO to use the GUI version.**

IF YOU HAVE INSTALLED DEBIAN FROM A **LIVE ISO**, SUDO IS ALREADY CONFIGURED!

   - Open a terminal, then copy and paste this command:

         su - -c "usermod -aG sudo $(who | grep tty | cut -d " " -f 1)"

   - Enter the **ROOT (Super User)** password to validate the command, then **restart the machine**.


## INSTALLATION:


**USING WITH GRAPHICAL INTERFACE (SIMPLIFIED MODE):**


The graphical interface is optimized for GNOME and KDE only.

   - Go to the **"Releases"** section and download the software (**postinstall-debian-{VERSION}.zip**)

   - Unzip the zip file, then double click on **"postinstall-debian-gui.run"**


**IMPORTANT NOTE!!**

***This software depends on YAD. Its installation is performed automatically in a transparent way.***

***Bash-completions and curl are automatically installed to bridge the differences between live and online installation.***

***If Gnome is detected, the installation and configuration of flatpak will be performed. For KDE, the installation is done in 3 clicks in Discover/Settings.***

***The activation of Multilib, Contrib and Non-free is performed at the launch of the GUI to improve the user experience.***

***IF YOU DO NOT WISH THIS, USE THE TUI!!***

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



**FOR THOSE WISHING TO USE THE TUI INTERFACE (EXPERT MODE):**

  
You must run the application from a terminal as root:

- To become root:

       sudo -i (or su -)

- To run the application:

       bash postinstall-debian-tui

- Alternatively, you can also launch with sudo:
   
       sudo bash postinstall-debian-tui


## INSTALLATION WITH SECUREBOOT ACTIVE (TO BE PERFORMED BEFORE ANY OTHER KERNEL OR DRIVER INSTALLATION):

**For GNOME/KDE:**

- You can use **POSTINSTALL-DEBIAN-GUI**.


***There is compatibility if you have Zenity installed on your system.***

**For other DEs:**

- Use **POSTINSTALL-DEBIAN-TUI**.

**Instructions and help for Secureboot:**
      
- Follow the on-screen instructions. Enter your name when asked, then enter the one-time password.

  **BE CAREFUL WITH QWERTY/AZERTY!** You can use only the letter "t" or "r" or the word "root". This password is only used once.

- Restart the machine. You will see a blue screen. Press a key within 10 seconds then
  choose ENROLL MOK, then CONTINUE, then YES (follow the instructions in English unfortunately) the one-time password will be requested (the one you chose earlier).
  
- There is no success notification but the first option will have disappeared, choose REBOOT.

**ATTENTION!**

**THE DKMS PACKAGE WILL NEED TO BE PATCHED AND BLOCKED! FOR MIGRATION TO A NEW VERSION OF DKMS OR AN UPGRADE OF DEBIAN, THE PACKAGE WILL NEED TO BE UNBLOCKED AND THE PROCEDURE REPEATED,**

**USE: "sudo apt-mark unhold dkms"**

**TO UNBLOCK THE PACKAGE.**

## Custom Kernels:

There are 2 main providers of Gaming Kernels:

- [**TKG**](https://github.com/Frogging-Family/linux-tkg)
- [**Liquorix**](https://liquorix.net/)

If you have an NVIDIA graphics card, there may be incompatibilities, and the Nvidia driver may not yet be compatible with these very recent kernels that are continuously updated.

**I recommend using the TKG kernel with Nvidia, which you'll install yourself, to ensure everything goes smoothly during installation. It will not update automatically and allows you to choose between the LTS branch or the Current branch, or even an intermediate branch. This offers more control and helps avoid breaking your system.**

If you have an AMD card, Liquorix is easier to set up (one line to copy-paste into the terminal, requires having installed curl).

Custom Kernels are fully supported with Secure Boot enabled after configuring it with the tool provided by this utility.

## Debian Stable Backports Kernels:

To use backports, you can configure them with one click in the Utilities section.

To upgrade your kernel with one command:

    sudo apt install -t stable-backports linux-image-amd64 linux-headers-amd64 

Once finished, restart your machine.

## Content of the scripts:

## SecureBoot:

- install-sb:                Installs the configuration to use Secure Boot transparently. **WARNING** the DKMS package is patched!
                             **FOR MIGRATION TO A NEW VERSION OF DKMS OR AN UPGRADE OF DEBIAN,**
                             **YOU WILL NEED TO UNLOCK THE PACKAGE AND REPEAT THE PROCEDURE!**
                             **USE: sudo apt-mark unhold dkms**

## Nvidia:

- nvidia-stable:             Installs the official Debian Stable Nvidia driver **RECOMMENDED**. (Currently: Branch 525)
  
- nvidia-cuda:               Installs the Nvidia Current Stable driver from the NVIDIA repositories. (Currently: Branch 545)
                             **NVIDIA RECOMMENDS A LTS KERNEL, MAY WORK WITH CURRENT KERNEL, BUT MAY ALSO BREAK!**
  
- nvidia-experimental:       Installs the EXPERIMENTAL repository for Debian to have the latest EXPERIMENTAL driver (Currently: Branch 530-dev)
                             **REQUIRES ACTIVATING THE SID REPOSITORY WITH A PIN OF AT LEAST 10, FOR ADVENTURERS!**
                             **SECURE BOOT PROCEDURE MUST BE REPEATED IF ACTIVE!**
  
- nvidia-testing-on-stable:  Installs the FUTURE Nvidia driver for the next Debian Stable release.
                             **ADDS THE TESTING REPOSITORY WITH A PIN OF 10, FOR TESTERS!**
                             **MAY REQUIRE A DKMS UPDATE! USE WITH SECURE BOOT WITH CAUTION!**
  
- nvidia-rollback:           Uninstalls your Nvidia drivers and cleans up!

## AMD / Intel:

- mesa-kisak-fresh:          Installs the latest Stable Mesa for AMD/INTEL.
  
- amd-vulkan:                Installs Vulkan for AMD/INTEL GPUs.

## ROCM:
[**Official ROCM page**](https://www.amd.com/fr/graphics/servers-solutions-rocm)
  
- rocm:                      Installs the AMD repository and installs ROCM Opencl and HIP.

## Games:

- steam:                     Installs the Steam-Installer to proceed with the installation of Steam and its dependencies.
  
- lutris-latest:             Installs the latest version of Lutris and the official repository.

- wine-staging:              Installs the latest version of Wine along with all necessary dependencies, and the official repository.
      
## Package Managers

- deb-get:                   Install deb-get to easily install .deb software external to the Debian repositories (heroic, discord, lutris (github version),
                             and others), for Debian Stable only.
                             [**Github deb-get**](https://github.com/wimpysworld/deb-get).
  
- pacstall:                  An alternative to deb-get, allows access to many additional pieces of software and keeps them up to date.
                             [**Github pacstall**](https://github.com/pacstall/pacstall) / [**Pacstall package list**](https://pacstall.dev/packages?page=0&size=25&sortBy=default&sort=asc&filter=&filterBy=name).

## Firmwares:

- update-firmware:           Updates Linux firmwares to their latest GIT versions (Supports very recent hardware like the latest Wifi cards or GPUs).

## Backports or Sid:

- backports:                 Enables the stable-backports repository. This is activated in Rolling mode. When a new version of Debian is released,
                             it will not be necessary to reconfigure it.
                             It is recommended to set your sources.list to Stable branch for optimal use.
  
- install-sid:               Configures Sid with a Pin of 10, this useful modification

 on Debian **Stable** and **Testing** allows, in case of broken dependencies, for your Debian to fetch only the necessary packages from Sid. [**Explanation of pinning by Debian Facile**](https://debian-facile.org/doc:systeme:apt:pinning).


## ACKNOWLEDGMENTS:

Thanks to Bazogueur Tobal, Cptcavern, Pandatomikk, Christophe, Cfrancky77, Yellow-bird for the application logo, and the entire GLF Team for their participation and tests on this project!

**Thanks to all the developers on GitHub who share their work without which this project would never have succeeded!**
