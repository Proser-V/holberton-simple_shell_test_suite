#!/bin/bash
# test_shell.sh

echo "🧪 Test 1 : Mode interactif simulé (commande dans echo)"
echo "/bin/ls" | ./hsh

echo -e "\n🧪 Test 2 : Plusieurs lignes via fichier"
echo "/bin/ls" > test_ls_2
echo "/bin/ls" >> test_ls_2
cat test_ls_2 | ./hsh

echo -e "\n🧪 Test 3 : Commande inconnue"
echo "badcommand" | ./hsh

echo -e "\n🧪 Test 4 : Built-in 'env'"
echo "env" | ./hsh

echo -e "\n🧪 Test 5 : Built-in 'exit'"
echo "exit" | ./hsh
