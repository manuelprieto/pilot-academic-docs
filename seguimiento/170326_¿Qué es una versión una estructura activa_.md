# ¿Qué significa?

### 👉 **“1 versión = 1 estructura activa”**

Significa que:

Para cada program_version (Completo / Híbrido)  
solo puede existir UNA estructura vigente

----------

# 🎯 Traducido a tu sistema

Tú tienes esto:

program_version  
 ↓  
program_structure_version

Entonces:

### ✔ Ejemplo correcto

COMPLETO (version_id = 1)  
  
estructura 1 → antigua (inactiva)  
estructura 3 → actual (activa) ✅

HÍBRIDO (version_id = 2)  
  
estructura 4 → actual (activa) ✅

----------

# ❌ Ejemplo incorrecto (lo que evitamos)

HÍBRIDO  
  
estructura 4 → activa  
estructura 5 → activa ❌

👉 Aquí el sistema **no sabría cuál usar**

----------

# 🧠 ¿Por qué es tan importante?

Porque TODO depende de eso:

enrollment  
 ↓  
program_structure_version_id  
 ↓  
sessions  
 ↓  
progreso

----------

# 🚨 Si tienes 2 activas pasa esto:

-   ❌ matrícula toma estructura equivocada
    
-   ❌ sesiones inconsistentes
    
-   ❌ progreso corrupto
    
-   ❌ reportes incorrectos
    

----------

# 🔥 Ejemplo real (muy claro)

Imagina:

HÍBRIDO  
  
estructura 4 → 18.5h  
estructura 5 → 25h

Si ambas están activas:

👉 ¿Cuál usa el sistema al matricular?  
👉 ❗ No hay forma de saberlo

----------

# ✔ Con la regla aplicada

HÍBRIDO  
  
estructura 4 → inactiva  
estructura 5 → activa ✅

Entonces:

TODAS las nuevas matrículas usan estructura 5

----------

# 🧠 Analogía simple

Piensa en esto como:

Versión = tipo de programa  
Estructura = plan de estudios vigente

Y la regla es:

Solo puede haber UN plan vigente por tipo

----------

# 📌 Cómo lo usa tu sistema

Cuando haces:

SELECT id  
FROM program_structure_version  
WHERE program_version_id =  2  
AND is_active =  true;

👉 El sistema espera **UNA sola fila**

----------

# ✔ Resumen brutalmente claro

version → puede tener muchas estructuras  
pero solo UNA puede estar activa

----------

# 🚀 Por qué esto es clave para ti

Esto te permite:

✔ cambiar programas sin romper estudiantes antiguos  
✔ mantener historial académico  
✔ evolucionar el currículo  
✔ soportar cambios de horas (tu caso real)

----------

# 💡 Conclusión

👉 “1 versión = 1 estructura activa” es lo que garantiza que:

el sistema siempre sepa qué plan académico usar
