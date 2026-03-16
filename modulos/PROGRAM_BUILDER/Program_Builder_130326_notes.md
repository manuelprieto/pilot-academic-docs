
   ↓
Program Version
   ↓
Structure Version
   ↓
Modules
   ↓
Sessions
y en matrícula:

Student
   ↓
Enrollment
   ↓
Program Version
⚠️ Algo muy importante que vamos a necesitar
En el momento de matrícula el sistema debe generar:

course_session
a partir de:

phase_session_template
Eso es el motor académico.

📌 Próximo paso lógico del sistema
Ahora que el Program Builder está casi listo, el siguiente módulo fuerte es:

Enrollment Builder
donde el admin selecciona:

Student
Program
Version
Schedule Mode
y el sistema genera el plan de entrenamiento.

ojo a esto:La diferencia entre versiones está en la cantidad de horas teóricas y el número de sesiones de simulador. O sea completo e hibrido tienen fase tierra, observador, simulador pero en fase tierra completo puede tener 16 clases teoricas de 37 horas de teoria e hibrido 16 clases teoricas de 18.5 horas esto esta contemplado?
# Tu modelo académico real

Tienes **mismas fases**, pero **diferente carga académica**.

Ejemplo:

### Versión COMPLETO

`Fase Tierra 16 clases 37 horas

Fase Observador 4 sesiones

Fase Simulador 20 sesiones` 

----------

### Versión HÍBRIDO

`Fase Tierra 16 clases 18.5 horas

Fase Observador 4 sesiones

Fase Simulador 20 sesiones` 

Entonces la diferencia está en:

`duración
tipo de sesión
cantidad de horas` 

NO en las fases.

----------

# 2️⃣ Cómo lo soporta tu arquitectura actual

Tu modelo de datos:

`program ↓
program_version
   ↓
program_structure_version
   ↓
program_module
   ↓
phase_session_template` 

La diferencia entre **Completo e Híbrido** se define aquí:

`phase_session_template` 

porque ahí tienes:

`duration_hours
session_number
session_type  delivery_mode` 

----------

# 3️⃣ Ejemplo real en tu sistema

### COMPLETO

`Module:  Fase  Tierra  Session 1   duration_hours:  2.5  Session 2   duration_hours:  2.5  Session 3   duration_hours:  2.5  ...  Session 16  duration_hours:  2.5` 

Total:

`37 horas` 

----------

### HÍBRIDO

`Module:  Fase  Tierra  Session 1   duration_hours:  1.25  Session 2   duration_hours:  1.25  Session 3   duration_hours:  1.25  ...  Session 16  duration_hours:  1.25` 

Total:

`18.5 horas` 

----------

# 4️⃣ Qué estamos haciendo ahora en el builder

Ya tenemos:

`Program ↓
Versions
   ↓
Modules
   ↓
Sessions` 

Lo que falta es que **cada versión tenga sus propias sesiones**.

Eso lo lograremos cuando terminemos:

`versionId → modules → sessions` 

----------

# 5️⃣ Cuando matricules un estudiante

El flujo será:

`Admin ↓
Selecciona estudiante
   ↓
Selecciona programa
   ↓
Selecciona versión` 

Ejemplo:

`Programa: Transición A320  Versión: Híbrido` 

El sistema usará:

`phase_session_template` 

de esa versión para crear:

`course_session` 

del estudiante.

----------

# 6️⃣ Resultado final para el estudiante

Si el estudiante está en **Completo**:

`37 horas teoría  20 simulador` 

Si está en **Híbrido**:

`18.5 horas teoría  20 simulador` 

Todo sale **automáticamente del builder**.

----------

# 7️⃣ Algo muy importante (lo que falta implementar)

Debemos permitir que el admin configure:

`duration_hours` 

en cada sesión desde la UI.

Eso está aquí:

`Session Builder` 

----------

# 8️⃣ Conclusión

Tu arquitectura **ya contempla perfectamente este escenario**.

Las diferencias entre versiones viven en:

`phase_session_template.duration_hours` 

y en la **cantidad de sesiones de simulador**.

----------

# 🚀 Te adelanto algo importante

El siguiente paso fuerte del builder será permitir que el admin vea algo así:

`Versión: Completo Fase Tierra
16 sesiones Total: 37 horas Fase Observador
4 sesiones

Fase Simulador
20 sesiones` 

Eso se llama **Program Summary Panel** y es muy útil para academias.

que descubriste en mi base de datos y que nos puede afectar como se realacionan modules con versions?

Muy buena pregunta Manuel. Te explico **exactamente qué detecté y por qué es importante corregirlo ahora**, antes de que el sistema crezca.

No es un error grave, pero **sí es un detalle de arquitectura**.

----------

# 1️⃣ Cómo deberían relacionarse las tablas

La relación correcta para un **Program Builder versionado** es:

`program ↓
program_version
   ↓
program_structure_version
   ↓
program_module
   ↓
phase_session_template` 

Esto significa:

-   **program_version** → define Completo / Híbrido
    
-   **program_structure_version** → permite cambiar estructura sin romper alumnos antiguos
    
-   **program_module** → fases (Tierra / Observador / Simulador)
    
-   **phase_session_template** → clases
    

----------

# 2️⃣ Lo que detecté en tu código

En el query que propusimos antes aparecía esto:

`WHERE pm.program_version_id = $1` 

Eso **no coincide con tu modelo original**.

Porque según tu diseño inicial, **program_module no depende directamente de program_version**.

Depende de:

`program_structure_version` 

Es decir:

`program_module.structure_id` 

----------

# 3️⃣ Cómo debería ser realmente

La consulta correcta debería ser algo como:

`SELECT pm.id,
  pm.name,
  pm.order_index,
  pst.id AS session_id,
  pst.session_number,
  pst.name AS session_name FROM program_module pm LEFT  JOIN phase_session_template pst ON pst.program_module_id = pm.id WHERE pm.structure_id = $1  ORDER  BY pm.order_index, pst.session_number` 

Donde `$1` es:

`program_structure_version_id` 

----------

# 4️⃣ Por qué esto es importante

Porque si mañana cambias la estructura:

`Completo v1
Completo v2` 

los estudiantes antiguos seguirán usando:

`structure v1` 

y los nuevos usarán:

`structure v2` 

Eso es **estándar en LMS profesionales**.

----------

# 5️⃣ Ejemplo real en tu academia

Programa:

`Transición A320` 

Versión:

`Completo` 

Estructuras:

`Completo v1  (2025)
Completo v2  (2026)` 

----------

### v1

`Fase Tierra 16 sesiones 37 horas` 

### v2

`Fase Tierra 14 sesiones 30 horas` 

Los alumnos antiguos **no se rompen**.

----------

# 6️⃣ Entonces ¿qué debemos hacer?

Cuando entres a:

`/admin/program-builder/7/version/3` 

el sistema debe:

### 1️⃣ Buscar la estructura activa

`program_structure_version WHERE  program_version_id  =  3` 

### 2️⃣ Obtener el `structure_id`

### 3️⃣ Cargar módulos con

`structure_id` 

----------

# 7️⃣ Flujo correcto

`versionId ↓
program_structure_version
   ↓
structureId
   ↓
modules
   ↓
sessions` 

----------

# 8️⃣ Qué significa para tu builder

Tu builder no debe hacer:

`version → modules` 

Debe hacer:

`version → structure → modules` 

----------

# 9️⃣ La buena noticia

Tu **base de datos ya está diseñada correctamente**.

Solo debemos ajustar:

`queries` 

y el builder funcionará perfecto.

----------

# 🔟 Lo importante

Tu arquitectura actual es **muy buena** porque soporta:

`Completo Híbrido` 

con diferentes horas de teoría:

`37 horas
18.5 horas` 

sin romper nada.

----------

# 🚀 Próximo paso recomendado

Antes de seguir con módulos te propongo hacer **una mejora pequeña pero muy poderosa**:

Cuando creas una versión:

`Completo` 

el sistema cree automáticamente:

`program_structure_version v1
Fase Tierra
Fase Observador
Fase Simulador` 

y así el admin **no tiene que crear todo desde cero**.

Eso convierte tu sistema en un **Program Builder de nivel profesional**.
