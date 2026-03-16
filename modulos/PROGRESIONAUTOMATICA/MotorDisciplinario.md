# FASE B — MOTOR DISCIPLINARIO

Este sí requiere tablas nuevas.

----------

# 1️⃣ TABLA student_infraction

CREATE  TABLE student_infraction (  
 id SERIAL PRIMARY  KEY,  
 student_id INTEGER  REFERENCES student(id),  
 enrollment_id INTEGER  REFERENCES enrollment(id),  
 reservation_id INTEGER  REFERENCES reservation(id),  
 infraction_type VARCHAR(30),  
 amount NUMERIC(10,2),  
 status VARCHAR(20) DEFAULT  'PENDING',  
 created_at TIMESTAMP  DEFAULT now()  
);

----------

# 2️⃣ TABLA student_payment

CREATE  TABLE student_payment (  
 id SERIAL PRIMARY  KEY,  
 student_id INTEGER  REFERENCES student(id),  
 infraction_id INTEGER  REFERENCES student_infraction(id),  
 amount NUMERIC(10,2),  
 status VARCHAR(20),  
 created_at TIMESTAMP  DEFAULT now()  
);

----------

# 3️⃣ MOTOR DISCIPLINARIO SERVICE

src/modules/discipline/disciplineEngine.service.js

Funciones:

-   evaluateNoShow()
    
-   evaluateLate()
    
-   createInfraction()
    
-   calculateInfractionAmount()
