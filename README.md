# Laboratorio 3: API REST - Entregas POO

Este repositorio contiene la plantilla base para el desarrollo del laboratorio de **Programación Orientada a Objetos**. Los estudiantes deberán desarrollar una API REST en Java (Spring Boot) conectada a la base de datos remota PostgreSQL en AWS RDS.

---

## 1. Parámetros de Conexión a la Base de Datos

Cada estudiante debe configurar su aplicación utilizando sus credenciales individuales provistas en el documento del laboratorio en campus:

* **Host / Server:** `<ENDPOINT_DE_TU_INSTANCIA_RDS>`
* **Puerto:** `PORT`
* **Database:** `NOMBRE_DB`
* **Usuario:** Tu carnet en **MAYÚSCULAS** *(Ejemplo: `TJ10002`)*
* **Contraseña:** `PASS`

---

## 2. Mapeo de la Entidad en la Base de Datos

La API debe mapear exactamente la siguiente tabla y columnas en PostgreSQL:

* **Nombre de la tabla:** `entregas_laboratorio`
* **Campos obligatorios:**
  * `carnet` (String / Primary Key)
  * `correo` (String)
  * `apellidos` (String)
  * `nombres` (String)

*(Importante: Asegúrate de anotar tu entidad JPA con `@Table(name = "entregas_laboratorio")`).*

---

## 3. Configuración de Variables de Entorno (OBLIGATORIO)

Queda **estrictamente prohibido** escribir contraseñas o endpoints de la base de datos en texto plano dentro de los archivos del proyecto (`application.properties`, clases de Java, etc.).

Debes configurar y leer las siguientes tres variables de entorno desde tu sistema operativo o IDE:

* `DB_URL`
* `DB_USER`
* `DB_PASSWORD`

### Ejemplo en `application.properties`:
```properties
spring.datasource.url=${DB_URL}
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=org.postgresql.Driver