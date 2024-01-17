#!/bin/bash
#localdir=$(pwd)
#console_error="bash -c $localdir/SECUREBOOT/install-sb.sh"

echo "Version de Debian non-supportée. Veuillez utiliser la TUI
"

read -n1 -p "Appuyez sur une touche pour quitter..." once_exit

case $once_exit in
*)
exit 2
;;
esac


