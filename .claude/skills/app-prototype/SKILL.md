---
name: app-prototype
description: "Rapid prototyping workflow for Flutter app features. Produces throwaway code and a structured prototype report."
argument-hint: "[path-to-feature-spec-or-description]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash
---

# App Prototype

Rapid prototyping workflow for Flutter app features. Produces throwaway code
that validates the approach before committing to production implementation.

---

## When to Use

- Testing a new Flutter pattern or package
- Validating UI/UX concepts quickly
- Checking technical feasibility of a complex feature
- Exploring alternative implementations

---

## Workflow

### 1. Understand the Prototype Goal

Read the feature spec or ask the user to describe:
- What needs to be validated? (UI pattern, state management, API integration, etc.)
- What does success look like? (working demo, benchmark numbers, etc.)
- What's the time budget? (hours, days)

---

### 2. Create Prototype Structure

Create a `prototypes/` directory if it doesn't exist, then scaffold:

```
prototypes/
└── [feature-name]-[date]/
    ├── lib/
    │   └── main.dart
    ├── pubspec.yaml
    └── README.md
```

---

### 3. Implement Minimal Viable Prototype

Focus on the specific thing being tested, not full feature implementation:

**UI Prototype**: Create the minimal widget tree showing the layout/interaction
- Use placeholder data
- No state management complexity
- Hardcoded navigation

**State Prototype**: Test the state management approach
- Minimal BLoC/Cubit/Provider setup
- Mock data source
- Verify state transitions work

**Integration Prototype**: Test API/data layer
- Minimal repository implementation
- Mock or test endpoint
- Verify error handling

---

### 4. Document Findings

Create `prototypes/[feature-name]-[date]/REPORT.md`:

```markdown
# Prototype Report: [Feature Name]

## Date
[YYYY-MM-DD]

## Goal
[What was being validated]

## Approach
[How it was implemented]

## Findings

### Successes
- [What worked well]

### Challenges
- [What was difficult]

### Performance
- [Benchmark numbers if applicable]

## Recommendation
[Proceed with production implementation / Iterate on approach / Abandon approach]

## Next Steps
[What to do next]
```

---

### 5. Cleanup Instruction

Warn the user:
> "This prototype is in `prototypes/` and should NOT be merged into production code.
> Once you've reviewed the findings, delete this directory or integrate lessons
> into the production feature module."

---

## Constraints

- Prototype code is throwaway — don't worry about code quality
- Focus only on what you're testing
- Set a time limit and stick to it
- Document findings immediately — details fade fast
