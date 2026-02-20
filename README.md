Pilot Academic System – Technical Documentation
📌 Overview

This repository contains the official technical documentation of the Pilot Academic System.

The system is designed as a hierarchical academic management platform that supports:

Program management

Modular academic progression

Instructor and student administration

Enrollment workflows

Attendance tracking

Academic progression engine

This repository is the single source of truth for architectural decisions and system design.

🏗 System Architecture

The system follows a modular backend architecture:

Backend: Node.js + Express

Database: PostgreSQL

Authentication: Role-based access control

API Structure: RESTful

ORM: None (Direct pool queries)

Architecture details are documented in:

/architecture

🧠 Core Academic Model

The academic structure follows a hierarchical model:

Program
 └── Program Module
       └── Program Phase
             └── Phase Session Template
                   └── Course Session (runtime)


This structure enables:

Structured academic progression

Configurable learning paths

Session-based attendance control

Controlled student advancement

Detailed ER diagrams and table definitions are located in:

/database

📦 Main Modules

The system is divided into functional modules:

Module	Description
Users	Base user management and roles
Students	Student lifecycle management
Instructors	Instructor assignment and session handling
Enrollment	Student enrollment into programs
Progression Engine	Academic advancement logic
Attendance	Session-level attendance tracking
Administration	Admin-level system management

Full module documentation:

/modules

🔐 Role Structure

The platform supports role-based access:

Admin

Instructor

Student

Each role has specific endpoints and permissions.

API documentation:

/api

📊 Academic Flow

High-level student lifecycle:

Admin creates program structure.

Student is created.

Student is enrolled in a program.

Course sessions are generated from phase templates.

Student attendance is recorded.

Progression engine evaluates advancement.

Student advances to next phase/module.

Business rules:

/business-rules

🧾 Architecture Decision Records (ADR)

All important architectural decisions are documented under:

/architecture/decisions


Each ADR contains:

Context

Problem

Decision

Consequences

🎯 Design Principles

Clear separation of concerns

Hierarchical academic structure

Explicit business rule documentation

Version-controlled architecture

No hidden logic outside documentation

Backend-first design

🚀 Versioning Strategy

This documentation follows semantic clarity:

Major changes: structural or architectural modifications

Minor changes: module updates

Patch: clarifications and corrections

👤 Maintained By

Pilot Academic System
IGO SYSTEMS