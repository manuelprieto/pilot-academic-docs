# FASE A — MOTOR AUTOMÁTICO DE DESBLOQUEO PROGRESIVO

Este motor conecta:

reservation → attendance_status  
↓  
course_session.academic_status  
↓  
student_phase_progress.status  
↓  
desbloqueo siguiente subdivisión

----------

# 🎯 OBJETIVO

Cuando una sesión se complete correctamente:

1.  Marcar progreso como COMPLETED
    
2.  Desbloquear la siguiente subdivisión
    
3.  Reenumerar si es necesario
    
4.  Verificar si se completó la fase
    
5.  Verificar si se completó el programa
    

----------

# 1️⃣ ESTADO ACTUAL (YA TENEMOS)

Tabla:

student_phase_progress

Con estados:

LOCKED  
PENDING  
SCHEDULED  
COMPLETED  
FAILED

Unique correcto por enrollment_id ✔

----------

# 2️⃣ REGLA DE DESBLOQUEO

Desbloqueo depende de:

phase_session_template.requires_previous_completion  
phase_session_template.unlocks_next

Si:

-   La subdivisión actual COMPLETED
    
-   unlocks_next = true
    

Entonces:

La siguiente subdivisión pasa de LOCKED → PENDING

----------

# 3️⃣ ¿Necesitamos nuevas columnas?

NO.

Tu modelo actual soporta el motor.

----------

# 4️⃣ ARCHIVOS A CREAR

Dentro de:

src/modules/progress/

Creamos:

progressEngine.service.js  
progressStateMachine.js

----------

# 5️⃣ progressStateMachine.js

Define reglas puras.

export  const  PROGRESS_STATUS  = {  
 LOCKED: 'LOCKED',  
 PENDING: 'PENDING',  
 SCHEDULED: 'SCHEDULED',  
 COMPLETED: 'COMPLETED',  
 FAILED: 'FAILED'  
};

----------

# 6️⃣ progressEngine.service.js

Motor principal.

Funciones necesarias:

-   completeSessionProgress()
    
-   unlockNextSession()
    
-   evaluateProgramCompletion()
    

----------

## completeSessionProgress

Se ejecuta cuando instructor marca:

ATTENDED  
NO_SHOW  
FAILED

Flujo:

1.  Buscar student_phase_progress por course_session_id  
2.  Cambiar status a COMPLETED o FAILED  
3.  Si COMPLETED → unlockNext  
4.  Evaluar si todas COMPLETED

----------

# 7️⃣ ¿Dónde se dispara?

En:

adminReservationController.js  
o  
sessionDetailDrawer action handler

Cuando:

attendance_status cambia a ATTENDED

Ahí se llama:

await  completeSessionProgress(reservationId);
