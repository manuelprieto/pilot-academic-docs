# 1. CONTEXTO GENERAL DEL SISTEMA

El sistema es una **plataforma académica especializada en aviación**, orientada a la gestión integral de:

-   Programas de formación
-   Cursos y sesiones académicas
-   Estudiantes e instructores
-   Reservas de simulador (core operativo)
-   Planificación y reportes de ocupación

### 🎯 Objetivo del sistema

Orquestar la **programación académica + operación de simuladores** bajo reglas estructuradas, garantizando:

-   Consistencia académica
-   Trazabilidad de reservas
-   Asignación controlada de recursos (simuladores, instructores)
-   Escalabilidad por versiones de programa

----------

# 🧱 2. ESTRUCTURA ARQUITECTÓNICA COMPLETA

La arquitectura sigue un modelo jerárquico académico + operativo:

## 🧩 Núcleo Académico

program  
 └── program_version  
 └── program_course  
 └── course_session

### 🔹 program

Entidad raíz del sistema académico.

-   Representa una formación (ej: Piloto Comercial)
-   No contiene lógica operativa directa

----------

### 🔹 program_version

Versionamiento del programa.

-   Permite evolución del contenido sin afectar históricos
-   Base para trazabilidad académica

----------

### 🔹 program_course

Relación entre versión de programa y cursos.

-   Define qué cursos componen una versión
-   Permite orden y estructura curricular

----------

### 🔹 course_session

Unidad operativa académica.

-   Representa una sesión específica de curso
-   Punto de conexión con:
    -   Estudiantes
    -   Reservas
    -   Plantillas de fase

----------

## 🧩 Núcleo Operativo (Scheduling)

course_session  
 └── reservation  
 └── simulator_turn

----------

### 🔹 reservation

Entidad crítica del sistema.

-   Representa una asignación real en el simulador
-   Conecta:
    -   Estudiante
    -   Instructor
    -   Simulador
    -   Horario

👉 Es el **centro de la operación real**

----------

### 🔹 simulator_turn

Bloque de tiempo del simulador.

-   Define disponibilidad base
-   Permite control de ocupación
-   Se relaciona con reservas

----------

## 🧩 Núcleo de Usuarios

user_account  
 └── role  
 ├── student  
 └── instructor

----------

### 🔹 user_account

Entidad base de autenticación.

-   Identidad única del sistema
-   No contiene lógica académica directa

----------

### 🔹 role

Define comportamiento del usuario.

-   ADMIN
-   INSTRUCTOR
-   STUDENT
-   etc.

----------

### 🔹 student

Extensión de user_account.

-   Relacionado con:
    -   enrollment
    -   reservations

----------

### 🔹 instructor

Extensión de user_account.

-   Participa en:
    -   course_session
    -   reservation

----------

## 🧩 Núcleo de Matrícula

student  
 └── enrollment  
 └── course_session

----------

### 🔹 enrollment

Relación estudiante ↔ programa/sesión.

-   Define el progreso académico
-   Punto clave para control de acceso

👉 Regla importante definida:

> `reservation.enrollment_id` asegura integridad académica

----------

## 🧩 Plantillas de Fase

phase_session_template  
 └── course_session

-   Define estructura base de sesiones
-   Permite generación consistente
-   Separación entre diseño y ejecución

----------

# 🧮 3. TABLAS Y RELACIONES PRINCIPALES

## Relaciones clave

### Académicas

-   `program 1 ─── N program_version`
-   `program_version 1 ─── N program_course`
-   `program_course N ─── 1 course`
-   `program_course 1 ─── N course_session`

----------

### Operativas

-   `course_session 1 ─── N reservation`
-   `reservation N ─── 1 simulator_turn`
-   `reservation N ─── 1 instructor`
-   `reservation N ─── 1 student`

----------

### Usuarios

-   `user_account 1 ─── 1 student`
-   `user_account 1 ─── 1 instructor`
-   `user_account N ─── 1 role`

----------

### Matrícula

-   `student 1 ─── N enrollment`
-   `enrollment N ─── 1 program_version`
-   `enrollment 1 ─── N reservation`

----------

# 🔄 4. FLUJO LÓGICO DE DATOS

## 🔹 Flujo Académico

1.  Se define un `program`
2.  Se versiona → `program_version`
3.  Se estructuran cursos → `program_course`
4.  Se generan sesiones → `course_session`

----------

## 🔹 Flujo de Usuario

1.  Se crea `user_account`
2.  Se asigna `role`
3.  Se especializa:
    -   `student`
    -   `instructor`

----------

## 🔹 Flujo de Matrícula

1.  Student se inscribe → `enrollment`
2.  Se vincula a programa/version
3.  Se habilita acceso a sesiones

----------

## 🔹 Flujo Operativo (Core del sistema)

1.  Existe disponibilidad → `simulator_turn`
2.  Se crea `reservation`
3.  La reserva vincula:
    -   student (vía enrollment)
    -   instructor
    -   simulador
    -   horario
4.  Se ejecuta la sesión

----------

## 🔹 Flujo de Reportes

1.  Se consultan `reservations`
2.  Se agrupan por:
    -   fecha
    -   simulador
    -   tipo (PF / PM)
3.  Se generan métricas:
    -   total sesiones
    -   ocupación
    -   distribución

----------

# 🧠 5. DECISIONES DE DISEÑO IMPORTANTES

## ✅ 1. Separación Académico vs Operativo

-   `course_session` ≠ `reservation`
-   Permite:
    -   independencia conceptual
    -   reprogramaciones
    -   control de ejecución

----------

## ✅ 2. Versionamiento de programas

-   `program_version` evita:
    -   romper históricos
    -   inconsistencias curriculares

----------

## ✅ 3. reservation como núcleo operativo

-   Todo converge en:
    -   tiempo
    -   recurso
    -   actor

👉 Diseño correcto para sistemas scheduling-heavy

----------

## ✅ 4. Integridad mediante enrollment

-   `reservation.enrollment_id`
-   Evita:
    -   reservas sin contexto académico
    -   inconsistencias de estudiante

----------

## ✅ 5. Uso de plantillas

-   `phase_session_template`
-   Permite:
    -   estandarización
    -   generación automática

----------

## ✅ 6. Roles desacoplados de usuario

-   `user_account` + `role`
-   Escalable para:
    -   multi-rol
    -   permisos dinámicos

----------

## ✅ 7. Modelo orientado a trazabilidad

El sistema permite reconstruir:

-   Qué programa cursa el estudiante
-   Qué sesión ejecutó
-   En qué simulador
-   Con qué instructor
-   En qué horario

----------

# 📌 CONCLUSIÓN ARQUITECTÓNICA

El sistema está diseñado bajo un enfoque:

### 🧱 **Domain-driven (ligero)**

Separando dominios:

-   académico
-   operativo
-   usuario

### 🔄 **Orientado a scheduling**

Donde `reservation` es el eje central

### 📊 **Preparado para analítica**

Gracias a:

-   normalización
-   relaciones claras
-   datos históricos intactos

----------

## 🔥 Estado actual del sistema

Ya tienes:

-   Arquitectura coherente
-   Modelo de datos sólido
-   Separación de responsabilidades correcta
-   Base lista para escalar a:
    -   optimización
    -   predicción
    -   automatización

# 1. ENDPOINTS CREADOS (RUTA + FUNCIONALIDAD)

## 🧑‍✈️ Instructores

### `GET /api/admin/instructors`

-   Lista todos los instructores
-   Incluye:
    -   datos de usuario
    -   tipo (PLANTA / LINEA / EXTERNO)
    -   ranking
    -   estado / activo

----------

### `PUT /api/admin/instructors/:id`

-   Actualiza instructor:
    -   `instructor_type`
    -   `ranking`
    -   `status`
    -   `active`

👉 Uso: panel administrativo (edición inline)

----------

### `GET /api/admin/instructor-users`

-   Retorna usuarios elegibles para ser instructores
-   Filtra por rol INSTRUCTOR

👉 Uso: formulario de inscripción

----------

### `POST /api/admin/instructors`

-   Crea un instructor desde `user_account`
-   Asigna:
    -   tipo
    -   ranking

----------

## 👤 Usuarios

### `POST /api/admin/users`

-   Crea usuario del sistema
-   Define:
    -   documento
    -   nombre
    -   email
    -   password
    -   rol

👉 Punto de entrada para todo actor del sistema

----------

## 📊 Reportes

### `GET /api/admin/reports/reservations`

Parámetros:

-   `from`
-   `to`
-   `group_by` (day / week / month)
-   `breakdown=simulator`
-   `include_time=true`
-   `calendar_role=PF|PM`

Funcionalidad:

-   Agrega reservas
-   Genera métricas:
    -   total sesiones
    -   PF / PM
    -   distribución por simulador
    -   franjas horarias

👉 Base del módulo de ocupación

----------

## 🎓 Estudiantes

### `GET /api/students/...`

### `POST /api/students/...`

(Implícitos por archivos cargados)

Funcionalidad:

-   gestión de estudiantes
-   relación con enrollment
-   consumo de dashboard

----------

## 📅 Reservas / Calendar

### `GET /api/admin/reservations/...`

### `POST /api/admin/reservations/...`

(Implícito por `adminReservationController.js`)

Funcionalidad:

-   creación de reservas
-   gestión operativa
-   consumo por calendario

----------

# 🔄 2. FLUJO DE NEGOCIO

## 🔐 2.1 Flujo de Autenticación

1.  Usuario hace login
2.  Se genera JWT
3.  Frontend:
    -   guarda token
    -   lo envía en cada request
4.  Backend:
    -   valida token
    -   identifica `user_account`
    -   carga rol

----------

## 👤 2.2 Flujo Usuario → Instructor

1.  Admin crea usuario (`POST /users`)
2.  Usuario queda con rol INSTRUCTOR
3.  Admin lo convierte en instructor:
    -   `POST /instructors`
4.  Se asigna:
    -   tipo
    -   ranking

👉 Separación clara:

-   identidad vs rol operativo

----------

## 🎓 2.3 Flujo Student → Enrollment

1.  Usuario → student
2.  Se crea `enrollment`
3.  Enrollment vincula:
    -   programa
    -   versión

👉 Este paso habilita:

-   acceso académico
-   reservas válidas

----------

## 🧠 2.4 Flujo CRÍTICO: Reservation

1.  Existe disponibilidad (`simulator_turn`)
2.  Usuario solicita o sistema genera reserva
3.  Se valida:
    -   student tiene enrollment
4.  Se crea `reservation` con:
    -   enrollment_id
    -   instructor_id
    -   simulador
    -   horario

👉 Resultado:

-   sesión ejecutable

----------

## 🔄 2.5 Flujo de Reprogramación (implícito)

1.  Se identifica reserva existente
2.  Se busca nuevo slot disponible
3.  Se reasigna:
    -   horario
    -   simulador

👉 Mantiene trazabilidad histórica

----------

## 📊 2.6 Flujo de Reportes

1.  Se consultan reservas
2.  Se aplican filtros:
    -   fechas
    -   tipo
    -   simulador
3.  Se agregan datos
4.  Se entregan métricas

👉 Uso:

-   planificación
-   análisis de ocupación

----------

# ✅ 3. VALIDACIONES IMPORTANTES

## 🔐 Auth

-   JWT obligatorio
-   Asociación correcta con user_account

----------

## 🎓 Académicas

-   `reservation` debe tener `enrollment_id`
-   Estudiante debe pertenecer al programa

----------

## 👨‍✈️ Instructor

-   Usuario debe tener rol INSTRUCTOR
-   No duplicar instructor para mismo user_account

----------

## 📅 Reservas

-   No solapar horarios
-   Validar disponibilidad del simulador
-   Validar disponibilidad del instructor

----------

## 📊 Reportes

-   Validar rango de fechas
-   Controlar parámetros opcionales

----------

# ⚠️ 4. PROBLEMAS DETECTADOS

## 🔴 1. Validaciones distribuidas (riesgo)

-   No centralizadas
-   Posible inconsistencia entre endpoints

----------

## 🔴 2. Falta de capa de dominio clara

-   Lógica mezclada en controllers/services
-   Falta de reglas explícitas reutilizables

----------

## 🔴 3. Reglas de scheduling no formalizadas

-   Solapamientos no garantizados globalmente
-   Falta motor de validación central

----------

## 🔴 4. Dependencia fuerte del frontend

-   Algunos flujos dependen de orden correcto en UI
-   Backend debería ser más defensivo

----------

## 🔴 5. Estados de reservation limitados

-   No se evidencia:
    -   CANCELLED
    -   COMPLETED
    -   REPROGRAMMED

----------

# 🟢 5. ESTADO ACTUAL DEL SISTEMA

## Nivel: 🟢 Funcional + estructurado

El sistema actualmente:

-   ✔ Permite gestión completa de instructores
-   ✔ Permite creación de usuarios
-   ✔ Permite reservas operativas
-   ✔ Genera reportes útiles
-   ✔ Tiene flujo académico consistente

----------

## Nivel de madurez

Área

Estado

Auth

Estable

Usuarios

Estable

Instructores

Estable

Reservas

Funcional

Reportes

Bueno

Validaciones

Mejorable

Dominio

Medio

----------

# 🚀 6. SIGUIENTES PASOS RECOMENDADOS

## 🥇 1. Centralizar lógica de negocio

Crear capa tipo:

domain/services

Ej:

-   reservation.service
-   instructor.service
-   enrollment.service

----------

## 🥈 2. Motor de validación de reservas

Centralizar reglas:

-   solapamiento
-   disponibilidad
-   reglas PF / PM
-   reglas por simulador

----------

## 🥉 3. Estados de reservation

Agregar:

-   SCHEDULED
-   COMPLETED
-   CANCELLED
-   REPROGRAMMED

----------

## 🧠 4. Auditoría y trazabilidad

-   historial de cambios
-   logs de reprogramación

----------

## 📊 5. KPIs y agregaciones

-   ocupación %
-   uso por simulador
-   eficiencia por instructor

----------

## 🧩 6. Desacoplar lógica del controller

Pasar de:

-   controller-heavy

A:

-   service/domain-driven

----------

# 📌 CONCLUSIÓN FINAL

### Lo que tienes hoy:

Un sistema que:

-   Funciona end-to-end
-   Tiene coherencia operativa
-   Tiene base académica sólida
-   Ya permite operación real

----------

### Lo que le falta para nivel enterprise:

-   Centralización de reglas
-   Motor de validaciones robusto
-   Estados claros en reservas
-   Dominio explícito

----------

## 🧠 Frase final de arquitecto
