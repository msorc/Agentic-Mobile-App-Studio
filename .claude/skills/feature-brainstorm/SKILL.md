---
name: feature-brainstorm
description: "Guided app concept ideation — from zero idea to a structured feature document. Uses professional frameworks for mobile/web app design."
argument-hint: "[optional: initial app hint or concept]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit
---

# Feature Brainstorm

Guided app concept ideation using professional mobile/web app design frameworks.
Takes the user from vague idea to a structured Product Requirements Document (PRD).

---

## When to Use

- Starting a new app from scratch
- Adding major features to an existing app
- Exploring alternative directions for an app concept

## Workflow

### 1. Clarify the Starting Point

If the user provided an initial hint (e.g., `/feature-brainstorm fitness tracking`),
validate and expand on it.

If no hint was provided, ask the user what kind of app they're thinking about:
- What's the primary purpose? (productivity, entertainment, utility, social, etc.)
- Who's the target user? (age range, tech savviness, specific needs)
- What problem does it solve? (existing pain point, new capability, etc.)

---

### 2. Explore App Type and Core Value Proposition

Based on the hint, help the user articulate:

1. **App Category**: Social, Productivity, Entertainment, E-commerce, Health & Fitness,
   Education, Finance, Utility, or Other
2. **Core Value Proposition**: One sentence describing the primary benefit
3. **Target Platforms**: iOS, Android, Web, Desktop (or subset)
4. **Monetization Model**: Free, freemium, subscription, one-time purchase, ads

---

### 3. Identify Key Features (MVP Scope)

Using the app category and value proposition, enumerate:

**Must-Have (P0)** - Core functionality without which the app has no value:
- Feature 1
- Feature 2
- Feature N

**Should-Have (P1)** - Important but not critical:
- Feature 1
- Feature 2

**Nice-to-Have (P2)** - Future iterations:
- Feature 1

---

### 4. Map User Flows

For the top 3 P0 features, sketch the primary user flow:

```
[Onboarding] → [Main Action] → [Value Delivered]
```

Identify:
- Entry point (deep link, notification, direct launch, etc.)
- Primary action sequence
- Success state (what does "done" look like?)
- Error/offline states

---

### 5. Platform Considerations

For each target platform, note:
- iOS: Cupertino vs Material, notch handling, safe areas, App Store guidelines
- Android: Material Design 3, back button behavior, Play Store requirements
- Web: Responsive breakpoints, PWA requirements, SEO considerations
- Desktop: Window management, keyboard shortcuts, native menus

---

### 6. Generate PRD Document

Create a PRD at `design/prd/[app-name]-prd.md`:

```markdown
# [App Name] - Product Requirements Document

## Overview
[One paragraph summary of the app]

## Target Platforms
- [ ] iOS
- [ ] Android
- [ ] Web
- [ ] Desktop

## User Personas
[Who uses this app]

## Core Value Proposition
[One sentence]

## MVP Features

### P0 - Must Have
| Feature | Description | User Story |
|---------|-------------|------------|
| | | |

### P1 - Should Have
| Feature | Description | User Story |
|---------|-------------|------------|
| | | |

### P2 - Nice to Have
| Feature | Description |
|---------|-------------|
| | | |

## User Flows

### [Feature Name]
```
[Flow description]
```

## Technical Considerations

### State Management
[To be decided with /state-management]

### Architecture
Clean Architecture with domain/data/presentation layers

### Dependencies
[To be identified]

## Success Metrics
- [Metric 1]
- [Metric 2]
```

---

## Output

- PRD document created at `design/prd/[app-name]-prd.md`
- Feature index updated (if exists)
- Recommended next steps: `/state-management`, `/sprint-plan`, `/design-review`
