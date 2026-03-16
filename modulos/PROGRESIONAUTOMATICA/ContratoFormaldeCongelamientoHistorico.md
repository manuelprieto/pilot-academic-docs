# CONTRATO FORMAL DE CONGELAMIENTO HISTÓRICO

Este es el documento conceptual que debes respetar en código.

----------

## 🔐 REGLA 1 — Congelamiento en matrícula

Al crear enrollment:

Se deben congelar:

-   program_id
    
-   program_version_id
    
-   program_structure_version_id
    
-   structure_type
    
-   start_date
    

Nada de esto puede modificarse después.

----------

## 🔐 REGLA 2 — Estructura inmutable

Una vez que:

program_structure_version.is_active = true

Y tiene enrollments asociados:

NO se puede modificar:

-   program_phase
    
-   program_module
    
-   phase_session_template
    

Solo se puede crear una nueva structure_version.

----------

## 🔐 REGLA 3 — Progreso depende del enrollment

student_phase_progress depende exclusivamente de:

enrollment_id

No depende del programa directamente.

Esto evita contaminación histórica.

----------

## 🔐 REGLA 4 — Cambios futuros no afectan históricos

Si mañana:

-   Cambias módulos
    
-   Cambias secuencia
    
-   Cambias duración
    
-   Cambias prioridad
    

Eso NO afecta enrollments ya creados.

Porque:

enrollment → program_structure_version

Está congelado.

----------

## 🔐 REGLA 5 — Eliminaciones controladas

Nunca se hace:

DELETE program_structure_version

Si tiene enrollments.

Solo se desactiva.

----------

# 🧠 Resultado Arquitectónico

Tienes ahora:

✔ Versionamiento real  
✔ Historial congelado  
✔ Trazabilidad institucional  
✔ Separación identidad vs ejecución  
✔ Modelo compatible con auditoría  
✔ Escalable para multi-programa

----------

# 🚀 SIGUIENTE PASO EN CÓDIGO

Ahora sí podemos avanzar con seguridad a:

1️⃣ Motor automático de progreso completo  
2️⃣ Trigger lógico de desbloqueo  
3️⃣ Motor disciplinario  
4️⃣ Motor de certificación
