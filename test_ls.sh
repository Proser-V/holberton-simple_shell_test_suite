#!/bin/bash
#
# Test de ./hsh avec des commandes `ls` contenant différents espaces

# Variables
command="ls
     ls
ls     
 ls     "
tmp_file="checker_tmp_file_$RANDOM"
OUTPUTFILE="output_test.txt"
SLEEPSECONDS=1

# Fonction de nettoyage
cleanup() {
    rm -f "$tmp_file" "$OUTPUTFILE"
}

# Crée un fichier temporaire
touch "$tmp_file"

# Envoie les commandes à ton shell custom ./hsh
echo "$command" | ./hsh > "$OUTPUTFILE" 2> /dev/null &

# Attend un peu que ./hsh ait le temps d'exécuter
sleep "$SLEEPSECONDS"

# Vérifie que le fichier temporaire est bien listé à chaque `ls`
nmatch=$(grep -c "$tmp_file" "$OUTPUTFILE")

if [ "$nmatch" -eq 4 ]; then
    echo "[OK] Le fichier a été listé 4 fois."
else
    echo "[KO] Le fichier n'a pas été listé 4 fois. (match=$nmatch)"
fi

# Nettoyage
cleanup
