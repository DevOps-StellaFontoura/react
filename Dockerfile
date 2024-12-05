# Paso 1: Construir la aplicación
FROM node:18-alpine AS builder

# Establecer el directorio de trabajo para el build
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY . .

# Instalar dependencias y construir la aplicación
RUN npm install && npm run build -- --configuration=production

# Paso 2: Crear la imagen de ejecución con nginx
FROM nginx:alpine

# Copiar los archivos del build al contenedor
COPY --from=builder /app/dist/apps/catalog /usr/share/nginx/html

# Exponer el puerto en el que NGINX escucha
EXPOSE 80

# Comando para iniciar NGINX (opcional, ya incluido en la imagen base)
CMD ["nginx", "-g", "daemon off;"]