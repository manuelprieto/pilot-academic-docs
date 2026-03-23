
# CHECKLIST COMPLETO PARA PROBAR PROGRESO

## 🧩 1. Usuario ligado a student ✔

Ya lo validaste:

user_account.id = student.user_account_id

----------

## 🎓 2. El student DEBE tener matrícula (enrollment)

SELECT  *    
FROM enrollment  
WHERE student_id =  10;

👉 Debe existir al menos 1

----------

## 🧱 3. Ese enrollment debe tener:

program_structure_version_id ✅

Ejemplo:

enrollment.program_structure_version_id = 12

----------

## 🧠 4. Debe existir estructura con módulos

SELECT  *    
FROM program_module  
WHERE program_structure_version_id =  12;

👉 Ya lo tienes ✔

----------

## 📚 5. Debe haber sesiones (CRÍTICO)

SELECT  *    
FROM phase_session_template  
WHERE program_module_id IN (  
  SELECT id   
  FROM program_module  
  WHERE program_structure_version_id =  12  
);

👉 Si esto está vacío → ❌ no hay progreso

----------

## ⚙️ 6. Debe existir progreso generado

SELECT  *    
FROM student_phase_progress  
WHERE enrollment_id =  15;

👉 Debe mostrar:

1 PENDING  
n LOCKED

----------

# 🚀 SI TODO LO ANTERIOR SE CUMPLE

Entonces:

## 🔥 YA PUEDES PROBAR:

GET /api/student/progress

----------

# 🧠 QUÉ HACE INTERNAMENTE

JWT  
↓  
user_account  
↓  
student  
↓  
enrollment  
↓  
student_phase_progress  
↓  
JOIN con course_session / instructor

----------

# ❌ ERRORES POSIBLES

## 🔴 Caso 1: No devuelve nada

👉 Falta enrollment o progress

----------

## 🔴 Caso 2: 500 error

👉 falla en query JOIN (normalmente instructor o course_session null)

----------

## 🔴 Caso 3: array vacío

👉 progress no existe

----------

# 🎯 PRUEBA FINAL (IMPORTANTE)

Después de matricular:

1️⃣ POST /api/enrollments  
2️⃣ validar student_phase_progress  
3️⃣ GET /api/student/progress

----------

# 💥 LO QUE DEBERÍAS VER

{  
 "progress": [  
 {  
 "status": "PENDING"  
 },  
 {  
 "status": "LOCKED"  
 }  
 ]  
}

----------

# 🚀 SI QUIERES IR A TIRO FIJO

Respóndeme esto:

SELECT * FROM student_phase_progress WHERE enrollment_id = X;
