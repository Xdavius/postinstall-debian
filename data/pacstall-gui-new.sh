#!/usr/bin/bash
function chemintmp () {
chemintmp="./pactmp"
}
chemintmp
rm -rf $chemintmp
mkdir $chemintmp
cp "pacstall-patched.sh" "$chemintmp/pacstall-patched"

$chemintmp/pacstall-patched -S [a-aZ-z] > "$chemintmp/export.txt" && cut -c8- "$chemintmp/export.txt" > "$chemintmp/export1.txt" &&cut -d ' ' -f 1 "$chemintmp/export1.txt" > "$chemintmp/packagelist"
cat $chemintmp/packagelist | awk '{print $0; print "empty";}' > $chemintmp/packagelist2 && sed '1 s/^/empty\n/' $chemintmp/packagelist2 > $chemintmp/packagelist

function pacstalllist () {
chemintmp
$chemintmp/pacstall-patched --list > "$chemintmp/installed.txt"
menupacstall2=$(yad --width 500 --height 450 --list --print-all --column="Package Name":TXT $(cat "$chemintmp/installed.txt") --title="Packet installer" --button="Ok:0" --center --dclick-action="true" --multiple)
}

function pacstallremove () {
chemintmp
$chemintmp/pacstall-patched --list > "$chemintmp/installed.txt"
cat $chemintmp/installed.txt | awk '{print $0; print "empty";}' > $chemintmp/installed2.txt && sed '1 s/^/empty\n/' $chemintmp/installed2.txt > $chemintmp/installed.txt
menupacstall2=$(yad --width 500 --height 450 --list --column="Install":CHK --print-all --column="Package Name":TXT $(cat "$chemintmp/installed.txt") --title="Packet installer" --button="Ok:0" --center --dclick-action="true" --multiple)

echo "$menupacstall2" > "$chemintmp/menurmv.txt"
soft=$(grep 'TRUE' "$chemintmp/menurmv.txt")
sortie=$(echo "$soft" | cut -d'|' -f2)
$chemintmp/pacstall-patched -PR $(echo $sortie)
}

function menupacstall () {
export -f pacstalllist
export -f chemintmp
export -f pacstallremove
chemintmp
menupacstall=$(yad --width 500 --height 450 --list --column="Install":CHK --print-all --column="Package Name":TXT $(cat "$chemintmp/packagelist") --title="package list" --button="list:bash -c pacstalllist" --button="Supprimer:bash -c pacstallremove" --button="Install:0" --center --dclick-action="true" --multiple)
echo "$menupacstall" > "$chemintmp/menu.txt"
soft=$(grep 'TRUE' "$chemintmp/menu.txt")
sortie=$(echo "$soft" | cut -d'|' -f2)
$chemintmp/pacstall-patched -PI $(echo $sortie)
}
menupacstall
