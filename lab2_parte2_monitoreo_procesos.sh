#!/bin/bash

# Verificar si se proporcionan los argumentos correctos
if [ $# -ne 2 ]; then
    echo "Uso: $0 <nombre_del_proceso> <comando_de_arranque>"
    exit 1
fi

nombre_proceso="$1"
comando_arranque="$2"

while true; do
    # Verificar si el proceso está en ejecución
    if ! pgrep -x "$nombre_proceso" > /dev/null; then
        echo "El proceso $nombre_proceso no está en ejecución. Volviendo a levantarlo..."
        # Ejecutar el comando de arranque
        eval "$comando_arranque"
    fi

    # Esperar antes de verificar nuevamente
    sleep 5 
    echo "El proceso esta ejecutando"
done

