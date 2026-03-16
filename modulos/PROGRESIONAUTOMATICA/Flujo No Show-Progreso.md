
# FLUJO DESDE NO_SHOW HASTA PROGRESO

Ahora lo dibujamos lógico paso a paso.

----------

## 🔥 ESCENARIO

Instructor marca NO_SHOW.

----------

### Paso 1 — Instructor acción

SessionDetailDrawer  
→ PATCH /api/admin/sessions/:id  
action = "no_show"

----------

### Paso 2 — Backend actualiza reservation

reservation.attendance_status = 'NO_SHOW'

Y registra en:

student_session_attendance

----------

### Paso 3 — Motor académico evalúa

Regla automática:

SI attendance_status = NO_SHOW  
→ student_phase_progress.status = FAILED  
→ completed_at = NOW()

----------

### Paso 4 — Evaluación de desbloqueo

Si:

phase_session_template.requires_previous_completion = true

Entonces:

NO desbloquea siguiente subdivisión.

Si fuera ATTENDED:

Desbloquea siguiente → status = PENDING

----------

### Paso 5 — Generación de multa

Sistema consulta:

-   Tipo de sesión
    
-   Tipo de aeronave
    
-   Número de infracción acumulada
    

Y crea:

student_penalty  
payment_link

----------

### Paso 6 — Notificaciones

Se notifica a:

-   Estudiante
    
-   Instructor
    
-   Programación
    

----------

# 🔒 Resultado Final del NO_SHOW

reservation.attendance_status = NO_SHOW  
student_phase_progress.status = FAILED  
course_session.academic_status = COMPLETED (si hubo instructor y sesión ocurrió)  
multa generada  
progreso bloqueado

----------

# 🏗 Modelo Mental Definitivo

reservation → gobierna comportamiento individual  
course_session → gobierna evento académico  
student_phase_progress → gobierna avance curricular  
student_session_attendance → auditoría

----------

# 🎯 Conclusión Profesional

Tu modelo puede ser extremadamente sólido si:

✔ Defines este contrato formal  
✔ No duplicas autoridad  
✔ Centralizas lógica en reservation  
✔ Mantienes progreso derivado
