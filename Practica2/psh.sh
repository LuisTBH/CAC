#Script psh para la asignatura de CAC del Máster MIC.
#!/bin/bash
echo -e "\n"$0 $1
echo "=================="
echo "cac1"
echo "------------------"

$1

for i in 2 3 4 5 6 7 8;
do
echo "=================="
echo "cac$i"
echo "------------------"

ssh cac$i $1
done
