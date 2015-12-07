#!/usr/bin/python3.5
# -*- coding: utf8 -*-
# Version de python prise en charge par le script python3.5
alfa = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" # Tout les lettres de l'alphabet en majuscule uniquement

tab = dict() # Création du dico pour les statistiques

mon_fichier = open("dico.txt", "r") # Ouverture du fichier dico en mode lecture et écriture

contenu = mon_fichier.read() # Chargement du contenu dans la variable contenu

mots = (contenu.split("\n")) # Création de la liste des mots

mon_fichier.close() # Fermeture du fichier

# Boucle pour compter les lettres du dictionnaire
for elt in mots:
    for lettre in elt:
        if lettre in tab.keys() and lettre in alfa:
            tab[lettre] += 1
        else:
            if lettre in alfa:
                tab[lettre] = 1

L = tab.items()

def tri(x,y):
    if x[1]>y[1]:
        return -1
    elif x[1]==y[1]:
        return 0
    else:
        return 1

L.sorted(tri)
for cle,valeur in L:
    print(valeur," - ",cle)