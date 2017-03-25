#!/bin/bash
valor_accion=''
valor_a=''
valor_b=''
valor_NodoUnico=''
valor_inicio=''
valor_final=''

usage="Usage: $0 [-1 | -2] [-a || -n number || -f inicio -t final ]"

#Si ponemos los dos puntos delante quitamos el error verbose mode
#por lo que coge la que indiquemos, sino coge el por defecto.

while getopts ":12an:f:t:" opt
do
	case $opt in
	
	1)valor_accion=1;;
	
	2)valor_accion=2;;
	
	a)valor_a=9;;
	
	n)valor_NodoUnico=$OPTARG;;
	
	f)valor_inicio=$OPTARG;;
	
	t)valor_final=$OPTARG;;
	
	
	\?) echo "$0: Error -- Opción inválida: -$OPTARG"
		echo $usage
		exit 1 ;;
	:) echo "$0: Error -- Falta parámetro en opc -$OPTARG"
		echo $usage
		exit 1;;
	
	esac	
done

if [ -z "$valor_accion" ]
	then
	
		echo "$0: Error -- Indicar una acción válida.-1(Encender) o -2(Apagar)" 
		echo $usage
		exit 1
		
	elif ([ -z "$valor_a" ] && [ -z "$valor_NodoUnico" ] && [ -z "$valor_inicio" ]) || ([ -n "$valor_a" ] && [ -n "$valor_NodoUnico" ] && [ -n "$valor_inicio" ])
	then
	
		echo "$0: Error -- Indicar una opcion válida: Todos (-a), algun nodo (-n X) o un rango (-f inicio - t final)." 
		echo $usage
		exit 1		
		
	elif [ -n "$valor_a" ] && ( [ -n "$valor_NodoUnico" ] || [ -n "$valor_inicio" ] || [ -n "$valor_final" ])
	then
	
		echo "$0: Error -- Indicar una opcion válida: Todos (-a), algun nodo (-n X) o un rango (-f inicio - t final)."
		echo $usage
		exit 1		
		
	elif [ -n "$valor_a" ] && ( [ -z "$valor_NodoUnico" ] && [ -z "$valor_inicio" ] && [ -z "$valor_final" ])
	then
	
		echo "Todos seleccionados --> Se aplicará la acción $valor_accion a todos."
		{ printf "cac\n.cac\n1\n9\n$valor_accion\nyes\n\n\e\e4\n"; sleep 2; } | telnet pdujupiter.disca.upv.es
		exit 1
		
		
	elif [ -n "$valor_NodoUnico" ] && ( [ -n "$valor_a" ] || [ -n "$valor_inicio" ] || [ -n "$valor_final" ])
	then
	
		echo "$0: Error -- Indicar una opcion válida: Todos (-a), algun nodo (-n X) o un rango (-f inicio - t final)." 
		echo $usage
		exit 1	
		
		
	elif [ -n "$valor_NodoUnico" ] && ( [ -z "$valor_a" ] || [ -z "$valor_inicio" ] || [ -z "$valor_final" ])
	then
	
		echo "Solo un nodo: $valor_NodoUnico --> Se le aplicará la acción $valor_accion." 
		{ printf "cac\n.cac\n1\n$valor_NodoUnico\n$valor_accion\nyes\n\n\e\e4\n"; sleep 2; } | telnet pdujupiter.disca.upv.es
		exit 1
		
		
		
	#hace falta poner que el inicio tenga un final. condicion:)	
		
		
	elif [ -n "$valor_inicio" ] && [ -n "$valor_final" ] && ( [ -z "$valor_a" ] && [ -z "$valor_NodoUnico" ] )
	then
	
		#Sse ha limitado el rango de nodos para esta PDU especifica.
		if [ $valor_inicio -gt $valor_final ] || [ $valor_inicio -eq 0 ] || [ $valor_final -gt 9 ]
		then
			echo "$0: Error -- No puede ser mayor el inicio que el final del rango, no se puede empezar por 0 y son 9 nodos máximo [1-9]."
			exit 1
		else
	
		let contador=$valor_inicio
		while [ $contador -le $valor_final ]; do
		
		echo "Realizamos la acción $valor_accion en el nodo $contador." 
		#{ printf "cac\n.cac\n1\n$valor_inicio\n$valor_accion\nyes\n\n\e\e4\n"; sleep 2; } | telnet pdujupiter.disca.upv.es
		let contador=$contador+1
		done
		exit 1
		fi
		
		
	elif [ -n "$valor_inicio" ] && [ -z "$valor_final" ] && ( [ -z "$valor_a" ] && [ -z "$valor_NodoUnico" ] )
	then
		echo "$0: Error -- Indicar una opcion válida: -f inicio - t final." 
		echo $usage
		exit 1
		
	
	else
		echo "$0: Situación inesperada."
		exit 1
	fi

