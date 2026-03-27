---
name: code-review
description: "Performs an architectural and quality code review on a specified file or set of files. Checks for coding standard compliance, architectural pattern adherence, SOLID principles, testability, and performance concerns."
argument-hint: "[path-to-file-or-directory]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash
---

When this skill is invoked:

1. **Read the target file(s)** in full.

2. **Read the CLAUDE.md** for project coding standards.

3. **Identify the feature category** (data, UI, networking, state management, utilities)
   and apply category-specific standards.

4. **Evaluate against coding standards**:
   - [ ] Public methods and classes have doc comments
   - [ ] Cyclomatic complexity under 10 per method
   - [ ] No method exceeds 40 lines (excluding data declarations)
   - [ ] Dependencies are injected (no static singletons for app state)
   - [ ] Configuration values loaded from data files
   - [ ] Features expose interfaces (not concrete class dependencies)

5. **Check architectural compliance**:
   - [ ] Correct dependency direction (domain <- data, domain <- presentation)
   - [ ] No circular dependencies between modules
   - [ ] Proper layer separation (UI does not own business state)
   - [ ] Events/signals used for cross-feature communication
   - [ ] Consistent with established patterns in the codebase

6. **Check SOLID compliance**:
   - [ ] Single Responsibility: Each class has one reason to change
   - [ ] Open/Closed: Extendable without modification
   - [ ] Liskov Substitution: Subtypes substitutable for base types
   - [ ] Interface Segregation: No fat interfaces
   - [ ] Dependency Inversion: Depends on abstractions, not concretions

7. **Check for common mobile development issues**:
   - [ ] Proper state disposal (no memory leaks in stateful widgets)
   - [ ] No allocations in hot paths (build/render loops)
   - [ ] Proper null/empty state handling
   - [ ] Thread safety where required
   - [ ] Resource cleanup (no leaks)

8. **Output the review** in this format:

```
## Code Review: [File/Feature Name]

### Standards Compliance: [X/6 passing]
[List failures with line references]

### Architecture: [CLEAN / MINOR ISSUES / VIOLATIONS FOUND]
[List specific architectural concerns]

### SOLID: [COMPLIANT / ISSUES FOUND]
[List specific violations]

### App-Specific Concerns
[List mobile/app development specific issues]

### Positive Observations
[What is done well -- always include this section]

### Required Changes
[Must-fix items before approval]

### Suggestions
[Nice-to-have improvements]

### Verdict: [APPROVED / APPROVED WITH SUGGESTIONS / CHANGES REQUIRED]
```
