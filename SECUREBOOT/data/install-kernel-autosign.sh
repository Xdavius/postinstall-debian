#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

cp "$srcdir"/SECUREBOOT/data/src/zz-signing /etc/kernel/postinst.d
chown root:root /etc/kernel/postinst.d/zz-signing
chmod u+rx /etc/kernel/postinst.d/zz-signing

echo "
Signatures automatiques des kernels installés
"

# Uncomment to use with ubuntu mainline
#cp sbin/zz-mainline-signing /etc/kernel/postinst.d
#chown root:root /etc/kernel/postinst.d/zz-mainline-signing
#chmod u+rx /etc/kernel/postinst.d/zz-mainline-signing

sleep 2
