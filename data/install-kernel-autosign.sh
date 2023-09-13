#!/bin/bash

cp zz-signing /etc/kernel/postinst.d
chown root:root /etc/kernel/postinst.d/zz-signing
chmod u+rx /etc/kernel/postinst.d/zz-signing

# Uncomment to use with ubuntu mainline
#cp sbin/zz-mainline-signing /etc/kernel/postinst.d
#chown root:root /etc/kernel/postinst.d/zz-mainline-signing
#chmod u+rx /etc/kernel/postinst.d/zz-mainline-signing
