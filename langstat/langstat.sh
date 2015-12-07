#!/bin/bash
# Script statistiques sur l'utilisation des lettres dans une langue
# Vous devez lui fournir un fichier contenant un mot par ligne

declare -A tableau # Déclaration d'un tableau associatif pour les statistiques des lettres
declare param
declare fichier
declare tri

get_param(){
until [ -z "$1" ]
do
if [ ${1:0:2} = '--' ]
then
tmp=${1:2} # Retrait du '-' au début de la chaîne
parametre=${tmp%%=*} # Extraction du nom
param="$parametre"
elif [ ${1:0:1} == '-' ] && [ ${1:0:2} != '--' ]
then
tmp=${1:1} # Retrait du '--' au début de la chaîne
parametre=${tmp%%=*} # Extraction du nom
param="$parametre"
else
fichier=${1} # C'est pas un paramètre
fi
shift
done
}

get_param $* # Appel de la fonction avec la liste des paramètre
tri="desc"
if [ ! -z $param ]
then
case $param in "help")
echo -e "Utilisation du script\n"
echo -e "$0 nom_du_fichier_dico --tri-croissant | --tri-decroissant\n"
echo -e "$0 nom_du_fichier_dico -asc | -desc\n"
echo -e "$0 --help | -h Affiche ce message"
exit 0;;"h")
echo -e "Utilisation du script\n"
echo -e "$0 nom_du_fichier_dico --tri-croissant | --tri-decroissant\n"
echo -e "$0 nom_du_fichier_dico -asc | -desc\n"
echo -e "$0 --help | -h Affiche ce message"
exit 0;"tri-croissant"
tri="asc";;"asc")
tri="asc";;"tri-decroissant")
tri="desc";;"desc")
tri="desc";;"*")
echo "pour avoir de l'aide tappez --help ou -h"
exit 1
;;
esac
fi

if [ -z ${fichier} ] # Test si le script reçois un paramètre fichier  obligatoire, pour effectuer son traitement.
then
echo -e "Vous devez fournir en paramètre le nom du fichier \n(exemple : ./$0 dico.txt [param] )"
exit 1
elif [ -e ${fichier} ] && [ -f ${fichier} ] && [ -r ${fichier} ] # Test si le fichier existe, si c'est un fichier normal et si il est accessible en lecture évidemment
then
echo -e "Traitement en cours, le script peut durer un moment en fonction de la taille du fichier !\nMerci de patienter !"
cat ${fichier} | tr -d '\r\n' > /tmp/temp.txt # On crée un fichier sans retour chariot "\r" et retour de linge "\n"
# Permet d'optimiser la durer finale du script !
# time ./langstat.sh dico.txt
# real  1m2.826s
# user  0m59.952s
# sys   0m2.820s

while read -n 1 caractere # On lit le fichier caractère par caractère
do
tableau[$caractere]=$((tableau[$caractere]+1))
done < /tmp/temp.txt
for k in ${!tableau[@]} # Parcour du tableau associatif
do
if [ "${k}" != "-" ]
then
echo ${tableau["$k"]} " - " $k
fi
done | if [ ${tri} == 'desc' ]
then
sort -rn # On utilise sort avec le paramètre -nr pour trier les valeurs numérique par ordre décroissante
elif [ ${tri} == 'asc' ]
then
sort -n # On utilise sort avec le paramètre -nr pour trier les valeurs numérique par ordre décroissante
fi
rm -rf /tmp/temp.txt # On supprime le fichier temporaire crée pour la statistique
exit 0
else
echo "La paramètre n'est pas valide, il faut un fichier texte accessible en lecture"
exit 1
fi