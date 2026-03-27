---
name: design-review
description: "Reviews a product requirements document or feature spec for completeness, internal consistency, implementability, and adherence to project design standards. Run this before handing a design document to developers."
argument-hint: "[path-to-design-doc]"
user-invocable: true
allowed-tools: Read, Glob, Grep
---

When this skill is invoked:

1. **Read the target design document** in full.

2. **Read the master CLAUDE.md** to understand project context and standards.

3. **Read related design documents** referenced or implied by the target doc
   (check `design/` for related features).

4. **Evaluate against the Design Document Standard checklist**:
   - [ ] Has Overview section (one-paragraph summary)
   - [ ] Has User Stories section (who, what, why)
   - [ ] Has Detailed Requirements section ( unambiguous specifications)
   - [ ] Has API Contracts section (if applicable, endpoints defined)
   - [ ] Has Edge Cases section (error states, offline handling)
   - [ ] Has Dependencies section (other features or services listed)
   - [ ] Has Acceptance Criteria section (testable success conditions)
   - [ ] Has Wireframes/Mockups section (UI references)
   - [ ] Has Platform Considerations section (iOS/Android/Web/Desktop specifics)

5. **Check for internal consistency**:
   - Do the requirements align with the stated user stories?
   - Do edge cases contradict the main requirements?
   - Are dependencies realistic (does the other feature team know about this)?

6. **Check for implementability**:
   - Are the requirements precise enough for a developer to implement without guessing?
   - Are there any vague sections where details are missing?
   - Are performance implications considered?

7. **Check for cross-feature consistency**:
   - Does this conflict with any existing feature?
   - Does this create unintended interactions with other systems?
   - Is this consistent with the app's established UX patterns?

8. **Output the review** in this format:

```
## Design Review: [Document Title]

### Completeness: [X/9 sections present]
[List missing sections]

### Consistency Issues
[List any internal or cross-feature contradictions]

### Implementability Concerns
[List any vague or unimplementable sections]

### Recommendations
[Prioritized list of improvements]

### Verdict: [APPROVED / NEEDS REVISION / MAJOR REVISION NEEDED]
```

9. **Contextual next step recommendations**:
   - If the document being reviewed is a new feature spec:
     - Check if `design/feature-index.md` exists
     - If it does NOT exist, add to Recommendations:
       > "This feature is ready for planning. Create a feature index to track
       > all features and their status."
   - If the document is an individual feature spec:
     - Check if the feature index references this feature
     - If verdict is APPROVED: suggest "Update the feature index status for
       this feature to 'Approved'."
     - If verdict is NEEDS REVISION or MAJOR REVISION NEEDED: suggest "Update
       the feature index status for this feature to 'In Review'."
   - Note: This skill is read-only. The user must perform the actual status
     update in the feature index.
