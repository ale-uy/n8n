# Usar la imagen oficial de n8n como base
FROM n8nio/n8n:latest

# --- SECCIÓN DE ADMINISTRADOR (root) ---
# Cambiar temporalmente al usuario 'root' para tener permisos
USER root

# Instalar netcat (nc), una herramienta de red que usaremos para probar la conexión
RUN apk add --no-cache netcat-openbsd

# Copiar nuestro script de punto de entrada personalizado al contenedor
COPY ./entrypoint.sh /usr/local/bin/

# Hacer que nuestro script sea ejecutable. Esto ahora se ejecuta como 'root'.
RUN chmod +x /usr/local/bin/entrypoint.sh

# --- SECCIÓN DE USUARIO NORMAL (node) ---
# Ahora que hemos terminado con las tareas de administrador,
# volvemos al usuario 'node' por seguridad para el resto de la operación.
USER node

# Establecer nuestro script como el punto de entrada para el contenedor
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
