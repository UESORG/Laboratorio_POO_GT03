# Laboratorio 4: Consumo de REST API (Rick and Morty) & Pipeline CI/CD con GitHub Actions

## 1. Objetivo del Laboratorio
Desarrollar una API REST en **Spring Boot x** que consuma el servicio público de la **API de Rick and Morty**, e implementar la automatización de un pipeline de Integración Continua (CI) en **GitHub Actions** mediante un archivo YAML estructurado en **4 pasos (steps)**: ejecución de pruebas unitarias, compilación del proyecto, generación de una imagen de Docker y publicación de la imagen en **GitHub Container Registry (GHCR)**.

---

## 2. Requisitos de la Aplicación

### Consumo de Servicio Externo
La aplicación debe conectarse al servicio público de Rick and Morty:
* **URL Base Externa:** `https://rickandmortyapi.com/api`

### Especificación de los Endpoints
La API local debe exponer las siguientes rutas bajo la base `/api/rickandmorty`:

#### A. Obtener personaje por ID
* **Método:** `GET`
* **Ruta:** `/api/rickandmorty/personajes/{id}`
* **Respuestas esperadas:**
  * `200 OK`: Retorna la información simplificada del personaje (ej. `id`, `name`, `status`, `species`, `image`).
  * `404 Not Found`: Personaje no encontrado en la API externa.

#### B. Listar personajes
* **Método:** `GET`
* **Ruta:** `/api/rickandmorty/personajes`
* **Respuestas esperadas:**
  * `200 OK`: Retorna el listado de personajes procesados desde la API original.
  * `500 Internal Server Error`: Error de comunicación o falla en el servicio externo.

---

## 3. Configuración del Pipeline CI/CD (`.github/workflows/ci.yml`)

Debes crear el archivo de flujo de trabajo exactamente en la ruta:  
`.github/workflows/ci.yml`

El pipeline debe ejecutarse en un **único Job** que contenga secuencialmente los siguientes **4 pasos (steps)**:

1. **Step 1: Validaciones y Tests (`Run Tests`)**
   * Ejecutar las pruebas unitarias del proyecto.
2. **Step 2: Compilación (`Build Package`)**
   * Compilar el código y generar el paquete ejecutable `.jar`.
3. **Step 3: Construcción de Imagen Docker (`Build Docker Image`)**
   * Construir la imagen del contenedor.
4. **Step 4: Publicación en GHCR (`Push to GHCR`)**
   * Autenticarse contra el registro utilizando el token nativo y subir la imagen generada a GitHub Container Registry.

---

## 4. Rúbrica de Evaluación

> **Importante:** Sigue las indicaciones cuidadosamente; el incumplimiento de las normas o la falta de componentes afectará tu nota final.

| Criterio | Porcentaje | Descripción |
| :--- | :---: | :--- |
| **Código fuente en el repositorio y evidencias de consumo de API** | **20%** | Realizar *push* del código funcional hacia la rama correspondiente asignada por Classroom 50, con la estructura de proyecto Spring Boot correcta. |
| **Paso 1 (Step 1): Validación y Tests** | **20%** | Ejecución en verde ($\checkmark$) del paso de pruebas unitarias en GitHub Actions. |
| **Paso 2 (Step 2): Compilación** | **20%** | Compilación exitosa y generación del archivo `.jar` en GitHub Actions. |
| **Paso 3 (Step 3): Generación de Imagen Docker** | **20%** | Construcción correcta de la imagen contenedorizada. |
| **Paso 4 (Step 4): Publicación en GHCR** | **20%** | Publicación (push) completada en verde hacia GitHub Container Registry. |

---

## 5. Normas Obligatorias de Entrega

1. **Validación del Pipeline:** Cada paso (*step*) del workflow aportará un 20% a la nota final únicamente si el indicador en la pestaña **Actions** de GitHub finaliza con el icono verde de éxito.
2. **Entrega de la Tarea:** La evaluación se realizará directamente sobre el último *push* realizado en la rama principal antes de la fecha límite fijada.

## 6. Evidencias de consumo de API
> **Importante:** Pega aqui tus imagenes que respalden el consumo con el metodo GET de tu API.