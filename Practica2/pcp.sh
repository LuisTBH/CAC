#!/bin/bash

usage="Usage: $0 Origen Destino"
if [ -z $1 ] || [ -z $2 ]
then
echo "$0: Error --Necesitas indicar un origen y un destino."
echo $usage
exit 1
else
for i in 2 3 4 5 6 7 8;
do
if ssh cac$i "test -d $2"; then
   echo "El directorio existe y se copiaran los archivos"
   echo "Copiando archivo en el nodo $i......"
   scp $1 cac$i:$2/$1
else
   echo "La carpeta destino no existe, esta será creada y luego se
copiará el archivo"
   ssh cac2 "mkdir $2"
   echo "Copiando archivo en el nodo $i......"
   scp $1 cac$i:$2/$1
fi


#ssh cac$i "mkdir $2"
#ssh cac$i exit
#scp $1 cac$i:$2/$1
#echo "Copiando archivos.... $i"
#ssh cac$i mkdir PRUEBA
done
fi

