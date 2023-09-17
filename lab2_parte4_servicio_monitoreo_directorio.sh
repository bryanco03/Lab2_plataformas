#!/bin/bash

# Directorio a monitorear
directorio_a_monitorear="/home/bryan/directorio_monitoreado"

# Archivo de log
archivo_log="/home/bryan/lab2/Lab2_plataformas/cambios.log"

# Inicio del monitoreo
inotifywait -m -r -e create,modify,delete "$directorio_a_monitorear" |
while read -r directorio evento archivo; do
    # Obtener la fecha y hora actual
    fecha_hora=$(date +"%Y-%m-%d %H:%M:%S")

    # Escribir el mensaje en el archivo de log
    echo "[$fecha_hora] Evento detectado en $directorio: $evento $archivo" >> "$archivo_log"
done


