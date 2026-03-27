---
name: reverse-document
description: "Generate design or architecture documents from existing implementation. Works backwards from code/prototypes to create missing planning docs."
argument-hint: "<type> <path> (e.g., 'design src/features/auth' or 'architecture src/core')"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
---

# Reverse Documentation

This skill analyzes existing implementation (code, prototypes, systems) and generates
appropriate design or architecture documentation. Use this when:
- You built a feature without writing a design doc first
- You inherited a codebase without documentation
- You prototyped a feature and need to formalize it
- You need to document "why" behind existing code

---

## Workflow

### 1. Parse Arguments

**Format**: `/reverse-document <type> <path>`

**Type options**:
- `design` → Generate a feature design document
- `architecture` → Generate an Architecture Decision Record (ADR)
- `concept` → Generate a concept document from prototype

**Path**: Directory or file to analyze
- `src/features/auth/` → All authentication-related code
- `src/core/event-system.dart` → Specific file
- `prototypes/offline-first/` → Prototype directory

**Examples**:
```bash
/reverse-document design src/features/notifications
/reverse-document architecture src/core/entity-component
/reverse-document concept prototypes/offline-first
```

### 2. Analyze Implementation

**Read and understand the code/prototype**:

**For design docs:**
- Identify features, rules, configuration
- Extract values (timeouts, limits, defaults)
- Find state machines, ability systems, data flows
- Detect edge cases handled in code
- Map dependencies (what systems interact?)

**For architecture docs (ADR):**
- Identify patterns (repository, singleton, observer, bloc, etc.)
- Understand technical decisions (threading, caching, serialization, etc.)
- Map dependencies and coupling
- Assess performance characteristics
- Find constraints and trade-offs

**For concept docs (prototype analysis):**
- Identify core feature
- Extract emergent patterns
- Note what worked vs what didn't
- Find technical feasibility insights
- Document intended user experience

### 3. Ask Clarifying Questions (Collaborative Protocol)

**DO NOT** just describe the code. **ASK** about intent:

**Design questions**:
- "I see a retry mechanism with exponential backoff. Was this for:
  - Reliability (network flakiness)?
  - Rate limiting compliance (API throttling)?
  - Or something else?"
- "The caching strategy seems aggressive. Is this for offline support, or performance?"
- "Data syncs on app resume. Intentional for battery saving, or needs to be real-time?"

**Architecture questions**:
- "You're using a service locator pattern. Was this chosen for:
  - Testability (mock dependencies)?
  - Decoupling (reduce hard references)?
  - Or inherited from existing code?"
- "I see manual memory management instead of proper disposal. Performance requirement, or legacy?"

**Concept questions**:
- "The prototype emphasizes offline-first. Is that the intended pillar?"
- "Users seem to work around the sync conflict resolution. Feature or bug?"

### 4. Present Findings

Before drafting, show what you discovered:

```
I've analyzed src/features/auth/. Here's what I found:

FEATURES IMPLEMENTED:
- Email/password login with validation
- Token refresh mechanism (15min access, 7d refresh)
- Account creation with email verification
- Password reset flow

CONFIG VALUES DISCOVERED:
- Max login attempts: 5 (then 15min lockout)
- Token refresh window: 7 days
- Session timeout: 30 min inactivity

UNCLEAR INTENT AREAS:
1. Retry mechanism — reliability or rate limiting?
2. Session timeout — battery concern or security?
3. Account linking — supported or future feature?

Before I draft the design doc, could you clarify these points?
```

Wait for user to clarify intent before drafting.

### 5. Draft Document Using Template

Based on type, use appropriate template:

| Type | Template | Output Path |
|------|----------|-------------|
| `design` | `templates/feature-spec.md` | `design/features/[feature-name].md` |
| `architecture` | `templates/architecture-doc-from-code.md` | `docs/architecture/[decision-name].md` |
| `concept` | `templates/concept-doc-from-prototype.md` | `prototypes/[name]/CONCEPT.md` or `design/concepts/[name].md` |

**Draft structure**:
- Capture **what exists** (features, patterns, implementation)
- Document **why it exists** (intent clarified with user)
- Identify **what's missing** (edge cases not handled, gaps in design)
- Flag **follow-up work** (tuning, missing features)

### 6. Show Draft and Request Approval

**Collaborative protocol**:
```
I've drafted the authentication feature spec based on your code and clarifications.

[Show key sections: Overview, Features, Configuration, Design Intent]

ADDITIONS I MADE:
- Documented retry as "reliability mechanism" per your clarification
- Added edge cases not in code (what if token refresh fails during offline?)
- Flagged security concern: session timeout may be too long for sensitive features

SECTIONS MARKED AS INCOMPLETE:
- "Social login integration" (not fully implemented yet)
- "MFA support" (architecture decided but not built)

May I write this to design/features/auth.md?
```

Wait for approval. User may request changes before writing.

### 7. Write Document with Metadata

When approved, write the file with special markers:

```markdown
---
status: reverse-documented
source: src/features/auth/
date: 2026-02-13
verified-by: [User name]
---

# Authentication System

> **Note**: This document was reverse-engineered from the existing implementation.
> It captures current behavior and clarified design intent. Some sections may be
> incomplete where implementation is partial or intent was unclear.

[Rest of document...]
```

### 8. Flag Follow-Up Work

After writing, suggest next steps:

```
✅ Written to design/features/auth.md

FOLLOW-UP RECOMMENDED:
1. Run `/design-review` on the auth spec
2. Create ADR for token storage security decision
3. Implement missing edge cases:
   - Token refresh failure during offline
   - Concurrent login handling
4. Extend design doc when social login is implemented

Would you like me to tackle any of these now?
```

---

## Template Selection Logic

| If analyzing... | Use template... | Because... |
|----------------|-----------------|------------|
| `src/features/*` | feature-spec.md | Feature specs → app design |
| `src/core/*`, `src/shared/*` | architecture-doc-from-code.md | Core systems → ADR |
| `prototypes/*` | concept-doc-from-prototype.md | Experiments → concept doc |
| `src/data/*` | architecture-doc-from-code.md | Data layer → ADR |
| `src/presentation/*` | feature-spec.md | UI/UX → feature spec |

---

## Example Session: Reverse-Document Auth Code

```
User: /reverse-document design src/features/auth

Agent: I'll analyze your authentication implementation to create a design doc.
       [Reads code, discovers features, configuration]

Agent: I've analyzed src/features/auth/. Here's what I found:
       [Shows features, config values, unclear areas]

       Before drafting, could you clarify:
       1. Retry mechanism intent?
       2. Session timeout — security or battery?
       3. Account linking — supported or future?

User: 1. Retry is for network reliability
       2. Security — we want shorter sessions for sensitive data
       3. Future feature, flag it

Agent: Perfect, that clarifies the vision. Let me draft the design doc.
       [Shows draft with clarified intent]

       May I write this to design/features/auth.md?

User: Yes, write it.

Agent: ✅ Written to design/features/auth.md
       ✅ Marked as [REVERSE-DOCUMENTED]
       ✅ Flagged session timeout for security review

       Next steps:
       - Review session timeout with security team
       - Run /design-review to validate the spec
       - Document account linking as future feature
```

---

## Collaborative Protocol

This skill follows the collaborative design principle:

1. **Analyze First**: Read code, understand implementation
2. **Question Intent**: Ask about "why", not just "what"
3. **Present Findings**: Show discoveries, highlight unclear areas
4. **User Clarifies**: Separate intent from accidents
5. **Draft Document**: Create doc based on reality + intent
6. **Show Draft**: Display key sections, explain additions
7. **Get Approval**: "May I write to [filepath]?"
8. **Flag Follow-Up**: Suggest related work, don't auto-execute

**Never assume intent. Always ask before documenting "why".**
