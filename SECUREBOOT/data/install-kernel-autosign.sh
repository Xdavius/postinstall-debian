#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

cp $srcdir/SECUREBOOT/data/src/zz-signing /etc/kernel/postinst.d
chown root:root /etc/kernel/postinst.d/zz-signing
chmod u+rx /etc/kernel/postinst.d/zz-signing

if [[ $patch_dkms == o ]] ; then
	ins_mod_sing="/etc/kernel/postinst.d/zz-signing"
	cat<<EOF>>$ins_mod_sign
	kernel_mod_name=$(echo $KERNEL_IMAGE | cut -c 15-)
	echo "Signature des modules dans /usr/lib/modules/$kernel_mod_name/"

	find /usr/lib/modules/$kernel_mod_name/ -name \*.ko | while read i; \
	do sudo --preserve-env=KBUILD_SIGN_PIN \
	/opt/signtool/sign-file sha256 /var/lib/shim-signed/mok/MOK.priv /var/lib/shim-signed/mok/MOK.der "$i"\
	|| break; done"
	EOF
fi

echo "
Signatures automatiques des kernels installé
"

# Uncomment to use with ubuntu mainline
#cp sbin/zz-mainline-signing /etc/kernel/postinst.d
#chown root:root /etc/kernel/postinst.d/zz-mainline-signing
#chmod u+rx /etc/kernel/postinst.d/zz-mainline-signing

sleep 2
