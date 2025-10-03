# practica-dockerizar-web
# Práctica: Dockerizar una Aplicación Web Estática

## Datos del Estudiante
- **Nombre:** Jose Anibal Rodriguez Ozuna
- **matricula:** 24-0915
- **Fecha:** 10/03/2025

## Descripción del Proyecto
En esta práctica se ha dockerizado una aplicación web estática (el juego 2048) utilizando Docker, se ha publicado la imagen en Docker Hub y se ha desplegado en Railway.app como alternativa a AWS.

## Objetivos Cumplidos
✅ Crear un Dockerfile para contenerizar la aplicación  
✅ Construir la imagen Docker localmente  
✅ Publicar la imagen en Docker Hub  
✅ Crear archivo docker-compose.yml  
✅ Desplegar la aplicación en Railway.app  
✅ Verificar el acceso público a la aplicación  

## Pasos Realizados

### 1. Creación del Dockerfile

Se creó un archivo `Dockerfile` con las siguientes características:

```dockerfile
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
```

**Explicación del Dockerfile:**
- Se utiliza Ubuntu como imagen base
- Se instalan Nginx (servidor web) y Git (para clonar repositorios)
- Se clona el repositorio del juego 2048 en `/var/www/html/`
- Se expone el puerto 80 para acceso HTTP
- Se configura Nginx para ejecutarse en primer plano
<img width="778" height="329" alt="Image" src="https://github.com/user-attachments/assets/16cc91cb-d260-4147-820d-1245e3ea0694" />

### 2. Construcción de la Imagen Docker

Se construyó la imagen Docker utilizando el siguiente comando:

docker build -t josero31/nginx-2048:1.0 .

**Proceso:**
- Docker descargó la imagen base de Ubuntu
- Instaló las dependencias necesarias
- Clonó el repositorio de GitHub
- Configuró Nginx correctamente

**Verificación de la imagen creada:**
```
docker images
```

<img width="395" height="56" alt="image" src="https://github.com/user-attachments/assets/1396f600-5af8-4df0-8207-2ac47448545d" />

---

### 3. Etiquetado de la Imagen

Se agregó la etiqueta `latest` a la imagen:

```
docker tag josero31/nginx-2048:1.0 josero31/nginx-2048:latest
```

**Resultado:**
La imagen ahora tiene dos etiquetas: `1.0` y `latest`, ambas apuntando a la misma imagen.

---

### 4. Pruebas Locales

Se realizó una prueba local del contenedor:

```
docker run -d -p 8080:80 josero31/nginx-2048:1.0
```

**Verificación:**
- Se accedió a `http://localhost:8080`
- La aplicación funcionó correctamente
- Se detuvo el contenedor después de las pruebas

---

### 5. Publicación en Docker Hub

#### 5.1 Creación de Token de Acceso
Se creó un token de acceso en Docker Hub con los siguientes permisos:
- **Permisos:** Read & Write
- **Descripción:** practica-docker

#### 5.2 Inicio de Sesión
```
docker login -u josero31
```

#### 5.3 Publicación de las Imágenes
```bash
docker push josero31/nginx-2048:1.0
docker push josero31/nginx-2048:latest
```

**Resultado:**
- Imagen disponible públicamente en Docker Hub
- URL: https://hub.docker.com/r/josero31/nginx-2048

<img width="912" height="400" alt="image" src="https://github.com/user-attachments/assets/0b72eb52-3252-4104-9553-fe655a9bf678" />

---

### 6. Creación del archivo docker-compose.yml

Se creó un archivo `docker-compose.yml` para facilitar el despliegue:

```yaml
version: '3.8'

services:
  web:
    image: josero31/nginx-2048:latest
    container_name: web-2048
    ports:
      - "80:80"
    restart: always
```

**Este archivo permite:**
- Desplegar la aplicación con un solo comando
- Configurar reinicio automático
- Mapear el puerto 80 del contenedor al host

---

### 7. Despliegue en Railway.app

Se utilizó Railway.app como alternativa a AWS por ser una plataforma gratuita y más accesible.

#### 7.1 Creación de Cuenta
- Se creó una cuenta en Railway.app usando GitHub

#### 7.2 Creación del Proyecto
- Se seleccionó "Deploy from Docker Hub"
- Se especificó la imagen: `josero31/nginx-2048:latest`
- Railway descargó y desplegó automáticamente el contenedor

#### 7.3 Configuración del Dominio Público
- Se generó un dominio público desde la sección "Networking"
- Railway asignó automáticamente una URL pública

**URL de la aplicación desplegada:**
https://nginx-2048-production.up.railway.app/

<img width="941" height="472" alt="image" src="https://github.com/user-attachments/assets/f6e1f1e4-7468-4d13-ab24-4a8d91c2fd94" />


---

## Comandos Utilizados (Resumen)

```
# Construir la imagen
docker build -t josero31/nginx-2048:1.0 .

# Etiquetar como latest
docker tag josero31/nginx-2048:1.0 josero31/nginx-2048:latest

# Ver imágenes
docker images

# Probar localmente
docker run -d -p 8080:80 josero31/nginx-2048:1.0

# Iniciar sesión en Docker Hub
docker login -u josero31

# Publicar en Docker Hub
docker push josero31/nginx-2048:1.0
docker push josero31/nginx-2048:latest

# Desplegar con docker-compose (localmente)
docker-compose up -d
```

---

## Estructura de Archivos del Proyecto

```
practica-docker-web/
├── Dockerfile
├── docker-compose.yml
└── README.md
```

---

## Resultados Obtenidos

### Imagen en Docker Hub
- **Repositorio:** josero31/nginx-2048
- **Etiquetas:** 1.0, latest
- **Estado:** Público y accesible
- **Tamaño:** 59.5 MB

### Aplicación Desplegada
- **Plataforma:** Railway.app
- **URL pública:** https://nginx-2048-production.up.railway.app/
- **Estado:** Funcionando correctamente
- **Contenido:** Juego 2048 completamente funcional

---

## Conclusiones

1. **Docker facilita el despliegue:** Una vez creada la imagen, se puede desplegar en cualquier plataforma que soporte contenedores.

2. **Portabilidad:** La misma imagen funciona tanto localmente como en Railway.app sin modificaciones.

3. **Docker Hub como registro:** Publicar en Docker Hub permite compartir y desplegar imágenes fácilmente.

4. **Alternativas a AWS:** Railway.app demostró ser una excelente alternativa gratuita para despliegues simples.

5. **Automatización:** Docker Compose simplifica el proceso de despliegue con un solo comando.

---

## Recursos y Referencias

- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Railway.app Documentation](https://docs.railway.app/)
- [Repositorio original del juego 2048](https://github.com/gabrielecirulli/2048)

---

## Repositorio del Proyecto

**GitHub:** https://github.com/JA-Rodriguez-Ozuna/practica-dockerizar-web.git

---

## Licencia

Este proyecto se realizó con fines educativos como parte del curso de Implantación de Aplicaciones Web.

---

**Fecha de entrega:** 10/04/2025 
**Autor:** Jose Anibal Rodriguez Ozuna
