# DOCUMENTO TÉCNICO – PROGRAM BUILDER (ESTADO ACTUAL Y EVOLUCIÓN)

## 🧠 1. OBJETIVO DEL DOCUMENTO

Definir:

-   Qué partes del sistema están **hardcodeadas actualmente**
    
-   Qué debe migrarse a **base de datos**
    
-   Cómo evolucionar hacia un sistema **escalable, configurable y profesional**
    

----------

# 🏗️ 2. ARQUITECTURA ACTUAL

### Flujo principal:

```
Program
  ↓
Program Version
  ↓
Program Structure Version
  ↓
Program Module (GROUND / OBSERVER / SIMULATOR)
  ↓
Phase Session Template (sesiones)
```

----------

# ⚙️ 3. COMPONENTES IMPLEMENTADOS

## ✅ Frontend

-   ProgramStructure.jsx
    
-   ProgramTimeline.jsx
    
-   ModuleSessions.jsx
    
-   CreateSessionModal.jsx
    

## ✅ Backend

-   programBuilderController
    
-   programBuilderService
    
-   endpoints REST
    

## ✅ Base de datos

-   program
    
-   program_version
    
-   program_structure_version
    
-   program_module
    
-   phase_session_template
    

----------

# 🔥 4. FUNCIONALIDADES ACTUALES

✔ Crear programas  
✔ Versionar programas  
✔ Crear módulos  
✔ Crear sesiones manuales  
✔ Editar / eliminar sesiones  
✔ Visualizar timeline  
✔ ⚡ Generación automática de sesiones

----------

# ⚠️ 5. ELEMENTOS HARDCODEADOS (ACTUALMENTE)

## 🔴 5.1 Plantillas de sesiones (CRÍTICO)

Ubicación:

```
programBuilder.service.js
```

Ejemplo:

```
const templates = {
  COMPLETO: [...],
  HIBRIDO: [...]
};
```

### Problema:

-   No editable por admin
    
-   Requiere deploy
    
-   No escalable
    

----------

## 🔴 5.2 Tipos de sesión (frontend)

```
THEORY
SIMULATOR
EVALUATION
```

### Problema:

-   Fijo en código
    
-   No configurable
    

----------

## 🔴 5.3 Tipos de módulo (implícito)

```
GROUND
OBSERVER
SIMULATOR
```

### Problema:

-   No existe tabla de referencia
    
-   No parametrizable
    

----------

## 🔴 5.4 Lógica de generación automática

```
if version = COMPLETO → usar template A
if version = HIBRIDO → usar template B
```

### Problema:

-   Acoplado al código
    
-   No extensible
    

----------

# 🟢 6. QUÉ DEBE MIGRARSE A BASE DE DATOS

----------

## 🧩 6.1 Tabla: session_template_master (PRIORIDAD ALTA)

```
CREATE TABLE session_template_master (
  id SERIAL PRIMARY KEY,
  program_version_id INT,
  module_type VARCHAR(20),
  session_number INT,
  name VARCHAR(150),
  duration_hours NUMERIC(4,2),
  session_type VARCHAR(20),
  phase_type VARCHAR(20),
  is_active BOOLEAN DEFAULT true
);
```

### Beneficios:

✔ Configurable sin código  
✔ Soporta múltiples versiones  
✔ Escalable

----------

## 🧩 6.2 Tabla: module_type (RECOMENDADO)

```
CREATE TABLE module_type (
  id SERIAL PRIMARY KEY,
  code VARCHAR(20),
  name VARCHAR(50)
);
```

Ejemplo:

-   GROUND
    
-   OBSERVER
    
-   SIMULATOR
    

----------

## 🧩 6.3 Tabla: session_type (RECOMENDADO)

```
CREATE TABLE session_type (
  id SERIAL PRIMARY KEY,
  code VARCHAR(20),
  name VARCHAR(50)
);
```

Ejemplo:

-   THEORY
    
-   SIMULATOR
    
-   EVALUATION
    

----------

## 🧩 6.4 Configuración de generación (OPCIONAL)

```
program_version_config
```

campo

uso

auto_generate

habilitar generación

strategy

TEMPLATE / DYNAMIC

----------

# 🔄 7. EVOLUCIÓN DEL SISTEMA

----------

## 🟡 ETAPA ACTUAL (YA LOGRADA)

✔ Sistema funcional  
✔ Generación automática básica  
✔ Flujo completo operativo

----------

## 🔵 ETAPA 2 (SIGUIENTE)

Migrar:

-   templates → BD
    
-   tipos → BD
    
-   lógica → configurable
    

----------

## 🚀 ETAPA 3 (PRO)

-   UI para editar templates
    
-   clonación de programas
    
-   versionado de templates
    
-   multi-aeronave
    

----------

# 🧠 8. DECISIONES DE DISEÑO IMPORTANTES

----------

## ✔ Separación correcta

concepto

campo

tipo de sesión

session_type

fase del programa

phase_type

----------

## ✔ Automatización por módulo

módulo

comportamiento

GROUND

automático

OBSERVER

manual

SIMULATOR

manual / semi-auto

----------

# 🚨 9. RIESGOS ACTUALES

-   Hardcode limita escalabilidad
    
-   Cambios requieren deploy
    
-   Dependencia del desarrollador
    

----------

# 🟢 10. ESTADO ACTUAL DEL SISTEMA

El sistema ya es:

✔ Funcional  
✔ Modular  
✔ Extensible  
✔ Preparado para escalar

----------

# 🎯 11. PRÓXIMO PASO ESTRATÉGICO

👉 MATRÍCULA AUTOMÁTICA

Donde se conectan:

-   sessions
    
-   modules
    
-   progreso del estudiante
    

----------

# 🧾 12. RESUMEN EJECUTIVO

Área

Estado

Builder

✔ completo

Sesiones

✔ manual + auto

Templates

❌ hardcoded

Configuración

❌ no persistente

Escalabilidad

🟡 media

Preparación para producción

🟢 alta
