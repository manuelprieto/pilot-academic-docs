# DIAGRAMA DEFINITIVO LIMPIO (Modelo Académico Institucional)

Voy a dibujarlo textual tipo arquitecto.

----------

## 🔷 CAPA INSTITUCIONAL

program  
│  
├── id  
├── name  
├── code  
├── structure_type        (STRUCTURED | HOUR_BASED | SESSION_PACKAGE)  
├── priority_level  
├── time_limit_months  
├── base_program_id  
└── created_at

Define identidad institucional del programa.

----------

## 🔷 CAPA VERSIONAMIENTO COMERCIAL

program_version  
│  
├── id  
├── program_id  → FK program  
├── code        (A320-2026, REGULAR, HIBRIDO, etc)  
├── active  
└── created_at

Define versiones comerciales del programa.

----------

## 🔷 CAPA VERSIONAMIENTO ACADÉMICO (MALLA)

program_structure_version  
│  
├── id  
├── program_version_id  → FK program_version  
├── created_at  
└── is_active

Congela estructura académica.

----------

## 🔷 JERARQUÍA ACADÉMICA VERSIONADA

program_phase  
│  
├── id  
├── program_structure_version_id → FK program_structure_version  
├── name  
├── sequence_order

program_module  
│  
├── id  
├── program_structure_version_id → FK program_structure_version  
├── phase_id → FK program_phase  
├── name  
├── sequence_order  
├── module_type  
├── duration_hours

phase_session_template  
│  
├── id  
├── program_structure_version_id  
├── program_module_id  
├── name  
├── session_number  
├── session_category  
├── delivery_mode  
├── is_mandatory  
├── requires_previous_completion  
├── unlocks_next  
└── ...

----------

## 🔷 CAPA CONTRACTUAL (ESTUDIANTE)

enrollment  
│  
├── id  
├── student_id  
├── program_id  
├── program_version_id  
├── program_structure_version_id  
├── structure_type     (snapshot congelado)  
├── start_date  
├── status  
└── created_at

Enrollment es contrato histórico.

----------

## 🔷 CAPA PROGRESO ACADÉMICO

student_phase_progress  
│  
├── id  
├── student_id  
├── enrollment_id  
├── phase_session_template_id  
├── status (LOCKED | PENDING | SCHEDULED | COMPLETED | FAILED)  
├── completed_at  
└── course_session_id

Unique:

UNIQUE (enrollment_id, phase_session_template_id)

Esto es correcto y ya lo ajustaste.

----------

## 🔷 CAPA OPERATIVA

course_session  
│  
├── id  
├── enrollment_id  
├── phase_session_template_id  
├── instructor_id  
├── session_date  
├── start_time  
├── end_time  
├── academic_status

reservation  
│  
├── id  
├── student_id  
├── course_session_id  
├── role_type (PF | PM | OBSERVER)  
├── attendance_status  
├── cancellation_reason  
└── ...
