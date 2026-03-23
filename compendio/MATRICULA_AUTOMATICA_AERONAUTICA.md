# 1. CONTEXTO GENERAL DEL SISTEMA

El sistema corresponde a un **Training Management System (TMS)** para una academia aeronáutica (Pilot Tips), encargado de:

-   Definir programas académicos complejos (teoría, observador, simulador)
-   Gestionar múltiples versiones e intensidades de programas
-   Controlar la progresión académica de estudiantes
-   Programar sesiones con restricciones operativas reales (instructores, simuladores, horarios)
-   Permitir distintos modelos de consumo:
    -   Programas estructurados
    -   Programas extendidos (ej. Línea Jet)
    -   Paquetes de sesiones
    -   Programas flexibles por horas

El sistema está diseñado bajo una **arquitectura desacoplada entre definición académica y ejecución operativa**, lo cual es clave para escalabilidad.

----------

# 🏗️ 2. ESTRUCTURA ARQUITECTÓNICA COMPLETA

## 🔷 2.1 Capa de Definición Académica (Program Builder)

program  
 ↓  
program_version  
 ↓  
program_structure_version  
 ↓  
program_module  
 ↓  
phase_session_template

----------

## 🔷 2.2 Capa de Ejecución (Runtime Académico)

enrollment  
 ↓  
student_phase_progress  
 ↓  
course_session  
 ↓  
reservation

----------

## 🔷 2.3 Flujo global

ADMIN (Program Builder)  
↓  
Define estructura académica (templates)  
↓  
STUDENT ENROLLMENT  
↓  
Generación de progreso  
↓  
Programación de sesiones  
↓  
Reservas reales

----------

# 🧩 3. TABLAS Y RELACIONES

## 🔹 3.1 Entidades de Programación Académica

### `program`

-   Entidad raíz
-   Define el programa base (ej. Transición Aerolínea)
-   Puede tener:
    -   `structure_type` (tipo de programa)
    -   `base_program_id` (herencia)

----------

### `program_version`

-   Variantes del programa
-   Ejemplo:
    -   COMPLETO
    -   HÍBRIDO
    -   LIGERO

Permite manejar diferencias en carga académica sin duplicar estructura base

----------

### `program_structure_version`

-   Versionado del contenido académico
-   Permite cambios sin afectar estudiantes antiguos

Relación:

program_version 1:N program_structure_version

----------

### `program_module`

-   Representa fases del programa

Ejemplo:

-   Fase Tierra
-   Fase Observador
-   Fase Simulador

Relación:

program_structure_version 1:N program_module

----------

### `phase_session_template`

-   Define cada sesión académica (template)

Contiene:

-   Orden (session_number)
-   Tipo (teoría, simulador, observador)
-   Duración
-   Modalidad
-   Reglas de scheduling
-   Restricciones (prerrequisitos)

Relación:

program_module 1:N phase_session_template

----------

## 🔹 3.2 Entidades de Ejecución Académica

### `enrollment`

-   Matrícula del estudiante
-   Define:
    -   programa
    -   versión
    -   `schedule_mode` (REGULAR / FLEXIBLE / PERSONALIZED)

----------

### `student_phase_progress`

-   Instancia del progreso del estudiante

Relación clave:

enrollment + phase_session_template → student_phase_progress

Propiedades:

-   estado
-   nota
-   bloqueo
-   referencia a sesión real

----------

### `course_session`

-   Sesión calendarizada real

Contiene:

-   fecha
-   hora
-   instructor
-   estado académico

Relación:

phase_session_template → course_session

----------

### `reservation`

-   Reserva operativa de recursos

Contiene:

-   estudiante
-   instructor
-   simulador
-   horario

----------

## 🔹 3.3 Relación completa

program  
 ↓  
program_version  
 ↓  
program_structure_version  
 ↓  
program_module  
 ↓  
phase_session_template  
 ↓  
student_phase_progress  
 ↓  
course_session  
 ↓  
reservation

----------

# 🔄 4. FLUJO LÓGICO DE DATOS

## 🔹 4.1 Definición del programa

1.  Se crea el programa base
2.  Se define una versión (Completo / Híbrido / Ligero)
3.  Se crea una estructura (v1, v2…)
4.  Se definen módulos (fases)
5.  Se crean sesiones (templates)

Resultado:  
→ Blueprint académico completo

----------

## 🔹 4.2 Matrícula del estudiante

1.  Se crea `enrollment`
2.  Se ejecuta inicialización:

phase_session_template → student_phase_progress

Resultado:  
→ El estudiante tiene todas sus sesiones instanciadas

----------

## 🔹 4.3 Programación académica

Dependiendo de:

-   `enrollment.schedule_mode`
-   `phase_session_template.scheduling_mode`

El sistema decide:

caso

comportamiento

AUTO

sistema agenda

STUDENT_RESERVE

estudiante reserva

ADMIN_ONLY

admin agenda

----------

## 🔹 4.4 Ejecución

1.  Se crea `course_session` (calendario)
2.  Se asigna instructor
3.  Se crea `reservation`
4.  Se actualiza progreso

----------

## 🔹 4.5 Reglas académicas

El sistema garantiza:

-   Orden secuencial obligatorio (no saltar sesiones)
-   Observadores antes de simulador
-   Control de número de sesiones por versión
-   Restricciones por instructor (ej. A320)
-   Control de paquetes y consumo de sesiones

----------

# 🧠 5. DECISIONES DE DISEÑO IMPORTANTES

## 5.1 Separación TEMPLATE vs RUNTIME

✔ `phase_session_template`  
✔ `student_phase_progress`

Permite:

-   no duplicar lógica
-   versionar contenido
-   mantener consistencia

----------

## 5.2 Versionado de programas

program_version  
program_structure_version

Permite:

-   evolución académica sin romper historial
-   múltiples estructuras activas

----------

## 5.3 Motor académico basado en reglas

Dos niveles:

### Nivel 1 (programa)

enrollment.schedule_mode

### Nivel 2 (sesión)

phase_session_template.scheduling_mode

Esto desacopla:

-   lógica global
-   comportamiento por sesión

----------

## 5.4 Arquitectura modular por fases

Uso de:

program_module

Permite:

-   separar tierra / observador / simulador
-   aplicar reglas por fase

----------

## 5.5 Soporte para múltiples modelos de negocio

El sistema soporta:

tipo

estructura

Programa estructurado

templates

Programa extendido

base_program_id

Paquetes simulador

control por saldo

Programas por horas

consumo dinámico

Ejemplo: Repaso Rápido permite distribución libre de horas

----------

## 5.6 Control de progresión estricta

El sistema controla:

-   prerrequisitos
-   orden académico
-   bloqueos por estado
-   evaluación por sesión

----------

## 5.7 Integración con recursos externos

-   Simuladores (turnos)
-   APIs externas (ej. SuperSaaS)
-   Disponibilidad de instructores

----------

# ✅ 6. CONCLUSIÓN ARQUITECTÓNICA

El sistema implementa una arquitectura **robusta, escalable y alineada a LMS/TMS profesionales**, basada en:

-   separación clara entre definición y ejecución
-   versionado completo de programas
-   motor académico basado en reglas
-   modelado por sesiones (granularidad alta)
-   soporte multi-programa y multi-modalidad
# 1. ENDPOINTS IMPLEMENTADOS (LÓGICA ACTUAL)

## 🔹 Autenticación y contexto

### `GET /api/student/me`

**Función:**

-   Obtener información del estudiante autenticado
-   Retorna:
    -   datos básicos
    -   enrollment activo
    -   versión del programa
    -   permisos de reserva

----------

### `POST /api/student/validate`

**Función:**

-   Validar acceso del estudiante por `student_code`
-   Determina:
    -   grupo de programación (1, 2, 3)
    -   si puede acceder en ese momento
    -   si puede reservar PF o PM

----------

## 🔹 Progreso académico

### `GET /api/student/progress`

**Función:**

-   Retorna progreso completo del estudiante:
    -   sesiones (template + calendarizadas)
    -   estado académico
    -   instructor asignado
    -   orden secuencial

----------

## 🔹 Reservas (Simulador)

### `GET /api/reservations/suggestions`

**Función:**

-   Genera sugerencias automáticas de reserva
-   Basado en:
    -   disponibilidad de simuladores
    -   disponibilidad de instructores
    -   reglas académicas
    -   PF restantes
    -   turnos

----------

### `POST /api/reservations`

**Función:**

-   Crea una reserva real
-   Flujo transaccional:
    -   valida estudiante
    -   valida enrollment activo
    -   valida PF disponibles
    -   valida turno
    -   crea booking externo (SuperSaaS)
    -   registra reserva interna

----------

## 🔹 Program Builder (parcial)

### `POST /api/admin/program-builder/program`

**Función:**

-   Crear programa base

⚠️ Actualmente:

-   No está conectado completamente con:
    -   program_version
    -   program_structure_version

----------

### `POST /api/admin/program-module`

**Función:**

-   Crear módulos (fases del programa)

----------

### `POST /api/admin/phase-session-template`

**Función:**

-   Crear sesiones académicas (template)

----------

# 🔄 2. FLUJO DE NEGOCIO

## 🔹 2.1 Autenticación

Login → JWT → authMiddleware → roleGuard

-   Usuario contiene:
    -   roles
    -   student_id
    -   instructor_id

----------

## 🔹 2.2 Flujo de matrícula (ENROLLMENT)

Admin crea usuario → rol STUDENT  
↓  
Asignación de program_version  
↓  
Creación de enrollment  
↓  
(esperado) initializeStudentProgress()

⚠️ Observación:

-   La inicialización de progreso no está completamente automatizada/confirmada

----------

## 🔹 2.3 Flujo de progreso académico

phase_session_template  
↓  
student_phase_progress  
↓  
(course_session opcional)  
↓  
visualización en /progress

-   Cada sesión del template genera una instancia por estudiante
-   Se enlaza con sesiones reales si existen

----------

## 🔹 2.4 Flujo de reservas

Student → suggestions  
↓  
Validaciones académicas  
↓  
Búsqueda de disponibilidad  
↓  
Selección de slot  
↓  
POST reservation  
↓  
Creación booking externo  
↓  
Persistencia interna

----------

## 🔹 2.5 Motor de scheduling

Decisión basada en:

enrollment.schedule_mode  
+  
phase_session_template.scheduling_mode

Caso

Comportamiento

AUTO

sistema agenda

STUDENT_RESERVE

estudiante reserva

ADMIN_ONLY

admin agenda

----------

# ✅ 3. VALIDACIONES IMPORTANTES

## 🔹 Académicas

-   No avanzar sin completar sesiones previas
-   Observadores obligatorios antes de simulador
-   Orden secuencial de sesiones
-   Control de número de sesiones por programa

----------

## 🔹 Enrollment

-   Debe estar `ACTIVE`
-   Un estudiante sin matrícula no puede reservar

----------

## 🔹 Reservas

-   Validación de:
    -   PF disponibles
    -   límite diario
    -   horario permitido
    -   tipo de tarifa (regular vs prime)

----------

## 🔹 Instructores

-   Validación por habilitación:
    -   A320 solo instructores habilitados
-   Uso exclusivo de disponibilidad reportada

----------

## 🔹 Disponibilidad

-   Validación contra:
    -   turnos
    -   bookings existentes
    -   recursos físicos (simuladores)

----------

# ⚠️ 4. PROBLEMAS DETECTADOS

## ❗ 4.1 Program Builder incompleto

-   No integra completamente:
    -   program_version
    -   program_structure_version
-   Creación de estructura no es automática ni consistente

----------

## ❗ 4.2 Inicialización de progreso

-   No está claramente automatizada:

enrollment → student_phase_progress

Riesgo:

-   estudiantes sin sesiones generadas
-   inconsistencias en progreso

----------

## ❗ 4.3 Duplicidad potencial en `course_session`

-   Tiene:
    -   program_course_id
    -   phase_session_template_id

Puede generar:

-   redundancia
-   ambigüedad en relaciones

----------

## ❗ 4.4 Falta de motor de reglas persistente

-   Reglas como:
    -   prerequisitos
    -   desbloqueo de fases
    -   evaluación requerida

Están en lógica de código, no en base de datos

----------

## ❗ 4.5 Scheduling parcial

-   Tierra no está completamente automatizada
-   Observadores no tienen flujo dual completo (auto vs reserva)

----------

## ❗ 4.6 Falta UI administrativa clave

-   No hay:
    -   panel de matrícula completo
    -   gestión visual de progreso
    -   gestión manual de sesiones

----------

# 📊 5. ESTADO ACTUAL DEL SISTEMA

## ✔️ FUNCIONANDO

-   Autenticación y roles
-   Creación de usuarios
-   Matrícula básica
-   Consulta de progreso
-   Motor de reservas simulador
-   Integración con SuperSaaS
-   Validaciones de disponibilidad
-   Lógica de turnos y recursos

----------

## ⚠️ PARCIAL

-   Program Builder (estructura incompleta)
-   Scheduling académico (tierra/observador)
-   Inicialización automática de progreso
-   UI administrativa

----------

## ❌ NO IMPLEMENTADO / PENDIENTE

-   Motor completo de progresión académica
-   Bloqueo automático por fases
-   Programación automática de clases tierra
-   Gestión de evaluaciones
-   Manejo completo de programas derivados (Jet, etc.)

----------

# 🚀 6. SIGUIENTES PASOS RECOMENDADOS

## 🔴 PRIORIDAD ALTA

### 1. Inicialización de progreso

enrollment → generar student_phase_progress

Debe ser:

-   automático
-   transaccional
-   consistente con template

----------

### 2. Program Builder completo

Implementar flujo completo:

program  
→ program_version  
→ program_structure_version  
→ program_module  
→ phase_session_template

----------

### 3. Scheduling de clases tierra (AUTO)

-   Generar automáticamente:
    -   16 clases tierra
-   Basado en:
    -   schedule_mode
    -   disponibilidad

----------

### 4. Bloqueo académico por fases

Implementar reglas:

no simulador sin observador  
no observador sin tierra

----------

## 🟡 PRIORIDAD MEDIA

### 5. UI administrativa

-   Matrícula completa
-   Visualización de progreso
-   Edición de sesiones

----------

### 6. Motor de reglas en BD

Crear tablas tipo:

phase_rules

Para:

-   prerequisitos
-   desbloqueos
-   evaluaciones

----------

### 7. Observadores híbridos

Permitir:

-   AUTO
-   STUDENT_RESERVE

----------

## 🟢 PRIORIDAD BAJA (ESCALABILIDAD)

### 8. Programas derivados (base_program_id)

-   herencia de estructura
-   extensiones tipo Jet

----------

### 9. Optimización de scheduling

-   balanceo de instructores
-   priorización por programa
-   optimización de recursos

----------

# ✅ CONCLUSIÓN FINAL

El sistema ya tiene:

✔ Motor de reservas sólido  
✔ Modelo académico bien estructurado  
✔ Separación clara entre template y ejecución

Pero aún le falta:

❗ Automatización académica completa  
❗ Program Builder conectado a toda la jerarquía  
❗ Motor de progresión formal
