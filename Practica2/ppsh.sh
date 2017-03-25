#!/bin/bash

if [ -z $1 ]
then
echo "$0: Error -- Necesitas especificar comando a ejecutar y
parámetros si son necesarios"
else
#echo -e "\n"$0 $1
#(echo -e "\n\nhola\ncac1: " $($1) && echo "-----------------------")&
#$1&


for i in 1 2 3 4 5 6 7 8;
do
#echo "cac$i: "
#ssh cac$i $1&
(echo -e "\n\n****** EJECUCIÓN EN EL NODO $i ******\nOrden: $0 $1\n\ncac$i: " $(ssh cac$i $1) && echo "-----------------------")&

done

fi
