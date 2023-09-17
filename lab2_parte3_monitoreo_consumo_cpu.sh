#!/bin/bash

# Verificar si se proporciona el argumento correcto
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ruta_al_ejecutable>"
    exit 1
fi

# Ruta al ejecutable
ejecutable="$1"

# Archivo de log para el consumo de recursos
log_file="log_consumo_recursos.log"

# Duración de la medición (en segundos)
duracion=60

# Iniciar el ejecutable en segundo plano
"$ejecutable" &

# Obtener el PID del proceso recién iniciado
pid=$!

# Crear el archivo de log o borrar su contenido si ya existe
> "$log_file"

# Iniciar la medición
for ((i = 0; i < duracion; i++)); do
    # Obtener el consumo de CPU y memoria usando 'top' y 'awk'
    top -b -n 1 -p $pid | awk -v i=$i '{if (i == 0) print "Tiempo(s) CPU(%) Memoria(%)"; if (i > 0) print i, $9, $10}' >> "$log_file"
    
    # Esperar antes de la próxima medición
    sleep 1
done

# Graficar los datos usando gnuplot
gnuplot <<EOF
set terminal png
set output "grafico_consumo_recursos.png"
set xlabel "Tiempo (s)"
set ylabel "Consumo (%)"
plot "$log_file" using 1:2 with lines title "CPU", \
     "$log_file" using 1:3 with lines title "Memoria"
EOF

echo "Proceso terminado y gráfico generado en grafico_consumo_recursos.png"
