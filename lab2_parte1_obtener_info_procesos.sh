#!/bin/bash

# Se verifica si se proporciona un argumento 

if [ $# -ne 1 ]; then
	echo "Uso $0 <PID>"
	exit 1
fi

#pid del proceso

pid=$1


# Se obtiene la informacion del proceso

nombre_proceso=$(ps -p $pid -o comm=)
parent_id=$(ps -p $pid -o ppid=)
usuario_propetario=$(ps -p $pid -o user=)
porcentaje_cpu=$(ps -p $pid -o %cpu=)
consumo_memoria=$(ps -p $pid -o %mem=)
estado=$(ps -p $pid -o stat=)
path_ejecutable=$(readlink /proc/$pid/exe)


# Mostrar la información obtenida
echo "Información del proceso con PID $pid:"
echo "Nombre del proceso: $nombre_proceso"
echo "ID del proceso: $pid"
echo "Parent process ID: $parent_id"
echo "Usuario propietario: $usuario_propetario"
echo "Porcentaje de uso de CPU: $porcentaje_cpu"
echo "Consumo de memoria: $consumo_memoria"
echo "Estado (status): $estado"
echo "Path del ejecutable: $path_ejecutable"
