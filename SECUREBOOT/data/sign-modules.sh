#!/bin/bash

find /usr -name \*.ko | while read i; \
do sudo --preserve-env=KBUILD_SIGN_PIN \
/opt/signtool/sign-file sha256 /var/lib/shim-signed/mok/MOK.priv /var/lib/shim-signed/mok/MOK.der "$i"\
|| break; done