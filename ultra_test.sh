#!/bin/bash

SHELL="./hsh"  # Mets ici le nom de ton binaire

echo "======== Test 1: Commande absolue ========="
echo "/bin/ls" | $SHELL

echo "======== Test 2: Commande simple, PATH valide ========="
echo "ls" | $SHELL

echo "======== Test 3: Commande avec arguments ========="
echo "ls -l /tmp" | $SHELL

echo "======== Test 4: Commande avec espaces autour ========="
echo "     ls     " | $SHELL

echo "======== Test 5: Commande multiple avec vides ========="
printf "\n\n/bin/ls\n  ls  \n\n" | $SHELL

echo "======== Test 6: PATH vide, commande absolue ========="
PATH="" echo "/bin/ls" | $SHELL

echo "======== Test 7: PATH vide, commande simple ========="
PATH="" echo "ls" | $SHELL

echo "======== Test 8: PATH supprimée ========="
env -i $SHELL <<EOF
ls
EOF

echo "======== Test 9: PATH supprimée, commande absolue ========="
env -i $SHELL <<EOF
/bin/ls
EOF

echo "======== Test 10: PATH invalide ========="
PATH="notarealpath" echo "ls" | $SHELL

echo "======== Test 11: PATH modifiée (contient ./) ========="
cp /bin/ls ./hb_shell_ls
PATH=".:$PATH" echo "./hb_shell_ls /var" | $SHELL

echo "======== Test 12: Commande inexistante ========="
echo "doesnotexistcommand" | $SHELL

echo "======== Test 13: PATH= vide et commande inexistante ========="
PATH="" echo "doesnotexistcommand" | $SHELL

echo "======== Test 14: PATH supprimé, mais variable PATH1 présente ========="
env -i PATH1="/bin" $SHELL <<EOF
ls
EOF

echo "======== Test 15: Chemin relatif complexe ========="
cp /bin/ls ../../../hb_shell_ls
echo "../../../hb_shell_ls /var" | $SHELL

echo "======== Test 16: Chemin chelou avec plein de ../ ========="
cp /bin/ls ../../../hb_shell_ls
echo "../../.././../././../hb_shell_ls /var" | $SHELL
