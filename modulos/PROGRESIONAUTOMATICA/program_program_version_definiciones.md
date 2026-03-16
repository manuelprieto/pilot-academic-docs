# DIAGRAMA MENTAL COMPLETO DEL SISTEMA ACADÉMICO

Imagina una pirámide.

----------

## 🟦 NIVEL 1 — PROGRAMA (Concepto Comercial)

PROGRAM

Ejemplo:

Transición Aerolínea  
Curso Inicial A320  
Recurrente B1900

Tabla: `program`

Esto es solo el nombre del producto.

----------

## 🟦 NIVEL 2 — VERSIÓN DEL PROGRAMA (Plan Académico)

PROGRAM_VERSION

Ejemplo:

Transición Aerolínea v1 (2025)  
Transición Aerolínea v2 (2026)

Aquí es donde vive:

-   Código del programa (TA-1)
    
-   Posible cambio de estructura futura
    

👉 Este es el famoso `programVersionId`

----------

## 🟦 NIVEL 3 — ESTRUCTURA ACTIVA

PROGRAM_STRUCTURE_VERSION

Esto define:

-   Qué módulos existen
    
-   Qué fases existen
    
-   Cuántas sesiones hay
    

Ejemplo:

Estructura Regular 16 sesiones  
Estructura Intensiva 12 sesiones

Aquí decides:

REGULAR  
INTENSIVO

----------

## 🟦 NIVEL 4 — PLANTILLAS DE SESIÓN

PHASE_SESSION_TEMPLATE

Aquí están las 16 sesiones definidas:

Sesión 1 – Briefing  
Sesión 2 – Maniobras  
Sesión 3 – Emergencias  
...  
Sesión 16 – Check final

Estas son las plantillas base.

----------

## 🟦 NIVEL 5 — ENROLLMENT (Contrato Académico del Estudiante)

Cuando matriculas:

STUDENT + PROGRAM_VERSION

Se crea:

ENROLLMENT

Que contiene:

-   student_id
    
-   program_id
    
-   program_version_id
    
-   structure_version_id
    
-   status = ACTIVE
    

----------

## 🟦 NIVEL 6 — PROGRESO REAL DEL ESTUDIANTE

Cuando se crea enrollment:

Se copian las 16 plantillas a:

STUDENT_PHASE_PROGRESS

Y ahora ya no son plantillas.  
Son sesiones reales del estudiante.

----------

# 🎯 Diagrama resumido visual

PROGRAM  
 ↓  
PROGRAM_VERSION  ← programVersionId  
 ↓  
PROGRAM_STRUCTURE_VERSION  
 ↓  
PHASE_SESSION_TEMPLATE (16)  
 ↓  
ENROLLMENT (del estudiante)  
 ↓  
STUDENT_PHASE_PROGRESS (16 reales)

----------

# 🚀 Entonces…

Cuando en el frontend eliges:

Programa: Transición Aerolínea

En realidad estás enviando:

programVersionId = 1

Porque eso es lo que define:

-   Qué estructura usar
    
-   Cuántas sesiones crear
    
-   Qué reglas aplicar
    

----------

# 🔥 Regla mental que debes recordar

👉 `program` es comercial  
👉 `program_version` es académico  
👉 `structure_version` es estructural  
👉 `enrollment` es contractual  
👉 `progress` es operativo
