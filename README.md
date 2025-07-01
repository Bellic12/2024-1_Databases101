# Sistema de Base de Datos - Área de Bienestar UNAL Bogotá

## 📋 Descripción del Proyecto

Este proyecto académico presenta el desarrollo de un sistema de base de datos para el Área de Bienestar de la Universidad Nacional de Colombia, Sede Bogotá. El sistema fue diseñado para gestionar de forma integral los servicios que brinda Bienestar Universitario a la comunidad académica, abarcando desde la administración de cursos y beneficios socioeconómicos hasta el seguimiento de programas de acompañamiento integral.

**Estado del proyecto:** ⏸️ **Desarrollo pausado** - Aproximadamente 75% completado. No se continuará su desarrollo activo por parte del equipo original.

El Área de Bienestar promueve el desarrollo integral de la comunidad universitaria, contribuyendo a la calidad de vida mediante la formación integral, la inclusión social y el fortalecimiento académico y laboral. Este sistema refleja esa complejidad organizacional, modelando las cinco subáreas principales: Actividad Física y Deportes, Salud, Acompañamiento Integral, Cultura, y Gestión y Fomento Socioeconómico.

## 🎯 Objetivos del Sistema

El sistema fue concebido para automatizar y optimizar la gestión de los múltiples servicios que ofrece Bienestar Universitario. Permite el registro y seguimiento de estudiantes, empleados y beneficiarios, la administración de convocatorias e inscripciones, el control de cupos en cursos y actividades, y la gestión de beneficios socioeconómicos con sus respectivas horas de corresponsabilidad.

Uno de los aspectos clave del diseño es el manejo integral de la información académica y socioeconómica de los estudiantes, incluyendo su P.A.P.A (Promedio Aritmético Ponderado Acumulado), porcentaje de avance y pertenencia a programas especiales como PEAMA o PAES, lo que determina su elegibilidad para diferentes beneficios y servicios.

## 🏗️ Arquitectura y Desarrollo Técnico

### Modelado de Datos

El desarrollo comenzó con una investigación detallada del funcionamiento del Área de Bienestar, lo que permitió identificar las entidades clave y sus relaciones. Se creó un Modelo Entidad/Relación completo, posteriormente implementado como Modelo Relacional en MySQL Workbench.

La base de datos fue normalizada hasta la Cuarta Forma Normal (4NF), eliminando redundancias y asegurando la integridad de los datos. Esta normalización fue esencial para optimizar el almacenamiento y mejorar el rendimiento de las consultas, dada la complejidad de las relaciones entre estudiantes, empleados, cursos, beneficios y subáreas de Bienestar.

### Implementación en MySQL

La base de datos fue implementada completamente en MySQL, con todas las tablas definidas incluyendo tipos de datos, claves primarias y foráneas. Se crearon índices estratégicos (B-Tree y Hash) para mejorar el rendimiento de consultas complejas, especialmente aquellas con múltiples JOINs.

Se cargaron datos realistas mediante inserción manual y archivos CSV, representando fielmente escenarios reales del Área de Bienestar. Esto incluye estudiantes con distintos perfiles académicos, empleados con roles definidos, cursos específicos por área y beneficios con distintos criterios de elegibilidad.

### Consultas y Lógica de Negocio

Se diseñaron consultas SQL avanzadas utilizando JOINs, subconsultas, agregaciones y funciones de agrupamiento, permitiendo obtener información como participación estudiantil en cursos, disponibilidad de cupos y seguimiento de horas de corresponsabilidad.

Cada consulta fue también formulada en Álgebra Relacional, lo que proporciona una base teórica sólida que valida la implementación y apoya el diseño relacional.

### Programación Avanzada en Base de Datos

El sistema incluye lógica de negocio implementada en la base de datos mediante procedimientos almacenados, triggers y funciones personalizadas. Estas estructuras permiten operaciones complejas como inscripciones, asignación de beneficios y manejo de convocatorias, con transacciones que aseguran la consistencia de los datos.

Los triggers automatizan procesos clave como la actualización de cupos, validación de requisitos y mantenimiento de la integridad referencial durante operaciones complejas.

## 👥 Sistema de Usuarios y Permisos

Se implementó un sistema de permisos basado en roles, alineado con la estructura organizacional del Área de Bienestar. Se definieron cuatro perfiles: Administrador de BD, Persona U (estudiantes y comunidad), Empleados (directores de curso y personal de apoyo) y Jefes (personal administrativo con funciones directivas).

Se desarrollaron matrices CRUD detalladas y una matriz de permisos `EXECUTE` para el uso de procedimientos almacenados, asegurando un acceso controlado y seguro según el perfil del usuario.

## 📊 Estado Actual del Desarrollo

### Componentes Completados

* Implementación completa del modelo relacional con todas las tablas, vistas, índices, triggers y procedimientos almacenados.
* Documentación técnica detallada: diccionario de datos, diagramas E/R, y equivalencias en álgebra relacional.
* Wireframes preliminares para la interfaz gráfica.
* Análisis comparativo con modelos NoSQL (formato JSON, documentos embebidos, redundancia).

### Desarrollo de Interfaz

Se desarrolló una interfaz gráfica parcial que permite interacción básica con la base de datos según el rol de usuario. Esta interfaz emplea procedimientos almacenados para la modificación de datos y vistas para la consulta segura, protegiendo información sensible.

El frontend permite funcionalidades principales por perfil: los estudiantes consultan su información académica y de inscripciones; los empleados gestionan cursos y actividades; y los administradores acceden a reportes y configuraciones del sistema.

### Componentes Pendientes

* Integración completa entre frontend y backend.
* Implementación de un sistema de autenticación más robusto.
* Desarrollo de módulos para reportes dinámicos y análisis avanzados.
* Optimización de consultas complejas y pruebas unitarias.

## 🚀 Instalación y Configuración

Para utilizar este sistema necesitas MySQL Server 8.0 o superior y, preferiblemente, MySQL Workbench para la visualización de diagramas. Clona el repositorio y ejecuta los scripts SQL en el orden indicado:

1. Creación de la base de datos y tablas.
2. Inserción de datos de ejemplo.
3. Creación de procedimientos almacenados y triggers.

El proyecto está estructurado con carpetas separadas para documentación, scripts SQL y archivos de frontend/backend. Todos los archivos están comentados para facilitar su comprensión y mantenimiento.

## 🤝 Estado del Proyecto y Oportunidades Futuras

Este proyecto fue desarrollado como parte de la asignatura de Bases de Datos en el programa de Ingeniería de Sistemas de la Universidad Nacional de Colombia. Su desarrollo se encuentra **pausado indefinidamente**, habiendo cumplido su propósito académico.

No obstante, constituye una base sólida para su posible ampliación o uso en futuros desarrollos relacionados con la gestión universitaria. La normalización avanzada, el sistema de permisos y la lógica de negocio lo hacen escalable y adaptable a nuevas necesidades.

## 📖 Documentación Técnica

La documentación cubre todo el proceso de desarrollo: análisis del dominio, diseño conceptual y lógico, implementación, pruebas, y comparativa con modelos NoSQL. Se incluyen diagramas detallados, diccionarios de datos, análisis de normalización y ejemplos prácticos de consultas y procedimientos.

Este material resulta útil para estudiantes o desarrolladores interesados en bases de datos relacionales complejas y sistemas de información universitarios.

## 📄 Licencia

Este proyecto está disponible bajo la Licencia MIT, permitiendo su uso libre para fines educativos, comerciales o de investigación. Se requiere conservar la atribución al equipo original y mantener el texto completo de la licencia en cualquier redistribución del código.

---

⭐ **Si este proyecto te resulta útil, considera dejar una estrella en GitHub para apoyar futuros desarrollos** ⭐
