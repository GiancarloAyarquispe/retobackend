# Automatización Backend - ServeRest API

Suite de pruebas de la API de usuarios de [ServeRest](https://serverest.dev/) con Karate DSL y JUnit 5. Cubre los cinco endpoints solicitados: listar, registrar, consultar por ID, actualizar y eliminar usuarios.

## Requisitos

- JDK 17 o superior.
- Maven 3.9 o superior.
- Acceso HTTPS a `serverest.dev`, o una instancia local de ServeRest.

## Ejecución

Desde esta carpeta:

```powershell
mvn test
```

La URL pública se usa por defecto. Para una instancia local:

```powershell
mvn -Plocal-api test
```

También se puede indicar una URL distinta sin editar archivos:

```powershell
mvn test "-Dserverest.url=http://localhost:3000"
```

Los reportes de Karate se generan en `target/karate-reports/`; el resultado JUnit queda en `target/surefire-reports/`.

## Cobertura

| Operación | Feature | Validaciones principales |
|---|---|---|
| `GET /usuarios` | `list-users.feature` | Estado HTTP, contrato JSON, cantidad y estructura de cada usuario |
| `POST /usuarios` | `create-user.feature` | Alta válida, esquema de respuesta, correo duplicado y datos inválidos |
| `GET /usuarios/{_id}` | `get-user.feature` | Consulta por ID y usuario inexistente |
| `PUT /usuarios/{_id}` | `update-user.feature` | Actualización, lectura posterior y datos inválidos |
| `DELETE /usuarios/{_id}` | `delete-user.feature` | Eliminación, esquema de respuesta y verificación posterior |

Los datos de prueba se generan con sufijos aleatorios para reducir colisiones. Las pruebas que crean usuarios los eliminan al finalizar el flujo; la suite no utiliza credenciales ni modifica registros preexistentes.

## Estrategia y patrones

La estrategia está documentada en [`docs/estrategia.md`](docs/estrategia.md). Se utiliza configuración centralizada para la URL, features organizados por endpoint, datos dinámicos y validaciones de esquema para evitar duplicación y mejorar la trazabilidad.
