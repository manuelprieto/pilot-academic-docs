System Overview
1. Purpose

The Pilot Academic System is a modular academic management platform designed to manage structured learning programs using a hierarchical progression model.

The system allows administrators to define academic programs composed of modules and phases, assign instructors, enroll students, and track academic progression based on attendance and predefined rules.

The objective is to provide a scalable and structured framework for controlled academic advancement.

2. Problem Statement

Traditional academic systems often lack:

Structured hierarchical progression

Clear separation between academic design and runtime sessions

Formalized progression rules

Modular extensibility

This system addresses those limitations by introducing:

A hierarchical academic model

Explicit enrollment workflows

Session-based attendance tracking

A dedicated progression evaluation layer

3. High-Level Architecture

The system is divided into three primary layers:

3.1 Application Layer (Backend)

Node.js

Express

RESTful API

Role-based access control

Responsibilities:

Business logic

Validation

Progression evaluation

Enrollment management

Session management

3.2 Data Layer

PostgreSQL

Direct pool queries (no ORM)

Responsibilities:

Academic structure persistence

Student lifecycle tracking

Attendance storage

Progression data integrity

3.3 Client Layer (Frontend)

Dashboard interfaces for:

Admin

Instructor

Student

Responsibilities:

User interaction

Session booking

Attendance visualization

Academic progress tracking

4. Core Domain Structure

The academic model follows a hierarchical structure:

Program
 └── Program Module
       └── Program Phase
             └── Phase Session Template
                   └── Course Session (runtime instance)


This separation ensures:

Design-time academic configuration

Runtime session generation

Controlled academic progression

5. Core Functional Domains

The system is organized into the following domains:

Academic Configuration

Defines programs, modules, phases, and templates.

Enrollment

Manages student assignment to programs.

Session Management

Handles creation and scheduling of course sessions.

Attendance

Records student participation at session level.

Progression Engine

Evaluates advancement rules and determines phase transitions.

Administration

Controls user roles and system-wide management.

6. Key Design Principles

Clear separation between structure and runtime data

Explicit business rule modeling

Modular backend design

Scalable hierarchical progression

Database-driven academic logic

7. Future Scalability Considerations

The architecture allows:

Multi-program support

Multiple concurrent enrollments

Academic rule customization

Analytics layer integration

Financial module integration

API versioning

8. System Boundaries

The system does NOT:

Manage payments (future module)

Replace LMS content platforms

Handle academic certification validation (future extension)