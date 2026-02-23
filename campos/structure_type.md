Aquí ya estamos tomando decisiones de **modelo institucional**, no solo técnicas.

Voy a separar esto en tres capas porque hay una confusión conceptual importante:

-   `program.structure_type`
    
-   `enrollment.structure_type`
    
-   `program_structure_version`
    

No son lo mismo.

----------

# 1️⃣ ¿Debe existir `structure_type` en program?

Sí.  
Y te explico por qué.

`program.structure_type` define la **naturaleza del programa institucionalmente**, por ejemplo:

STRUCTURED        → Programa con malla fija  
HOUR_BASED        → Programa por bolsa de horas  
SESSION_PACKAGE   → Paquete específico de sesiones

Eso es una característica del PROGRAMA, no del enrollment.

Ejemplo:

Program

structure_type

A320 Transición

STRUCTURED

Banco de horas 1900

HOUR_BASED

Simulación puntual

SESSION_PACKAGE

👉 Eso pertenece a la identidad del programa.

Por lo tanto:

✅ Debe quedarse en `program`.  
❌ No debe eliminarse.

----------

# 2️⃣ ¿Debe existir `structure_type` en enrollment?

Aquí es donde hay duplicidad conceptual.

Si enrollment ya tiene:

program_id  
program_version_id  
program_structure_version_id

Entonces el tipo estructural puede obtenerse desde:

enrollment → program_version → program → structure_type

Por lo tanto:

👉 `enrollment.structure_type` es redundante.

Y la redundancia estructural genera riesgo.

----------

# 3️⃣ ¿Qué recomienda arquitectura limpia?

Lo correcto sería:

### En `program`

structure_type  
priority_level  
time_limit_months  
base_program_id

### En `enrollment`

Eliminar:

structure_type

Porque el enrollment ya está vinculado al programa.

----------

# 4️⃣ Sobre priority_level

Esto es muy importante institucionalmente.

Ejemplo real:

A320 tiene prioridad 1  
Transición 2  
Repaso 3  
Prepiloto 4

Eso sirve para:

-   Asignación automática de instructores
    
-   Asignación de simulador
    
-   Resolución de conflictos
    
-   Ventanas preferenciales
    

👉 Esto pertenece al programa, no al enrollment.

Debe quedarse en `program`.

----------

# 5️⃣ Sobre time_limit_months

Esto define:

Duración máxima del programa

Ejemplo:

-   4 meses para Transición
    
-   2 meses para Repaso
    

Eso también es propiedad del programa.

Debe quedarse en `program`.

----------

# 6️⃣ Conclusión Arquitectónica Profesional

Campo

Tabla correcta

Decisión

structure_type

program

✅ mantener

priority_level

program

✅ mantener

time_limit_months

program

✅ mantener

base_program_id

program

✅ mantener

structure_type en enrollment

enrollment

❌ eliminar
