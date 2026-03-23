# AVIATION ACADEMIC SYSTEM

## 🧠 Resumen Técnico de Arquitectura (Paso 1/2)

----------

# 1. 📌 Contexto General del Sistema

El sistema corresponde a una plataforma académica especializada en entrenamiento aeronáutico, diseñada para gestionar:

-   Programas de formación (ej. Transición Aerolínea)
-   Versiones comerciales del programa (Completo, Híbrido, etc.)
-   Estructura curricular versionada
-   Progresión académica por estudiante
-   Ejecución de sesiones (teoría, observador, simulador)
-   Integración con agenda operativa (reservas)

El sistema sigue principios de:

-   **Normalización de datos**
-   **Versionamiento académico**
-   **Separación entre estructura y ejecución**
-   **Escalabilidad tipo LMS (Learning Management System)**

----------

# 2. 🏗 Estructura Arquitectónica Completa

## 🔷 Jerarquía Académica

program  
 ↓  
program_version  
 ↓  
program_structure_version  
 ↓  
program_phase  
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

## 🔹 Descripción por nivel

### 2.1 program

Entidad raíz.

Representa el producto académico:

Ejemplo:

-   Transición Aerolínea

----------

### 2.2 program_version

Define variaciones del programa:

-   Completo
-   Híbrido
-   Flexible

Permite:

-   Diferentes duraciones
-   Diferentes reglas
-   Diferente intensidad académica

----------

### 2.3 program_structure_version

Versiona la estructura académica.

Permite:

-   Cambiar malla curricular sin afectar estudiantes antiguos
-   Mantener historial académico consistente

Ejemplo:

-   Completo v1 (2025)
-   Completo v2 (2026)

----------

### 2.4 program_phase

Agrupa etapas del entrenamiento:

-   Tierra
-   Observador
-   Simulador

Representa el flujo macro del programa.

----------

### 2.5 program_module

Unidad organizativa dentro de la fase.

En la implementación actual:

program_module ≈ fase operativa

Ejemplo:

-   Fase Tierra
-   Fase Observador
-   Fase Simulador

(En evolución futura puede desacoplarse de phase)

----------

### 2.6 phase_session_template

Define la estructura académica base.

Contiene:

-   Número de sesión
-   Nombre
-   Duración
-   Tipo (THEORY / OBSERVER / SIMULATOR)
-   Orden

Ejemplo:

-   Despacho 1
-   CRM
-   Navegación 3

Es **plantilla**, no ejecución.

----------

### 2.7 student_phase_progress

Instancia académica por estudiante.

Representa:

-   Progreso real del estudiante
-   Estado por sesión

Estados típicos:

-   LOCKED
-   PENDING
-   IN_PROGRESS
-   COMPLETED

Es la **fuente de verdad del progreso académico**.

----------

### 2.8 course_session

Representa una sesión ejecutada (real).

Incluye:

-   Fecha
-   Hora
-   Instructor
-   Relación con progreso
-   Relación con reserva

Se crea cuando la sesión ocurre realmente.

----------

### 2.9 reservation

Gestión operativa de recursos.

Aplica a:

-   Simulador
-   (futuro) Observador

Integra:

-   Disponibilidad
-   Recursos físicos
-   Agenda externa (ej. SuperSaaS)

----------

# 3. 🗄 Tablas y Relaciones

## 🔗 Relaciones principales

program (1)  
 → program_version (N)  
  
program_version (1)  
 → program_structure_version (N)  
  
program_structure_version (1)  
 → program_module (N)  
  
program_phase (1)  
 → program_module (N)  
  
program_module (1)  
 → phase_session_template (N)  
  
phase_session_template (1)  
 → student_phase_progress (N)  
  
student (1)  
 → enrollment (N)  
  
enrollment (1)  
 → student_phase_progress (N)  
  
student_phase_progress (1)  
 → course_session (0..1)  
  
course_session (1)  
 → reservation (0..1)

----------

## 🔹 Entidad clave: enrollment

enrollment  
-------------  
student_id  
program_version_id  
program_structure_version_id  ← congelado

Función:

-   Vincular estudiante con programa
-   Congelar la estructura académica
-   Disparar generación de progreso

----------

# 4. 🔄 Flujo Lógico de Datos

## 4.1 Registro

user_account  
 ↓  
student

Sin programa asignado.

----------

## 4.2 Matrícula

student  
 ↓  
enrollment  
 ↓  
program_structure_version (activa)  
 ↓  
phase_session_template  
 ↓  
student_phase_progress (instanciado)

Resultado:

-   Se generan automáticamente todas las sesiones del programa
-   Primera sesión en PENDING
-   Resto en LOCKED

----------

## 4.3 Progresión Académica

student_phase_progress  
 ↓  
estado cambia (COMPLETED)  
 ↓  
desbloquea siguiente sesión

Flujo lineal controlado por orden de sesiones.

----------

## 4.4 Ejecución de sesión

student_phase_progress  
 ↓  
course_session  
 ↓  
(reserva si aplica)

Tipos:

-   Tierra → sin reserva
-   Observador → (futuro)
-   Simulador → con reserva

----------

## 4.5 Flujo completo del estudiante

Matrícula  
 ↓  
16 sesiones Tierra  
 ↓  
(Completar)  
 ↓  
4 Observadores  
 ↓  
(Completar)  
 ↓  
Simulador (reservas)

----------

# 5. 🧠 Decisiones de Diseño Importantes

## 5.1 Separación estructura vs ejecución

-   `phase_session_template` → diseño académico
-   `student_phase_progress` → estado del estudiante
-   `course_session` → ejecución real

----------

## 5.2 Versionamiento académico

-   `program_structure_version` permite evolución sin romper historial

----------

## 5.3 Progreso como entidad central

`student_phase_progress`:

-   gobierna el flujo
-   controla desbloqueo
-   conecta con ejecución

----------

## 5.4 No acoplar programa a estudiante

-   El estudiante no tiene programa directo
-   Todo se maneja vía `enrollment`

Permite:

-   múltiples programas por estudiante
-   historial académico

----------

## 5.5 Reservas desacopladas del currículo

-   Solo afectan ejecución (course_session)
-   No afectan estructura académica

----------

## 5.6 Modelo extensible

El sistema permite:

-   múltiples versiones de programa
-   múltiples estructuras
-   múltiples tipos de sesión
-   integración con agenda externa

----------

# ✅ Conclusión

La arquitectura implementada corresponde a un sistema tipo:

> **LMS académico con motor de scheduling operativo**

Con características:

-   Versionamiento robusto
-   Progresión controlada
-   Separación clara de responsabilidades
-   Escalabilidad institucional

# AVIATION ACADEMIC SYSTEM

## ⚙️ Resumen Técnico – Lógica del Sistema

----------

# 1. 🔌 Endpoints creados

## 🔐 Auth

### `POST /api/auth/register`

-   Crea `user_account`
-   Crea `student` asociado
-   No asigna programa

----------

### `POST /api/auth/login`

-   Valida credenciales
-   Genera JWT con:

uid  
roles  
student_id  
instructor_id

----------

## 🎓 Student

### `GET /api/student/me`

-   Obtiene datos del estudiante autenticado
-   Usa `req.user.student_id`

----------

### `GET /api/student/progress`

-   Obtiene:
    -   enrollment activo
    -   programa
    -   progreso (`student_phase_progress`)
-   Alimenta dashboard académico

----------

## 🧾 Enrollment

### `POST /api/enrollments`

-   Crea matrícula
-   Busca `program_structure_version` activa
-   Guarda `program_structure_version_id`
-   Ejecuta:
    -   `initializeStudentProgress`
-   Genera todas las sesiones en `student_phase_progress`

----------

## 📊 Reservations

### `GET /api/reservations/suggestions`

-   Genera sugerencias de horarios
-   Basado en:
    -   reglas académicas
    -   disponibilidad (SuperSaaS)
    -   PF remaining
-   Filtra:
    -   fechas válidas
    -   turnos libres
    -   recursos disponibles

----------

### `POST /api/reservations`

-   Flujo transaccional:

1. Validar estudiante  
2. Validar enrollment activo  
3. Validar PF disponibles  
4. Validar turno  
5. Validar disponibilidad externa (SuperSaaS)  
6. Crear booking externo  
7. Insertar reservation local  
8. Crear course_session  
9. Vincular reservation ↔ course_session

----------

### `GET /api/reservations/history`

-   Lista reservas del estudiante autenticado
-   Usa `req.user.student_id`

----------

# 2. 🔄 Flujo de negocio

----------

## 🔐 Autenticación

register  
 ↓  
user_account + student  
  
login  
 ↓  
JWT { uid, roles, student_id }  
  
authMiddleware  
 ↓  
req.user

----------

## 🎓 Matrícula

admin → enroll student  
 ↓  
crear enrollment  
 ↓  
buscar structure_version activa  
 ↓  
guardar structure_version_id  
 ↓  
initializeStudentProgress  
 ↓  
crear N registros en student_phase_progress

Resultado:

-   sesiones Tierra generadas
-   primera en PENDING
-   resto LOCKED

----------

## 📈 Progreso académico

student_phase_progress  
 ↓  
estado cambia (COMPLETED)  
 ↓  
desbloquea siguiente sesión

Actualmente:

-   lógica de desbloqueo existe parcialmente
-   no completamente centralizada

----------

## ✈️ Reservas (Simulador)

student  
 ↓  
consulta suggestions  
 ↓  
elige slot  
 ↓  
POST reservation  
 ↓  
validaciones  
 ↓  
SuperSaaS booking  
 ↓  
reservation local  
 ↓  
course_session creada  
 ↓  
progreso vinculado

----------

## 🔗 Relación progreso ↔ ejecución

student_phase_progress  
 ↔ reservation  
 ↔ course_session

-   Tierra → no genera reservation
-   Simulador → sí genera reservation
-   Observador → pendiente implementación

----------

# 3. 🛡 Validaciones importantes

----------

## 🔐 Seguridad

-   `authMiddleware`:
    -   valida JWT
    -   inyecta `req.user`
-   `roleGuard`:
    -   valida roles por endpoint

----------

## 🎓 Académicas

### En suggestions:

-   estudiante activo
-   PF disponibles
-   ventana horaria (access_start_time / end_time)
-   reglas académicas (`validateStudentSuggestions`)
-   límite diario (`MAX_DAILY_SIM_RESERVATIONS`)

----------

### En reservations:

-   enrollment activo
-   estado enrollment = ACTIVE
-   PF remaining > 0
-   turno válido
-   disponibilidad externa (SuperSaaS)
-   disponibilidad por recurso (B1900 concurrency)

----------

## 🔁 Transaccionales

En creación de reserva:

BEGIN  
 ↓  
validaciones  
 ↓  
booking externo  
 ↓  
insert DB  
 ↓  
crear course_session  
COMMIT

Rollback en error.

----------

# 4. ⚠️ Problemas detectados

----------

## 🔴 1. Dependencia de `student_code`

En varios endpoints:

student_code como input

Problema:

-   inseguro
-   redundante con JWT
-   rompe consistencia

👉 Debe usarse siempre `req.user.student_id`

----------

## 🔴 2. Lógica académica distribuida

Validaciones están en:

-   reservations.routes
-   academicValidation.service
-   academicRules.service

Problema:

-   no hay motor centralizado

----------

## 🔴 3. Desbloqueo de progreso no centralizado

-   parte en `progressInitializer`
-   parte implícita en lógica futura

Falta:

AcademicStateEngine

----------

## 🔴 4. Observadores no implementados

-   no existen reservas para observador
-   no existe flujo intermedio Tierra → Simulador

----------

## 🔴 5. Dependencia parcial en frontend

-   algunos flujos aún dependen de:
    -   `student_code`
    -   estado UI

----------

## 🔴 6. schedule_mode no implementado

Aunque se diseñó:

REGULAR  
PERSONALIZED

Aún no está integrado en:

-   enrollment
-   scheduling
-   UI

----------

# 5. 📊 Estado actual del sistema

----------

## ✅ Funcional

-   Registro + login
-   JWT con roles
-   Relación user → student
-   Matrícula con estructura versionada
-   Generación automática de progreso
-   Dashboard académico
-   Timeline visual
-   Reserva de simulador completa
-   Integración SuperSaaS
-   Creación automática de course_session

----------

## ⚠️ Parcial

-   desbloqueo académico automático
-   UI de matrícula
-   control de fases (Tierra → Observador)
-   validaciones centralizadas

----------

## ❌ Pendiente

-   módulo Observador
-   motor académico central
-   Program Builder UI
-   schedule_slot
-   penalty system

----------

# 6. 🚀 Siguientes pasos recomendados

----------

## 🔥 PRIORIDAD 1 — Blindar flujo académico

-   eliminar uso de `student_code`
-   usar solo `req.user.student_id`
-   asegurar consistencia JWT → DB

----------

## 🔥 PRIORIDAD 2 — AcademicStateEngine

Crear servicio:

academicStateEngine.service.js

Responsable de:

-   completar sesión
-   desbloquear siguiente
-   validar transición de fase

----------

## 🔥 PRIORIDAD 3 — Observadores

Implementar:

-   templates en `phase_session_template`
-   reservas tipo OBSERVER
-   integración parcial (sin simulador)

----------

## 🔥 PRIORIDAD 4 — UI de matrícula

-   seleccionar estudiante
-   seleccionar programa/version
-   ejecutar enrollment
-   feedback visual

----------

## 🔥 PRIORIDAD 5 — Tabla académica completa

En dashboard:

-   nombre sesión
-   estado
-   fecha
-   instructor
-   resultado

----------

## 🔥 PRIORIDAD 6 — schedule_slot

-   tabla configurable
-   relación con enrollment
-   base para modalidad REGULAR

----------

## 🔥 PRIORIDAD 7 — Centralización de reglas

Mover a:

academicValidation.service  
academicRules.service  
academicStateEngine

----------

# 🧠 Conclusión

El sistema ya funciona como:

Academic Engine + Scheduling Engine

Con:

-   flujo completo de simulador
-   progresión inicial funcional
-   base sólida versionada

Falta consolidar:

-   control académico central
-   observadores
-   UI administrativa

----------

Si quieres, el siguiente paso ideal es:

👉 diseñar el **AcademicStateEngine completo (núcleo del sistema)**  
o  
👉 construir la **UI de matrícula + builder profesional**
