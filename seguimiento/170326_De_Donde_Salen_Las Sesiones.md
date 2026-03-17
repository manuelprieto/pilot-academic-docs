# ¿De dónde salen las sesiones?

Tienes **3 opciones reales** (de más simple a más profesional):

----------

# 🟢 OPCIÓN 1 — Hardcode (rápido para arrancar)

Tú defines un arreglo en el backend:

const  groundSessionsCompleto  = [  
 { name: "Despacho 1", hours: 3 },  
 { name: "Despacho 2A", hours: 2.5 },  
 { name: "Despacho 2B", hours: 2 },  
 ...  
];

👉 Ventajas:

-   Rápido
    
-   Control total
    

👉 Desventaja:

-   No editable desde UI
    

----------

# 🟡 OPCIÓN 2 — Plantillas en base de datos (RECOMENDADO 🚀)

Creas una tabla:

program_template_session

Ejemplo:

template_name: "GROUND_COMPLETO"  
session_number: 1  
name: "Despacho 1"  
duration_hours: 3

Y otra:

template_name: "GROUND_HIBRIDO"

----------

👉 Entonces el botón hace:

Seleccionar template → clonar sesiones → insertarlas en phase_session_template

----------

# 🔵 OPCIÓN 3 — Configurable desde UI (nivel pro SaaS)

Un panel tipo:

Crear Plantilla Académica

Donde defines:

-   nombre
    
-   duración
    
-   orden
    
-   tipo
    

----------

# 🎯 Para tu caso (recomendación directa)

👉 Usa **OPCIÓN 2 (plantillas en DB)**

Porque tu sistema ya es:

multi-programa  
multi-versión  
multi-estructura

Necesitas algo flexible.

----------

# 🧩 Cómo funcionaría el botón

### Paso 1 — Detectar versión

version.name = "Completo" | "Híbrido"

----------

### Paso 2 — Elegir plantilla

GROUND_COMPLETO  
GROUND_HIBRIDO

----------

### Paso 3 — Insertar sesiones

INSERT  INTO phase_session_template (...)  
SELECT ...  
FROM program_template_session  
WHERE template_name =  'GROUND_COMPLETO'

----------

# 💡 Ejemplo real para ti

## COMPLETO (37h)

16 sesiones  
duraciones mixtas

## HÍBRIDO (18.5h)

mismas sesiones  
pero con menor duración  
(o menos sesiones)

----------

# 🔥 Importante (esto es arquitectura pura)

No estás creando “clases”…

Estás creando:

plantillas académicas reutilizables

----------

# ✔ Resumen claro

Elemento

Quién define

Nombre sesión

plantilla

Orden

plantilla

Duración

plantilla

Tipo

plantilla

Diferencia completo/híbrido

plantilla

----------

# 🚀 Mi recomendación concreta para TI

Como estás construyendo rápido:

👉 Fase 1 (YA):

-   Hardcode en backend ✔
    

👉 Fase 2 (luego):

-   Migrar a tabla `program_template_session`
    

----------

# ⚡ Si quieres avanzar YA

Puedo darte:

👉 el endpoint listo  
👉 el array de 16 clases de Fase Tierra  
👉 el botón en UI

para que en **1 clic tengas todo armado**

----------

Solo dime:

👉 _“vamos con hardcode primero”_  
o  
👉 _“hagamos plantilla profesional desde ya”_
