# EL PUNTO CLAVE

Hay **dos conceptos distintos** que se están llamando igual:

-   `structure_type` como **naturaleza institucional del programa**
    
-   `structure_type` como **modalidad de ejecución de una versión**
    

Y eso es lo que genera confusión.

----------

# 🧠 Capa 1 — PROGRAM (Identidad institucional)

Esto define:

-   Qué es el programa en esencia.
    
-   Su comportamiento institucional.
    
-   Su prioridad organizacional.
    
-   Su duración máxima.
    
-   Su relación con otros programas.
    

Ejemplo:

Programa

Tipo

Prioridad

A320 Transición

STRUCTURED

1

Banco de horas 1900

HOUR_BASED

2

Repaso

STRUCTURED

3

Eso sí pertenece a `program`.

Entonces:

program  
---------  
id  
name  
code  
structure_type -- STRUCTURED / HOUR_BASED / SESSION_PACKAGE  
priority_level  
time_limit_months  
base_program_id  
created_at

✅ Aquí debe quedarse.

Estoy de acuerdo contigo.

----------

# 🧠 Capa 2 — PROGRAM_VERSION (Modalidad comercial)

Aquí ya no hablamos de naturaleza institucional.

Aquí hablamos de:

-   Versión Regular
    
-   Versión Híbrida
    
-   Versión Ligera
    
-   Versión 2026
    
-   Versión con malla nueva
    

Eso NO es lo mismo que structure_type.

Entonces `program_version` no necesita `structure_type` si el tipo institucional ya vive en program.

----------

# 🧠 Capa 3 — PROGRAM_STRUCTURE_VERSION

Esto no define tipo.

Define:

-   Snapshot congelado de módulos
    
-   Snapshot congelado de fases
    
-   Snapshot congelado de subdivisiones
    

Es una fotografía académica.

No define si es STRUCTURED o HOUR_BASED.  
Eso ya viene del programa madre.

----------

# 🚨 Entonces… ¿Qué pasa con enrollment.structure_type?

Aquí es donde está la decisión arquitectónica fina.

## Opción 1 — Arquitectura Normalizada Pura

Enrollment NO guarda structure_type.

Porque puede obtenerlo así:

enrollment  
→ program_version  
→ program  
→ structure_type

Ventaja:

-   Sin redundancia.
    
-   Modelo limpio.
    

Desventaja:

-   Si mañana cambias structure_type del programa,  
    los enrollments históricos reflejarían el nuevo valor.
    

Eso puede romper trazabilidad histórica.

----------

## Opción 2 — Arquitectura Histórica Congelada (más sólida)

Enrollment SÍ guarda structure_type,  
pero como snapshot congelado al momento de matrícula.

Ventaja:

-   Si el programa cambia en el futuro,  
    el enrollment histórico mantiene su contexto original.
    
-   Es más robusto para auditoría institucional.
    

Desventaja:

-   Hay duplicidad controlada.
    

----------

# 🎯 ¿Qué recomiendo para tu sistema?

Dado que tú estás construyendo:

-   Motor académico
    
-   Motor financiero
    
-   Motor disciplinario
    
-   Certificación
    
-   Historial completo
    
-   Posibles auditorías
    

👉 Yo recomiendo congelar también `structure_type` en enrollment.

Porque tu sistema es académico formal, no solo operativo.

----------

# 🔬 Entonces la decisión profesional final sería:

## ✅ program

Mantener:

structure_type  
priority_level  
time_limit_months  
base_program_id

----------

## ✅ enrollment

Mantener:

structure_type -- snapshot congelado  
program_structure_version_id

Porque enrollment es un contrato histórico.

----------

# 📌 Entonces tu tabla enrollment correcta debería ser:

enrollment  
-----------  
id  
student_id  
program_id  
program_version_id  
program_structure_version_id  
structure_type -- congelado  
start_date  
status  
created_at

Y al momento de matrícula:

-   Lees structure_type desde program
    
-   Lo guardas en enrollment
    
-   Lo congelas
    

----------

# 🧠 Diferencia importante

`program.structure_type` = identidad actual del programa  
`enrollment.structure_type` = contexto congelado al momento de matrícula

No son duplicidad accidental.  
Son duplicidad controlada para auditorí
