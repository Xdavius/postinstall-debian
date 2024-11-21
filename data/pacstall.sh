#!/bin/bash

# Root checker
if [[ $EUID -ne 0 ]]; then
	echo -e "\n---------------------------------------\n"
    echo -e "You need to be logged as root (su- / sudo -i)" 1>&2
    echo -e "\n---------------------------------------\n"
	exit 1
fi

echo "Installation de pacstall
"; sleep 2

apt install -y curl
bash -c "$(curl -fsSL https://github.com/pacstall/pacstall/raw/develop/install.sh || wget -q https://github.com/pacstall/pacstall/raw/develop/install.sh -O -)"

echo "
Job done
"; sleep 2
