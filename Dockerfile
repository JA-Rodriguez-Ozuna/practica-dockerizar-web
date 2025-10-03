# Usar Ubuntu como imagen base
FROM ubuntu:latest

# Actualizar repositorios e instalar dependencias
RUN apt-get update && \
    apt-get install -y nginx git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clonar el repositorio del juego 2048 en el directorio de Nginx
RUN rm -rf /var/www/html/* && \
    git clone https://github.com/gabrielecirulli/2048.git /var/www/html/

# Exponer el puerto 80
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]