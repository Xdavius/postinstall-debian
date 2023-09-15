#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "Setup: must be run logged as root (su - / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi


echo "
Configuration de Secureboot
"
sleep 2


function create_key() {
apt install -y sbsigntool dkms

mkdir -p /var/lib/shim-signed/mok/
cd /var/lib/shim-signed/mok/

echo "
"
read -p "Saisissez votre nom pour la signature : " sign_name

if [[ $sign_name == "" ]]
	then sign_name="NoName"
fi
echo "
"

openssl req -new -x509 -nodes -newkey rsa:2048 -keyout MOK.priv -outform DER -addext "extendedKeyUsage=codeSigning" -out MOK.der -days 36500 -subj "/CN=$sign_name/"
openssl x509 -inform der -in MOK.der -out MOK.pem


}

function import_mok() {
echo "

-----------------------------------------------------------------------------

CREATION DU MOT DE PASSE UNIQUE POUR ENROLL.
ATTENTION AVEC AZERTY/QWERTY !!! 
Pour ne pas faire d'erreur, vous pouvez utiliser - root - comme mot de passe.

-----------------------------------------------------------------------------


"

sleep 5

mokutil --import /var/lib/shim-signed/mok/MOK.der

echo "

REBOOTEZ LA MACHINE MAINTENANT POUR ENROLL LA CLE

"

sleep 2
}


function sign_helper() {

sign1='mok_signing_key="/var/lib/shim-signed/mok/MOK.priv"'
sign2='mok_certificate="/var/lib/shim-signed/mok/MOK.der"'
sign3='sign_tool="/etc/dkms/sign_helper.sh"'
sign4='sign_file=/opt/signtool/sign-file"
echo $sign1 > /etc/dkms/framework.conf
echo $sign2 >> /etc/dkms/framework.conf
echo $sign3 >> /etc/dkms/framework.conf
echo $sing4 >> /etc/dkms/framework.conf

sign_helper='/lib/modules/"$1"/build/scripts/sign-file sha512 /var/lib/shim-signed/mok/MOK.priv /var/lib/shim-signed/mok/MOK.der "$2"'
echo $sign_helper > /etc/dkms/sign_helper.sh
chmod +x /etc/dkms/sign_helper.sh
}


function sign_kernel() {
echo "
Signature du kernel actuel en cours
"
VERSION="$(uname -r)"
SHORT_VERSION="$(uname -r | cut -d . -f 1-2)"
MODULES_DIR=/lib/modules/$VERSION
KBUILD_DIR=/usr/lib/linux-kbuild-$SHORT_VERSION

sbsign --key /var/lib/shim-signed/mok/MOK.priv --cert /var/lib/shim-signed/mok/MOK.pem "/boot/vmlinuz-$VERSION" --output "/boot/vmlinuz-$VERSION.tmp"
mv /boot/vmlinuz-$VERSION.tmp /boot/vmlinuz-$VERSION
}

create_key
sign_helper
import_mok
sign_kernel
#function
#mokutil --import /var/lib/dkms/mok.pub
