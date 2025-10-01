# Usar la imagen oficial de n8n como base
FROM n8nio/n8n:latest

# Instalar netcat (nc), una herramienta de red que usaremos para probar la conexión.
# Alpine Linux (la base de n8n) usa 'apk' como gestor de paquetes.
USER root
RUN apk add --no-cache netcat-openbsd
USER node

# Copiar nuestro script de punto de entrada personalizado al contenedor
COPY ./entrypoint.sh /usr/local/bin/

# Hacer que nuestro script sea ejecutable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Establecer nuestro script como el punto de entrada
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
