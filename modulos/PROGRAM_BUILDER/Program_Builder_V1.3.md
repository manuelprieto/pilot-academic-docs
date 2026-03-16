# 1. OBJETIVO DEL MÓDULO PROGRAM BUILDER
V1.3 11/03/26
El **Program Builder** es el módulo administrativo que permite **diseñar el currículo académico completo** de un programa de entrenamiento de aviación.

Define:

```
Programa
   ↓
Versiones del programa
   ↓
Estructura académica
   ↓
Módulos
   ↓
Sesiones

```

Esto representa **el blueprint académico**.

NO gestiona:

```
course_session
reservation
student_progress

```

Esos pertenecen al **motor académico operativo**.

----------

# 2. MODELO DE DATOS UTILIZADO

Tablas relacionadas con el Program Builder.

```
program
program_version
program_structure_version
program_module
phase_session_template

```

Jerarquía:

```
program
   ↓
program_version
   ↓
program_structure_version
   ↓
program_module
   ↓
phase_session_template

```

----------

# 3. TABLAS Y SU FUNCIÓN

## program

Define el programa académico.

Ejemplo:

```
Transición Aerolínea
A320 Type Rating

```

Campos relevantes:

```
id
name
priority_level
time_limit_months

```

----------

## program_version

Define **modalidades del programa**.

Ejemplo:

```
Completo
Híbrido
Ligero

```

Campos:

```
id
program_id
code
name
active

```

----------

## program_structure_version

Permite **versionar el currículo**.

Ejemplo:

```
Completo v1
Completo v2

```

Esto permite cambiar programas sin afectar estudiantes antiguos.

----------

## program_module

Representa las fases académicas.

Ejemplo:

```
Fase Tierra
Fase Observador
Fase Simulador

```

----------

## phase_session_template

Define cada sesión del programa.

Ejemplo:

```
Introducción Jet
PF Jet
Simulador 1

```

----------

# 4. ENDPOINTS IMPLEMENTADOS

## PROGRAM ENDPOINTS

### Crear programa

```
POST /api/admin/program-builder/program

```

Objetivo:

Crear un programa académico.

----------

### Obtener programas

```
GET /api/admin/program-builder/programs

```

Objetivo:

Mostrar lista en **Program Builder Home**.

----------

### Obtener estructura del programa

```
GET /api/admin/program-builder/:programId

```

Objetivo:

Cargar módulos y sesiones del programa.

----------

# 5. PROGRAM VERSION ENDPOINTS

## Crear versión

```
POST /api/admin/program-version

```

Objetivo:

Crear modalidades del programa.

Ejemplo:

```
TA-COMP
TA-HYB
TA-LIG

```

----------

## Listar versiones

```
GET /api/admin/program-version/:programId

```

Objetivo:

Mostrar versiones del programa en UI.

----------

# 6. MODULE ENDPOINTS

## Crear módulo

```
POST /api/admin/program-builder/program-module

```

Objetivo:

Crear fases académicas.

Ejemplo:

```
Fase Tierra
Fase Observador
Fase Simulador

```

----------

# 7. SESSION TEMPLATE ENDPOINTS

## Crear sesión

```
POST /api/admin/program-builder/phase-session-template

```

Objetivo:

Crear sesiones dentro de un módulo.

----------

## Actualizar sesión

```
PUT /api/admin/program-builder/phase-session-template/:id

```

Objetivo:

Editar sesiones.

----------

## Eliminar sesión

```
DELETE /api/admin/program-builder/phase-session-template/:id

```

Objetivo:

Eliminar sesiones.

----------

## Obtener sesiones del módulo

```
GET /api/admin/program-builder/module/:moduleId/sessions

```

Objetivo:

Mostrar sesiones del módulo.

----------

# 8. BACKEND FILES CREADOS

## Services

```
services/programBuilder/programBuilder.service.js
services/programBuilder/programVersion.service.js

```

Responsabilidad:

Acceso a base de datos.

----------

## Controllers

```
controllers/admin/programBuilderController.js
controllers/admin/programVersionController.js

```

Responsabilidad:

Procesar requests HTTP.

----------

## Routes

```
routes/admin/programBuilder.routes.js
routes/admin/programVersion.routes.js

```

Responsabilidad:

Definir endpoints.

----------

## Database

```
src/db.js

```

Conexión a PostgreSQL.

----------

# 9. FRONTEND ARCHIVOS CREADOS

Ubicación:

```
src/admin/programBuilder/

```

----------

## Páginas

```
ProgramBuilderHome.jsx
CreateProgram.jsx
ProgramStructure.jsx
ProgramVersions.jsx
ModuleSessions.jsx

```

----------

## Componentes

```
CreateModuleModal.jsx
CreateSessionModal.jsx
CreateVersionModal.jsx
ProgramTimeline.jsx

```

----------

## Servicios API

```
programBuilder.api.js

```

Responsabilidad:

Conectar frontend con backend.

Ejemplo:

```
axios.post("/api/admin/program-version")

```

----------

# 10. FLUJO DE LA UI

### Admin Dashboard

```
Admin Dashboard
      ↓
Program Builder

```

----------

### Program Builder Home

Lista programas.

```
Transición Aerolínea
A320 Refresher

```

----------

### Crear programa

```
CreateProgram.jsx

```

Formulario.

----------

### Program Versions

```
Completo
Híbrido
Ligero

```

----------

### Program Structure

Módulos del programa.

```
Fase Tierra
Fase Observador
Fase Simulador

```

----------

### Module Sessions

Sesiones del módulo.

```
Introducción Jet
PF Jet
Simulador 1

```

----------

# 11. FUNCIONALIDADES YA IMPLEMENTADAS

### Backend

✔ Crear programa

✔ Listar programas

✔ Crear versiones

✔ Listar versiones

✔ Crear módulos

✔ Crear sesiones

✔ Editar sesiones

✔ Eliminar sesiones

----------

### Frontend

✔ Program Builder Home

✔ Crear programa

✔ Ver versiones

✔ Crear versiones

✔ Ver módulos

✔ Ver sesiones

✔ Crear sesiones

----------

# 12. FUNCIONALIDADES PENDIENTES

## Structure Builder

Endpoint pendiente:

```
POST /program-structure-version

```

----------

## Activar estructura

```
PUT /program-structure-version/activate

```

----------

## Clonar versiones

Muy importante para academias.

```
clone structure

```

----------

## Drag & Drop de sesiones

Para ordenar currículo.

----------

## Visualización completa del programa

Timeline académico.

----------

# 13. RELACIÓN CON EL SISTEMA ACADÉMICO

El builder genera el currículo que luego usa el motor académico.

Flujo completo:

```
PROGRAM BUILDER
(program → modules → sessions)
        ↓
ENROLLMENT
(student enters program)
        ↓
initializeStudentProgress()
        ↓
student_phase_progress
        ↓
Scheduling
        ↓
course_session
        ↓
reservation

```

----------

# 14. ESTADO DEL SISTEMA

El **Program Builder está aproximadamente al 70-80%**.

Ya permite:

```
Diseñar programas
Versionarlos
Crear módulos
Crear sesiones

```

Faltan:

```
structure management
clonado de versiones
timeline avanzado

```

----------

# 15. RESULTADO

Estás construyendo un **Training Management System (TMS)** similar a los usados por:

```
CAE
FlightSafety
Airbus Training
Lufthansa Aviation Training

```

El **Program Builder es el corazón académico del sistema**.
