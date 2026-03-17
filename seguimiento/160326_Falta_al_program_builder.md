# Lo que falta para terminar el Builder

Solo faltan **4 cosas pequeñas**.

----------

# 1️⃣ Crear sesiones dentro del módulo (UI)

Botón que ya tienes:

Ver sesiones

Debe abrir:

/admin/program-builder/module/:moduleId

Pantalla:

ModuleSessions.jsx

Ahí se crean:

Clase 1  
Clase 2  
Clase 3

tabla:

phase_session_template

Campos:

session_number  
name  
duration_hours  
session_type  
program_module_id

Esto **ya tienes casi todo hecho**.

----------

# 2️⃣ Editar módulos

Ahora puedes crear módulos pero falta:

Editar módulo

Para cambiar:

nombre  
orden  
tipo  
duración

Esto usa endpoint que ya tienes:

PUT /program-module/:id

----------

# 3️⃣ Orden de módulos (timeline)

Actualmente ves:

Fase Tierra  
Observador  
Simulador

pero el orden depende de:

sequence_order

Esto ya lo guardas.

Solo debes asegurarte que la consulta esté ordenada:

ORDER  BY pm.sequence_order

----------

# 4️⃣ Timeline visual

La sección:

Program Timeline

debe mostrar:

Fase Tierra  
 Clase 1  
 Clase 2  
 Clase 3  
  
Observador  
 Observador 1  
 Observador 2

Esto ya casi lo haces con:

ProgramTimeline.jsx

solo falta **agrupar sesiones por módulo**.

----------

# 🎯 Resultado final del Builder

Cuando esté terminado podrás construir algo así:

Programa: Transición A320  
  
Versión: Completo  
  
Fase Tierra  
 Clase 1  
 Clase 2  
 Clase 3  
 Clase 4  
  
Observador  
 Observador 1  
 Observador 2  
  
Simulador  
 SIM 1  
 SIM 2

Todo guardado en:

program_module  
phase_session_template

----------

# 🚀 Cuando el Builder termine

Entonces matrícula será:

POST /enrollments

y automáticamente se crean:

student_phase_progress

con todas las sesiones.

----------

# ⭐ Buenas noticias

Lo que falta del builder es **solo UI**, no backend complejo.

Te diría que estás aproximadamente:

Program Builder: 90% terminado

----------

# 🔜 Te recomiendo que sigamos así

Siguiente paso ahora:

### 👉 terminar **ModuleSessions.jsx**

para crear sesiones fácilmente.

Eso nos permite definir:

Clase 1  
Clase 2  
Clase 3

en cada módulo.
