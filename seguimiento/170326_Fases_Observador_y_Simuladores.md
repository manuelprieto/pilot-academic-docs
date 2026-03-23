# Dónde entran Observador y Simulador

Son simplemente **módulos diferentes dentro de la misma estructura**:

program_structure_version  
 ↓  
program_module  
 ├── Fase Tierra  
 ├── Observador  
 └── Simulador

----------

# 🎯 Cada fase cumple un rol distinto

## 🟤 1. FASE TIERRA

👉 Teoría

-   16 clases
    
-   37h o 18.5h
    
-   session_type = THEORY
    

----------

## 🔵 2. OBSERVADOR

👉 El estudiante **no pilota**, observa

-   sesiones en simulador como acompañante
    
-   aprende flujo real
    
-   session_type = OBSERVER
    

----------

## 🔴 3. SIMULADOR

👉 Aquí sí ejecuta

-   sesiones prácticas
    
-   horas de simulador
    
-   session_type = SIMULATOR
    

----------

# 🧠 Cómo se modela en tu sistema

Todo sigue la misma estructura:

program_module  
 ↓  
phase_session_template

----------

## ✔ Ejemplo real

### 🟤 Fase Tierra

Módulo: Fase Tierra  
 Sesión 1 → Despacho 1 (3h)  
 Sesión 2 → Despacho 2A (2.5h)

----------

### 🔵 Observador

Módulo: Observador  
 Sesión 1 → Observación 1 (2h)  
 Sesión 2 → Observación 2 (2h)

----------

### 🔴 Simulador

Módulo: Simulador  
 Sesión 1 → SIM 1 (2.5h)  
 Sesión 2 → SIM 2 (2.5h)

----------

# 🔥 Importante (muy clave)

👉 **NO son fases separadas del sistema**  
👉 Son **módulos con distinto tipo**

----------

# 🧩 Diferencia real

Fase

Qué cambia

Tierra

contenido teórico

Observador

tipo de sesión

Simulador

ejecución práctica

----------

# 🧠 Dónde se usan después

Esto impacta directamente en:

----------

## 1️⃣ Matrícula

enrollment  
 ↓  
estructura  
 ↓  
TODAS las fases

----------

## 2️⃣ Progreso

student_phase_progress

Ejemplo:

Tierra → completado  
Observador → en progreso  
Simulador → bloqueado

----------

## 3️⃣ Reglas de desbloqueo (clave)

No puedes hacer SIMULADOR  
si no terminaste TIERRA

👉 Esto ya lo tienes parcialmente con:

requires_previous_completion

----------

## 4️⃣ Agenda real

course_session

-   Tierra → aula / virtual
    
-   Observador → simulador (sin control)
    
-   Simulador → simulador (con control)
    

----------

# 🚀 Flujo completo

TIERRA → OBSERVADOR → SIMULADOR

----------

# 💡 Insight importante

👉 Las 3 fases son:

una sola experiencia académica  
dividida en módulos

----------

# ✔ Conclusión clara

👉 Observador y Simulador:

-   son módulos ✔
    
-   tienen sus propias sesiones ✔
    
-   viven en la misma estructura ✔
    
-   afectan progreso ✔
    
-   afectan agenda ✔
    

----------

# 🚀 Qué hacemos ahora

Ya tienes:

✔ Fase Tierra  
👉 Siguiente:

1.  crear Observador
    
2.  crear Simulador
    
3.  luego crear sesiones
