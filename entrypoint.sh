#!/bin/sh

# Establecer un comportamiento estricto: si un comando falla, el script se detiene.
set -e

# Leer las variables de entorno de la base de datos.
# El comando ':=' asegura que si la variable no está definida, se usa un valor por defecto (en este caso, vacío).
host="${DB_POSTGRESDB_HOST:-}"
port="${DB_POSTGRESDB_PORT:-6543}"

echo "--- Punto de Entrada Iniciado ---"
echo "Esperando que la base de datos en ${host}:${port} esté disponible..."

# Bucle de espera:
# El comando 'nc -z -w5 ${host} ${port}' intenta conectarse.
# '-z' escanea sin enviar datos.
# '-w5' establece un timeout de 5 segundos.
# El bucle continuará mientras el comando 'nc' falle.
while ! nc -z -w5 "${host}" "${port}"; do
  echo "La base de datos no está lista todavía. Reintentando en 5 segundos..."
  sleep 5
done

echo "--- ¡Conexión a la Base de Datos Exitosa! ---"
echo "Iniciando n8n..."

# Una vez que el bucle termina, ejecuta el comando original de n8n.
# 'exec "$@"' pasa cualquier argumento que se haya enviado al contenedor al proceso de n8n.
exec "$@"
