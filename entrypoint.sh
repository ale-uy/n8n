#!/bin/sh
set -e

# Leer las variables de entorno de la base de datos
host="${DB_POSTGRESDB_HOST}"
port="${DB_POSTGRESDB_PORT}"

# Comprobar que las variables existen
if [ -z "${host}" ] || [ -z "${port}" ]; then
  echo "Error: Las variables DB_POSTGRESDB_HOST y DB_POSTGRESDB_PORT son obligatorias."
  exit 1
fi

echo "--- Punto de Entrada: Verificando conexión a la base de datos en ${host}:${port}... ---"

# Bucle de espera hasta que la base de datos esté lista
while ! nc -z -w5 "${host}" "${port}"; do
  echo "Base de datos no disponible. Reintentando en 5 segundos..."
  sleep 5
done

echo "--- Conexión a la Base de Datos Verificada ---"
echo "Lanzando el proceso principal de n8n..."

# Iniciar n8n directamente, ignorando cualquier comando pasado desde Render.
# El comando por defecto es 'n8n', que es un alias de 'n8n start'.
exec n8n
