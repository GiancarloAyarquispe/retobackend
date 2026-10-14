# Estrategia de automatización

## Alcance y trazabilidad

La suite verifica la historia de usuario de administración de usuarios y sus cinco criterios de aceptación. Cada operación tiene un feature dedicado; los escenarios negativos y las comprobaciones de contrato se mantienen junto al endpoint correspondiente.

## Capas de validación

- **Funcional:** lectura de la colección, alta, consulta por identificador, actualización y eliminación.
- **Negativa:** correo duplicado, datos requeridos ausentes o inválidos e identificadores inexistentes.
- **Contrato:** tipos y campos de respuestas JSON para colección, entidad y mensajes de operación.
- **Integración:** solicitudes HTTP reales a ServeRest; no se simula la API.

## Datos de prueba y aislamiento

El helper `user-data.js` genera nombre, correo y contraseña aleatorios por ejecución. Los escenarios crean únicamente registros con esa marca, verifican el resultado y eliminan los usuarios creados. No se reutilizan datos de personas ni se requiere una cuenta administrativa.

## Patrones aplicados

- **Feature por recurso/operación:** facilita localizar fallos y mantener cobertura CRUD.
- **Configuración centralizada:** `karate-config.js` define la URL de destino y permite cambiarla con `-Dserverest.url`.
- **Datos dinámicos:** evita colisiones entre ejecuciones concurrentes o repetidas.
- **Contrato explícito:** aserciones de estado, estructura, tipos y contenido de respuesta.

## Consideraciones

La URL por defecto es un servicio público de demostración y puede presentar indisponibilidad o cambios de datos ajenos a la suite. Para ejecución repetible de equipo, se recomienda usar una instancia controlada. No se ejecutan pruebas de carga ni se considera esta suite una validación de seguridad de producción.
