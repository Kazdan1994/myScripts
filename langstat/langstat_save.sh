#!/bin/bash
if [ $# -ge 1 ]; then #test si y a un parametre
 if [ -e "$1" ]; then #test si le fichhier existe
  if [ "$#" -eq 2 ]; then #test si 2eme parametre
    param="$2"
   case "$param" in #verifie que le 2eme parametre est connu
    "-p")
     echo "pourcentage"
    total=$(grep -Eio [a-z] "$1" | wc -l)
     for lettre in {a..z}; do
      compte=$(grep -io "$lettre" "$1" | wc -l)
      resultat=$(echo "scale=2; ($compte*100)/$total" | bc -l)
      echo "$resultat % -$lettre"
     done | sort -rn
    ;;
    "-g")
     echo "graphique"
    total=$(grep -Eio [a-z] "$1" | wc -l)
     for lettre in {a..z}; do
      compte=$(grep -io "$lettre" "$1" | wc -l)
      let "resultat = ($compte*100)/$total"
      for i in `seq 1 100`; do
       if [ $i -le "$resultat" ]; then
        ligne+="+"
       fi
      done
       echo "-$lettre $ligne"
       ligne=''
     done   
    ;;
    *) #si 2eme parametre inconnu
     echo "parametre inconnu"
     echo "parametre disponible :"
     echo "-p : pour avoir le resultat en pourcentage"
     echo "-g : pour avoir un aperçu graphique"
     echo "utilisation : ./langstat.sh <file> [parametre]"
    ;;
   esac
  elif [ "$#" -eq 1 ]; then #si 1 seul parametre
   for lettre in {a..z}; do
    echo "$(grep -io "$lettre" "$1" | wc -l) -$lettre"
   done | sort -rn
  else #si plus de 2 parametre entrer
   echo "parametre disponible :"
   echo "-p : pour avoir le resultat en pourcentage"
   echo "-g : pour avoir un aperçu graphique"
   echo "utilisation : ./langstat.sh <file> [parametre]"
  fi
 else #si fichier inexistant
 echo "le fichier n existe pas"
 echo "parametre disponible :"
 echo "-p : pour avoir le resultat en pourcentage"
 echo "-g : pour avoir un aperçu graphique"
 echo "utilisation : ./langstat.sh <file> [parametre]"
 fi
else #si pas de parametre entrer
echo "parametre inconnu"
echo "parametre disponible :"
echo "-p : pour avoir le resultat en pourcnetage"
echo "-g : pour avoir un aperçu graphique"
echo "utilisation : ./langstat.sh <file> [parametre]"
fi