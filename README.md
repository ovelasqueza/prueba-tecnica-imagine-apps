# Prueba Técnica - Imagine Apps

Este repositorio contiene una aplicación completa para la gestión de tareas y usuarios. La solución está compuesta por los siguientes componentes:

1. **Backend:** API RESTful desarrollada en PHP con el framework Laravel, incluyendo migraciones para la base de datos.
2. **Frontend Web:** Interfaz web desarrollada en Angular con estilos utilizando Tailwind CSS.
3. **Frontend App:** Aplicación móvil desarrollada en Flutter.
4. **Base de Datos:** PostgreSQL configurado con Docker.
5. **Docker Compose:** Archivo para levantar el backend, frontend web y la base de datos en contenedores.

## Estructura del Proyecto

El proyecto está organizado de la siguiente manera:

- **backend:** Contiene el código fuente del backend desarrollado en Laravel.
- **frontend_web:** Contiene el código fuente del frontend web desarrollado en Angular.
- **frontend_app:** Contiene el código fuente de la aplicación móvil desarrollada en Flutter.
- **docker-compose.yml:** Archivo de configuración para levantar los servicios con Docker.

## Requisitos Previos

Antes de ejecutar el proyecto, asegúrate de tener instalado lo siguiente:

- **Docker:** Para levantar el backend, frontend web y la base de datos.
- **Flutter SDK:** Para ejecutar la aplicación móvil.
- **PostgreSQL Client (opcional):** Para interactuar directamente con la base de datos.

## Instrucciones de Ejecución

### 1. Clonar el Repositorio

Clona este repositorio en tu máquina local:

```bash
git clone https://github.com/ovelasqueza/prueba-tecnica-imagine-apps.git
cd prueba-tecnica-imagine-apps

### 2.Levantar el Backend, Frontend Web y Base de Datos con Docker
```bash
docker-compose up --build



### 3.. Ejecutar la Aplicación Móvil (Flutter)
```bash
cd frontend_app
flutter pub get
flutter run


Autor
Nombre: Olmer Fernando Velasquez
Correo: olmervelasquez@hotmail.com
GitHub: https://github.com/ovelasqueza


¡Gracias por revisar este proyecto! Si tienes alguna pregunta o sugerencia, no dudes en contactarme.
