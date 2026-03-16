# MOTOR AUTOMÁTICO DE SINCRONIZACIÓN

## 🎯 Objetivo

Cada vez que cambie:

reservation.attendance_status

El sistema debe automáticamente:

-   Actualizar progreso
    
-   Evaluar desbloqueo
    
-   Generar infracción si aplica
    
-   Evaluar estado global de sesión
    

----------

## 🧠 Arquitectura Recomendada

NO lo hagas con triggers SQL.

Hazlo con un **Academic State Engine** en backend.

----------

## 📁 Nuevo archivo recomendado

src/modules/academic/academicStateEngine.service.js

----------

## 🎯 Método central

export  async  function  handleAttendanceChange({  
 reservationId,  
 client  
}) {  
  // 1. Obtener reservation  
  // 2. Actualizar progreso  
  // 3. Evaluar desbloqueo  
  // 4. Generar infracción si aplica  
  // 5. Evaluar estado global course_session  
}

----------

## 🔁 Flujo interno del motor

### Paso A — Obtener datos

-   reservation
    
-   phase_session_template
    
-   enrollment_id
    
-   student_id
    

----------

### Paso B — Sincronizar progreso

Regla:

ATTENDED → COMPLETED  
NO_SHOW → FAILED  
CANCELLED_LATE → FAILED  
VIEWED → FAILED

Actualizar:

student_phase_progress.status  
student_phase_progress.completed_at

----------

### Paso C — Desbloquear siguiente

Si status = COMPLETED:

1.  Buscar siguiente subdivisión LOCKED
    
2.  Cambiar a PENDING
    

----------

### Paso D — Evaluar infracción

Si:

NO_SHOW  
CANCELLED_LATE

→ llamar módulo de penalización

----------

### Paso E — Evaluar estado global de sesión

Si todos tienen estado final:

course_session.academic_status = COMPLETED

----------

# 2️⃣ TRIGGER LÓGICO DE PROGRESO

No SQL trigger.  
Trigger lógico en controlador.

----------

## 📁 En adminReservationController.js

Cuando cambias estado:

await  updateReservationStatus(...);  
  
await  handleAttendanceChange({  
 reservationId,  
 client  
});

Todo dentro de la misma transacción.

----------

# 3️⃣ MÓDULO COMPLETO DE INFRACCIONES

## 🎯 Tablas necesarias

### 🔹 student_infraction

CREATE  TABLE student_infraction (  
 id SERIAL PRIMARY  KEY,  
 student_id INTEGER  REFERENCES student(id),  
 enrollment_id INTEGER  REFERENCES enrollment(id),  
 reservation_id INTEGER  REFERENCES reservation(id),  
 session_category VARCHAR(20),  
 infraction_type VARCHAR(20), -- NO_SHOW / LATE_CANCEL  
 amount NUMERIC(10,2),  
 status VARCHAR(20) DEFAULT  'PENDING',  
 created_at TIMESTAMP  DEFAULT now()  
);

----------

### 🔹 student_payment

CREATE  TABLE student_payment (  
 id SERIAL PRIMARY  KEY,  
 infraction_id INTEGER  REFERENCES student_infraction(id),  
 amount NUMERIC(10,2),  
 payment_link TEXT,  
 status VARCHAR(20) DEFAULT  'PENDING',  
 created_at TIMESTAMP  DEFAULT now()  
);

----------

## 🎯 Motor de cálculo

Nuevo archivo:

src/modules/penalties/penaltyEngine.service.js

### Lógica

1.  Consultar historial de infracciones PF o PM
    
2.  Determinar nivel (1ra, 2da, 3ra)
    
3.  Consultar tabla academic_rule para valores
    
4.  Insertar student_infraction
    
5.  Generar payment_link
    

----------

# 4️⃣ FLUJO COMPLETO DESDE MATRÍCULA HASTA CERTIFICACIÓN

Ahora lo dibujo completo.

----------

# 🧭 ETAPA 1 — MATRÍCULA

POST /api/enrollments  
 ↓  
createEnrollment()  
 ↓  
Congela program_structure_version  
 ↓  
initializeStudentProgress()  
 ↓  
student_phase_progress generado  
(primera PENDING, resto LOCKED)

----------

# 🧭 ETAPA 2 — TIERRA

Admin crea course_session (precargadas)

Estudiante asiste.

Instructor marca ATTENDED.

Motor:

reservation → ATTENDED  
↓  
student_phase_progress → COMPLETED  
↓  
Desbloquea siguiente subdivisión

----------

# 🧭 ETAPA 3 — OBSERVADORES

Reservas PF obligatorias.

Motor bloquea PF si:

observadores < 4 completados

----------

# 🧭 ETAPA 4 — SIMULADOR PF

Reserva PF.

Validaciones:

-   Límite diario
    
-   Límite semanal
    
-   Mínimo PM mensual
    
-   Disponibilidad instructor
    
-   Disponibilidad simulador
    

----------

# 🧭 ETAPA 5 — NO_SHOW

Instructor marca NO_SHOW.

Motor:

reservation → NO_SHOW  
↓  
student_phase_progress → FAILED  
↓  
student_infraction creada  
↓  
payment generado  
↓  
bloqueo de avance

----------

# 🧭 ETAPA 6 — REPETICIÓN / NIVELACIÓN

Admin crea:

student_remedial_session

Se genera nueva course_session.

Progreso se ajusta.

----------

# 🧭 ETAPA 7 — FINALIZACIÓN

Cuando todas las subdivisiones:

student_phase_progress.status = COMPLETED

Sistema:

enrollment.status = COMPLETED

Genera:

student_certification

----------

# 🏁 CERTIFICACIÓN

Certificado emitido  
Programa finalizado

----------

# 🧠 Arquitectura Final del Sistema

reservation → comportamiento individual  
student_phase_progress → avance curricular  
course_session → evento académico  
student_infraction → disciplina  
student_payment → cobro  
enrollment → estado macro del programa
