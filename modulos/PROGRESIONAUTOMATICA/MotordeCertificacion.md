# FASE C — MOTOR DE CERTIFICACIÓN

Se activa cuando:

Todas las subdivisiones del enrollment estén COMPLETED.

----------

# 1️⃣ TABLA student_certificate

CREATE  TABLE student_certificate (  
 id SERIAL PRIMARY  KEY,  
 student_id INTEGER  REFERENCES student(id),  
 enrollment_id INTEGER  REFERENCES enrollment(id),  
 issued_at TIMESTAMP  DEFAULT now(),  
 certificate_code VARCHAR(50)  
);

----------

# 2️⃣ certificationEngine.service.js

Funciones:

-   checkEnrollmentCompletion()
    
-   issueCertificate()
    

----------

# 🔷 FLUJO COMPLETO DESDE MATRÍCULA

1.  POST /api/enrollments
    
2.  createEnrollment()
    
3.  initializeStudentProgress()
    
4.  Primera subdivisión = PENDING
    
5.  Estudiante reserva
    
6.  Instructor marca ATTENDED
    
7.  progressEngine:
    
    -   COMPLETED
        
    -   unlockNext
        
8.  Se completan todas
    
9.  certificationEngine:
    
    -   create certificate
        

----------

# 🔷 ORDEN DE IMPLEMENTACIÓN REAL

Te recomiendo:

### Paso 1

Construimos progressEngine.service.js completo.

### Paso 2

Lo conectamos a reservation update.

### Paso 3

Probamos desbloqueo automático.

### Paso 4

Construimos disciplineEngine.

### Paso 5

Construimos certificationEngine.
