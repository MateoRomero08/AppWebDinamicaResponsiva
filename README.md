# TICKET1 – Aplicación Web Dinámica y Responsiva (Java + JSP + MySQL)

TICKET1 es una aplicación web diseñada para la gestión de reservas y actividades mediante roles diferenciados: **admin** y **usuario**. Permite validar credenciales, mostrar paneles dinámicos, gestionar actividades y evitar dobles reservas.

---

## Características principales
- Autenticación por roles (admin / usuario)
- Panel responsivo y dinámico según el tipo de usuario
- CRUD de perfiles y actividades
- Prevención de reservas duplicadas
- Validación de campos vacíos
- Conexión a MySQL vía JDBC
- Despliegue en Apache Tomcat

---

## Tecnologías utilizadas
- Java (JSP + Servlets)
- HTML5, CSS3, JavaScript
- MySQL
- NetBeans 21
- Apache Tomcat
- MVC

---
## Estructura del proyecto
Ticket1App/
│
├── nbproject/ → Configuración de NetBeans
├── src/ → Código fuente Java (Servlets, controladores, lógica)
├── web/ → Archivos JSP, CSS, JS e interfaces
├── build.xml → Archivo de construcción del proyecto
---

## Documentación del proyecto

Toda la documentación completa se encuentra en:

📁 `docs/INFORME TICKET 1 APP WEB MR.pdf`

Incluye:

- Descripción del problema
- Objetivos del proyecto
- Requerimientos funcionales y no funcionales
- Modelo Entidad-Relación (MER)
- Alcance del sistema
- Resultados
- Conclusiones
- Ficha técnica del software

---
## Base de Datos (MySQL)

El proyecto incluye un script SQL con la estructura y datos iniciales para ejecutar la aplicación.  
El archivo está disponible en:

📁 `database/ticket1_database.sql`

### **Contenido del script SQL**
El archivo SQL contiene:

- Creación de la base de datos
- Tablas principales:
  - Usuarios / Perfiles
  - Actividades
  - Citas o asignaciones
- Relaciones y llaves foráneas
- Datos iniciales para pruebas (si existen)


##  Cómo ejecutar el proyecto

### **1. Importar en NetBeans**
- Abrir NetBeans
- File → Open Project
- Seleccionar carpeta del proyecto

### **2. Configurar la base de datos**
- Crear base de datos MySQL
- Importar estructura (si tienes el `.sql`, puedes añadirlo al repo)
- Configurar los parámetros de conexión en tu clase JDBC

### **3. Ejecutar en Tomcat**
- Seleccionar Apache Tomcat 10
- Deploy / Run Project

### **4. Iniciar sesión**
- Usuario Admin → acceso completo
- Usuario normal → panel de actividades y citas

---

##  Arquitectura (MVC)

- **Modelo:** Conexión JDBC, consultas a MySQL, manejo de datos.
- **Vista:** JSP + HTML + CSS + JS.
- **Controlador:** Servlets que manejan rutas, lógica, sesiones y validaciones.

---
## Autor

**Oscar Mateo Romero Castro**  
Estudiante de Ingeniería de Sistemas  
Universidad de San Buenaventura  
Proyecto académico — 2025

---

## Licencia

Uso académico y demostrativo.  
Para uso comercial se requiere autorización del autor.
