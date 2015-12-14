﻿#!/bin/bash

 
declare -A tableau 
declare param
declare fichier
declare tri
 
get_param()
{
    until [ -z "$1" ]
    do
        if [ ${1:0:2} = '--' ]
        then
            tmp=${1:2} 
            parametre=${tmp%%=*} 
            param="$parametre"
        elif [ ${1:0:1} == '-' ] && [ ${1:0:2} != '--' ]
        then
            tmp=${1:1} 
            parametre=${tmp%%=*} 
            param="$parametre"
        else
            fichier=${1} 
        fi
        shift
    done
}
 
get_param $* 
tri="desc"
if [ ! -z $param ]
then
    case $param in
        "help")
            echo -e "Utilisation du script\n"
            echo -e "$0 nom_du_fichier_dico --tri-croissant | --tri-decroissant\n"
            echo -e "$0 nom_du_fichier_dico -asc | -desc\n"
            echo -e "$0 --help | -h Affiche ce message"
            exit 0
            ;;
        "h")
            echo -e "Utilisation du script\n"
            echo -e "$0 nom_du_fichier_dico --tri-croissant | --tri-decroissant\n"
            echo -e "$0 nom_du_fichier_dico -asc | -desc\n"
            echo -e "$0 --help | -h Affiche ce message"
            exit 0
            ;;
        "tri-croissant")
            tri="asc"
            ;;
        "asc")
            tri="asc"
            ;;
        "tri-decroissant")
            tri="desc"
            ;;
        "desc")
            tri="desc"
            ;;
        "*")
            echo "pour avoir de l'aide tappez --help ou -h"
            exit 1
            ;;
    esac
fi
 
if [ -z ${fichier} ] 
then
    echo -e "Vous devez fournir en paramètre le nom du fichier \n(exemple : ./$0 dico.txt [param] )"
    exit 1
elif [ -e ${fichier} ] && [ -f ${fichier} ] && [ -r ${fichier} ] 
then
    echo -e "In progress"
    cat ${fichier} | tr -d '\r\n' > /tmp/temp.txt 
 
    while read -n 1 caractere 
    do
        tableau[$caractere]=$((tableau[$caractere] + 1))
    done < /tmp/temp.txt
    for k in ${!tableau[@]} 
    do
        if [ "${k}" != "-" ]
        then
            echo ${tableau["$k"]} " - " $k
        fi
    done |
    if [ ${tri} == 'desc' ]
    then
        sort -rn 
    elif [ ${tri} == 'asc' ]
    then
        sort -n 
    rm -rf /tmp/temp.txt 
    exit 0
else
    echo "La paramètre n'est pas valide, il faut un fichier texte accessible en lecture"
    exit 1
fi
