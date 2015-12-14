#!/bin/bash
cat dico.txt | while read line  
do   
   echo -e "$line\n"  
done