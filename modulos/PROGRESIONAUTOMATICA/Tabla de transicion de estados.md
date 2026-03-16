# TABLA DE TRANSICIÓN DE ESTADOS

## A) reservation.attendance_status

Estado Actual

Puede pasar a

Quién lo cambia

SCHEDULED

ATTENDED

Instructor

SCHEDULED

NO_SHOW

Instructor

SCHEDULED

LATE_WITH_NOTICE

Instructor

SCHEDULED

CANCELLED_EARLY

Estudiante

SCHEDULED

CANCELLED_LATE

Sistema

SCHEDULED

REPROGRAM_PENDING

Admin

ATTENDED

(cerrado)

—

NO_SHOW

VIEWED

Sistema

CANCELLED_LATE

VIEWED

Sistema

----------

## B) student_phase_progress.status

reservation.attendance_status

Resultado en progreso

ATTENDED

COMPLETED

NO_SHOW

FAILED

CANCELLED_LATE

FAILED

VIEWED

FAILED

REPROGRAM_PENDING

permanece PENDING

----------

## C) course_session.academic_status

Depende de agregación:

Condición

Resultado

Al menos un ATTENDED

COMPLETED

Todos cancelados

CANCELLED

Reprogramación activa

REPROGRAMMED
