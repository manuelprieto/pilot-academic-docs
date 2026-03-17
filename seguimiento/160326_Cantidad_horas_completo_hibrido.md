los programas de fase tierra si son completo tienen mas carga horaria osea su fase tierra son 37 horas pero si son hibrido son 18.5 horas esto esta contemplado?

Excelente 🔥 ya estás en el punto correcto del sistema.

Voy directo a tu duda porque es **CLAVE de negocio** 👇

----------

# 🧠 Tu pregunta (muy importante)

> ¿Fase Tierra cambia según versión (Completo vs Híbrido)?

Ejemplo:

-   Completo → 37 horas
    
-   Híbrido → 18.5 horas
    

----------

# ✔ Respuesta corta

👉 **SÍ está contemplado en tu arquitectura actual**  
👉 **Pero todavía no lo estás usando correctamente en el builder**

----------

# 💡 Cómo funciona realmente tu sistema

Tu arquitectura es:

program  
 ↓  
program_version   ← 🔥 AQUÍ vive Completo / Híbrido  
 ↓  
program_structure_version  
 ↓  
program_module  
 ↓  
phase_session_template

----------

# 🎯 Dónde se define la diferencia

La diferencia **NO está en el módulo**  
Está en las **sesiones (phase_session_template)**

----------

## ✔ Ejemplo real

### 🔵 Versión COMPLETO

Fase Tierra  
 ↓  
16 sesiones  
 ↓  
duración total = 37 horas

----------

### 🟢 Versión HÍBRIDO

Fase Tierra  
 ↓  
16 sesiones (o menos)  
 ↓  
duración total = 18.5 horas

----------

# ⚠️ Lo importante (esto es clave Manuel)

👉 **NO debes cambiar el módulo**  
👉 **Debes cambiar las sesiones dentro de esa versión**

----------

# 🚀 Cómo lo vas a manejar correctamente

Cuando entras aquí:

/admin/program-builder/{programId}/version/{versionId}

Estás trabajando sobre:

UNA versión específica

Entonces:

Versión

Fase Tierra

Sesiones

Completo

igual

más horas

Híbrido

igual

menos horas

----------

# 🧠 Conclusión arquitectónica

version = define carga académica  
module = solo agrupa  
sessions = definen contenido real

----------

# ✔ Entonces SI está contemplado

Gracias a esto:

program_structure_version_id

Cada versión puede tener:

-   módulos iguales ✔
    
-   sesiones diferentes ✔
    
-   duración diferente ✔
    

----------

# 🔥 Ejemplo en tu BD

Tú podrías tener:

-- versión completo  
phase_session_template → 16 filas → sum =  37h  
  
-- versión híbrido  
phase_session_template → 16 filas → sum =  18.5h
