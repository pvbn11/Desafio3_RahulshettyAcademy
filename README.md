# Desafio3_RahulshettyAcademy
Proyecto de automatización de APIs de la plataforma "https://rahulshettyacademy.com/practice" utilizando las APIs de "Library Management System" y el framework de automatización **Karate DSL** para validar los casos de negocio solicitados.

## Repositorio del Proyecto

Puedes encontrar el código fuente y la documentación completa en:
https://github.com/pvbn11/Desafio3_RahulshettyAcademy

## Requisitos
- Java JDK 17 o superior.
- Apache Maven.

### Entorno de Desarrollo
- **IDE:** IntelliJ IDEA (Recomendado por su excelente soporte para proyectos Java/Maven).
- **Plugins:** Cucumber for Java (para visualización de archivos `.feature`) y Karate DSL plugin.
- **Postman:** Para pruebas manuales y generación de payloads.
- **Git:** Para control de versiones y colaboración.
- **Navegador:** Google Chrome o Firefox para inspeccionar respuestas y depurar.
- **Nota:** Asegúrate de tener configurado el JDK y Maven en tu sistema para ejecutar los tests correctamente.
- **Karate DSL:** Framework de automatización de pruebas para servicios REST, que permite escribir tests en un formato legible y fácil de mantener.
- **API de PetStore:** API pública que simula una tienda de mascotas, utilizada para practicar y demostrar pruebas de servicios REST.

## Estructura del Proyecto
- `src/test/java/features/`: Contiene los escenarios (`.feature`) de prueba como el (`library.feature`) que contiene las validaciones funcionales y (`pruebaIntegralLibrary.feature`) que contiene la validacion integral del servicio.
- `src/test/java/body/`: Archivos JSON con los payloads de las peticiones.
- `src/test/java/headers/`: Archivos JSON con la configuración de cabeceras.
- `karate-config.js`: Configuración de ambientes (dev, e2e).

## Ejecución
Ejecuta los tests mediante Maven:
```bash
mvn test
