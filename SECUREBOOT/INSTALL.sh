#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi
apt install -f dkms

kernel_ver=(uname -r)
srcdir=$(pwd)
chmod +x data/*.sh
chmod +x data/src/zz-signing
source $srcdir/data/secureboot.sh
source $srcdir/data/install-kernel-autosign.sh
mkdir -p /opt/signtool/
cp /lib/modules/$kernel_ver/build/scripts/sign-file /opt/signtool
