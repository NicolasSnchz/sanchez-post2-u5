# \# Laboratorio Unidad 5 - Cliente HTTP con Dio

# 

# \## Autor

# 

# Nicolas Sanchez

# 

# \## Descripción

# 

# Aplicación móvil desarrollada en Flutter para la Unidad 5 de Aplicaciones Móviles.

# 

# La aplicación consume la API pública JSONPlaceholder y muestra una lista de posts utilizando Dio como cliente HTTP, Riverpod como gestor de estado, json\_serializable para la generación de modelos serializables, scroll infinito, pull-to-refresh y manejo de errores de red tipados con DioException.

# 

# \## Tecnologías utilizadas

# 

# \- Flutter

# \- Dart

# \- Dio

# \- Riverpod

# \- json\_serializable

# \- build\_runner

# \- JSONPlaceholder API

# \- Android Studio

# \- GitHub Desktop

# 

# \## Requisitos

# 

# \- Flutter SDK 3.19 o superior

# \- Dart 3.x

# \- Android Studio

# \- Emulador Android o dispositivo físico

# \- Git

# \- GitHub Desktop

# 

# \## Instalación y ejecución

# 

# Clonar el repositorio:

# 

# ```bash

# git clone https://github.com/TU\_USUARIO/sanchez-post2-u5.git

# ```

# 

# Entrar al proyecto:

# 

# ```bash

# cd dio\_lab

# ```

# 

# Instalar dependencias:

# 

# ```bash

# flutter pub get

# ```

# 

# Generar archivos de serialización:

# 

# ```bash

# flutter pub run build\_runner build --delete-conflicting-outputs

# ```

# 

# Ejecutar la aplicación:

# 

# ```bash

# flutter run

# ```

# 

# \## Endpoint utilizado

# 

# La aplicación consume el endpoint público:

# 

# ```text

# https://jsonplaceholder.typicode.com/posts

# ```

# 

# La paginación se realiza utilizando los parámetros:

# 

# ```text

# \_page

# \_limit

# ```

# 

# Ejemplo de solicitud:

# 

# ```text

# https://jsonplaceholder.typicode.com/posts?\_page=1\&\_limit=15

# ```

# 

# \## Funcionalidades implementadas

# 

# \- Cliente HTTP con Dio.

# \- Configuración de BaseOptions.

# \- Interceptor de autenticación simulada.

# \- Interceptor de logging.

# \- DTO serializable con json\_serializable.

# \- Generación automática con build\_runner.

# \- Modelo de dominio separado del DTO.

# \- Mapper de DTO a modelo de dominio.

# \- Consumo del endpoint `/posts`.

# \- Paginación con `\_page` y `\_limit`.

# \- Scroll infinito.

# \- Pull-to-refresh.

# \- Estado de carga.

# \- Estado de éxito.

# \- Estado vacío.

# \- Estado de error.

# \- Manejo de errores tipados con DioException.

# 

# \## Manejo de errores

# 

# La aplicación convierte los errores de DioException en errores de dominio:

# 

# \- NetworkError

# \- UnauthorizedError

# \- NotFoundError

# \- ServerError

# \- UnknownError

# 

# Cuando el dispositivo no tiene conexión a internet, la aplicación muestra el mensaje:

# 

# ```text

# Sin conexión a internet.

# ```

# 

# Además, se muestra un botón para reintentar la carga de datos.

# 

# \## Flujo de la aplicación

# 

# Al iniciar la app, se realiza una solicitud GET a la API de JSONPlaceholder para obtener la primera página de posts.

# 

# Los datos recibidos se convierten primero en objetos `PostDto`. Luego, mediante un mapper, se transforman en objetos de dominio `Post`.

# 

# La interfaz muestra los posts en una lista. Cuando el usuario baja hasta el final, se solicita automáticamente la siguiente página y los nuevos posts se agregan a la lista sin eliminar los anteriores.

# 

# También se implementa pull-to-refresh para recargar la información desde la primera página.

# 

# \## Estructura del proyecto

# 

# ```text

# lib

# ├── data

# │   └── remote

# │       ├── dto

# │       │   ├── post\_dto.dart

# │       │   └── post\_dto.g.dart

# │       ├── network

# │       │   └── dio\_client.dart

# │       └── service

# │           └── post\_service.dart

# ├── domain

# │   └── model

# │       └── post.dart

# ├── presentation

# │   ├── providers

# │   │   └── posts\_provider.dart

# │   └── screens

# │       └── posts\_screen.dart

# └── main.dart

# ```

# 

# \## Evidencias

# 

# \### Lista cargada

# 

# !\[Lista cargada](evidencias/captura\_1\_lista\_cargada.png)

# 

# \### Estado de carga

# 

# !\[Loading](evidencias/captura\_2\_loading.png)

# 

# \### Error de red

# 

# !\[Error de red](evidencias/captura\_3\_error\_red.png)

# 

# \## Commits principales

# 

# \- Crea proyecto Flutter base

# \- Configura dependencias de red y serialización

# \- Implementa cliente Dio y consumo de posts

# \- Documenta evidencias del laboratorio

# 

# \## Estado final

# 

# La aplicación compila correctamente, consume datos desde JSONPlaceholder, muestra una lista de posts, permite scroll infinito, soporta pull-to-refresh y maneja errores de red mostrando mensajes claros al usuario.

