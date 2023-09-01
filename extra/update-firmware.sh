#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

clear
echo "
-----------------------------------------------------------------

Job start : Updating linux-firmware to latest git

-----------------------------------------------------------------

"
sleep 2

wget -c https://gitlab.com/kernel-firmware/linux-firmware/-/archive/main/linux-firmware-main.tar.gz -O - | tar -xz
mv linux-firmware-main/* /usr/lib/firmware
rm -rf linux-firmware-main

echo "

Job done
"
echo "
Veuillez REBOOT la machine !!
"
sleep 2
