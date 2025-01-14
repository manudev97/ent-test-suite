#!/bin/bash
# Directorio con los archivos a procesar
DIRECTORIO="./urandom"
# Archivo de salida para resultados
RESULTADOS="resultados.csv"

# Contar el número total de archivos en el directorio
TOTAL_ARCHIVOS=$(find "$DIRECTORIO" -type f | wc -l)

# Escribe encabezado para los resultados
echo "Archivo,File-bytes,Entropy,Chi-square,Mean,Monte-Carlo-Pi,Serial-Correlation" > $RESULTADOS

# Contador para los archivos procesados
PROCESADOS=0

# Procesa cada archivo en el directorio
for ARCHIVO in "$DIRECTORIO"/*; do
    if [ -f "$ARCHIVO" ]; then
        # Ejecuta ent y guarda el resultado
        SALIDA=$(./ent -t "$ARCHIVO")

        # Extrae la segunda línea que contiene los valores relevantes
        DATOS=$(echo "$SALIDA" | sed -n '2p')

        # Extrae los valores para cada métrica usando awk
        FILE_BYTES=$(echo "$DATOS" | awk -F, '{print $2}')
        ENTROPY=$(echo "$DATOS" | awk -F, '{print $3}')
        CHI_SQUARE=$(echo "$DATOS" | awk -F, '{print $4}')
        ARITHMETIC_MEAN=$(echo "$DATOS" | awk -F, '{print $5}')
        PI=$(echo "$DATOS" | awk -F, '{print $6}')
        SERIAL_CORRELATION=$(echo "$DATOS" | awk -F, '{print $7}')

        # Agrega los resultados al archivo CSV
        echo "$(basename "$ARCHIVO"),$FILE_BYTES,$ENTROPY,$CHI_SQUARE,$ARITHMETIC_MEAN,$PI,$SERIAL_CORRELATION" >> $RESULTADOS

        # Actualiza el contador de archivos procesados
        PROCESADOS=$((PROCESADOS + 1))

        # Calcula el porcentaje de progreso
        PORCENTAJE=$((PROCESADOS * 100 / TOTAL_ARCHIVOS))

        # Muestra el porcentaje en pantalla
        echo -ne "Procesando: $PORCENTAJE% ($PROCESADOS de $TOTAL_ARCHIVOS archivos)\r"
    fi
done

# Nueva línea después de la barra de progreso para que no quede sobreescrito
echo -e "\nProceso completado."
