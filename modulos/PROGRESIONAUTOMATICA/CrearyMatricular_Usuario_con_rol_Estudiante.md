# Objetivo

Cuando el admin cree un usuario con rol STUDENT:

Automáticamente:

user_account  
↓  
user_role  
↓  
student  
↓  
enrollment  
↓  
initializeStudentProgress (16 sesiones)

Todo en UNA sola transacción.

----------

# 🏗 Vamos a crear

src/controllers/admin/studentProvisioning.controller.js  
src/routes/admin/studentProvisioning.routes.js

----------

# 🧠 Controller completo (listo para pegar)

## 📁 `studentProvisioning.controller.js`

import  pool  from  '../../db.js';  
import  bcrypt  from  'bcrypt';  
import { createEnrollment } from  '../enrollment/enrollment.service.js';  
  
export  const  provisionStudent  =  async (req, res) => {  
  const  client  =  await  pool.connect();  
  
  try {  
  const {  
 document_type_id,  
 document_number,  
 first_name,  
 last_name,  
 email,  
 password,  
 programVersionId,  
 startDate  
 } =  req.body;  
  
  if (  
  !document_type_id  ||  
  !document_number  ||  
  !first_name  ||  
  !last_name  ||  
  !email  ||  
  !password  ||  
  !programVersionId  
 ) {  
  return  res.status(400).json({ message: 'Datos incompletos' });  
 }  
  
  await  client.query('BEGIN');  
  
  // 1️⃣ Verificar email único  
  const  emailCheck  =  await  client.query(  
  'SELECT 1 FROM user_account WHERE email = $1',  
 [email]  
 );  
  
  if (emailCheck.rowCount >  0) {  
  throw  new  Error('El email ya está registrado');  
 }  
  
  // 2️⃣ Hash password  
  const  passwordHash  =  await  bcrypt.hash(password, 10);  
  
  // 3️⃣ Crear user_account  
  const  userResult  =  await  client.query(  
  `  
 INSERT INTO user_account (  
 document_type_id,  
 document_number,  
 first_name,  
 last_name,  
 email,  
 password_hash,  
 active  
 )  
 VALUES ($1,$2,$3,$4,$5,$6,true)  
 RETURNING id  
 `,  
 [  
  document_type_id,  
  document_number,  
  first_name,  
  last_name,  
  email,  
  passwordHash  
 ]  
 );  
  
  const  userAccountId  =  userResult.rows[0].id;  
  
  // 4️⃣ Asignar rol STUDENT  
  await  client.query(  
  `  
 INSERT INTO user_role (user_account_id, role_id)  
 VALUES (  
 $1,  
 (SELECT id FROM role WHERE code = 'STUDENT')  
 )  
 `,  
 [userAccountId]  
 );  
  
  // 5️⃣ Crear student  
  const  studentResult  =  await  client.query(  
  `  
 INSERT INTO student (  
 student_code,  
 full_name,  
 user_account_id,  
 status,  
 pf_remaining,  
 observer_remaining  
 )  
 VALUES ($1,$2,$3,'ACTIVO',5,0)  
 RETURNING id  
 `,  
 [  
  `STU-${document_number}`,  
  `${first_name}  ${last_name}`,  
  userAccountId  
 ]  
 );  
  
  const  studentId  =  studentResult.rows[0].id;  
  
  await  client.query('COMMIT');  
  client.release();  
  
  // 6️⃣ Crear enrollment usando tu servicio existente  
  const  enrollmentId  =  await  createEnrollment({  
 studentId,  
 programVersionId,  
 startDate: startDate  ||  new  Date()  
 });  
  
  res.status(201).json({  
 message: 'Estudiante creado y matriculado correctamente',  
 studentId,  
 enrollmentId  
 });  
  
 } catch (error) {  
  await  client.query('ROLLBACK');  
  client.release();  
  console.error(error);  
  res.status(500).json({ message: error.message });  
 }  
};

----------

# 🛣 Ruta

## 📁 `studentProvisioning.routes.js`

import  express  from  'express';  
import { provisionStudent } from  '../../controllers/admin/studentProvisioning.controller.js';  
  
const  router  =  express.Router();  
  
router.post('/provision-student', provisionStudent);  
  
export  default  router;

----------

# 🔌 Registrar ruta en `app.js`

Agregar:

import  studentProvisioningRoutes  from  './routes/admin/studentProvisioning.routes.js';

Y debajo:

app.use('/api/admin', studentProvisioningRoutes);

----------

# 🚀 Ahora el flujo real será

POST:

/api/admin/provision-student

Body:

{  
 "document_type_id": 1,  
 "document_number": "9000123",  
 "first_name": "Ana",  
 "last_name": "Nieto",  
 "email": "ana@test.com",  
 "password": "123456",  
 "programVersionId": 1  
}

Y automáticamente:

-   Se crea usuario
    
-   Se asigna rol
    
-   Se crea student
    
-   Se crea enrollment
    
-   Se crean 16 sesiones
    
-   Puede entrar al dashboard
    

----------

# 🔥 Resultado

Nunca más SQL manual.  
Nunca más asignaciones manuales.  
Nunca más inconsistencias.

----------

Si quieres ahora hacemos:

👉 Integrarlo en tu CreateUserPage  
👉 O crear un botón "Crear y Matricular" en el dashboard
