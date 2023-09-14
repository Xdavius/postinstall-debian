#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi
srcdir=$(pwd)
chmod +x data/*.sh
chmod +x data/src/zz-signing
source $srcdir/data/secureboot.sh
source $srcdir/data/install-kernel-autosign.sh
