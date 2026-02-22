# CONTRATO FORMAL DE ESTADOS

(Single Source of Truth)

Este contrato define qué tabla manda en cada nivel.

----------

## 🔷 NIVEL 1 — Estado Individual (Fuente de Verdad)

📍 Tabla: `reservation`  
📍 Campo: `attendance_status`

Representa el comportamiento del estudiante en ESA sesión específica.

### Estados permitidos

SCHEDULED  
ATTENDED  
NO_SHOW  
LATE_WITH_NOTICE  
CANCELLED_EARLY  
CANCELLED_LATE  
REPROGRAM_PENDING  
VIEWED

### Regla fundamental

reservation.attendance_status  
ES la única fuente válida  
para determinar avance académico individual.

Ni `course_session`  
Ni `student_session_attendance`

----------

## 🔷 NIVEL 2 — Estado Académico Global

📍 Tabla: `course_session`  
📍 Campo: `academic_status`

Representa el evento académico en sí.

### Estados permitidos

SCHEDULED  
COMPLETED  
CANCELLED  
REPROGRAMMED

### Regla

No puede contener:

-   NO_SHOW
    
-   LATE_WITH_NOTICE
    
-   CANCELLED_LATE
    

Porque esos son individuales.

----------

## 🔷 NIVEL 3 — Registro Histórico

📍 Tabla: `student_session_attendance`

Solo sirve para:

-   Quién marcó
    
-   Cuándo marcó
    
-   Notas
    
-   Auditoría
    

No es fuente viva.
