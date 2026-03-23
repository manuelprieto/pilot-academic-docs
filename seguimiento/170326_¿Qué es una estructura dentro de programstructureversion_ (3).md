# ¿Qué es “estructura 3” o “estructura 7”?

👉 Son simplemente los **IDs de la tabla**:

program_structure_version

----------

# 📊 Ejemplo real de tu tabla

id

program_version_id

is_active

3

1

true

4

2

true

7

5

true

----------

# 🎯 Entonces…

## ✔ “estructura 3” significa:

program_structure_version.id = 3

----------

# 🧠 Traducción completa

## ✈️ Programa 1 — Transición Aerolínea

program = Transición  
 ↓  
version = COMPLETO  
 ↓  
estructura = id 3  ← 🔥 ESTE ES  
 ↓  
modules  
 ↓  
sessions

----------

## ✈️ Programa 2 — A320 Refresher

program = Refresher  
 ↓  
version = COMPLETO  
 ↓  
estructura = id 7  ← otro registro distinto  
 ↓  
modules  
 ↓  
sessions

----------

# 🔥 Importante

👉 “estructura” NO es un nombre lógico  
👉 es un **registro físico en la BD**

----------

# 🧠 Qué representa realmente

program_structure_version = snapshot del programa

Es decir:

“cómo está definido el programa en ese momento”

----------

# 💡 Ejemplo práctico

Hoy tienes:

estructura 3  
- 16 sesiones  
- 37 horas

Mañana cambias:

estructura 5  
- 12 sesiones  
- 25 horas

----------

# 🚀 Entonces

Cuando matriculas:

enrollment  
 ↓  
program_structure_version_id = 3

👉 el estudiante queda amarrado a esa estructura

----------

# ⚠️ Muy importante

👉 Dos programas pueden tener:

estructura 3  
estructura 7

aunque ambos sean “COMPLETO”

porque:

son programas distintos

----------

# 🧠 Resumen claro

estructura = fila en program_structure_version

👉 identifica:

-   versión
    
-   contenido
    
-   módulos
    
-   sesiones
    

----------

# ✔ Conclusión

👉 “estructura 3” = ID en BD  
👉 es el plan académico activo  
👉 cambia cuando haces nuevas versiones

----------

# 🚀 Con esto claro

Ahora sabes que cuando creas sesiones estás trabajando sobre:

program_structure_version_id (activo)
