#!/bin/bash

for i in 1 2 3 4 5 6 7 8
do
{ printf "cac\n.cac\n1\n$i\n2\nyes\n\n\e\e4\n"; sleep 2; } | telnet pdujupiter.disca.upv.es
sleep 2;
done
