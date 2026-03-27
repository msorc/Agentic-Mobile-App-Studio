---
name: design-system
description: "Guided, section-by-section feature spec authoring. Gathers context from existing docs, walks through each required section collaboratively, cross-references dependencies, and writes incrementally to file."
argument-hint: "<feature-name> (e.g., 'auth', 'notifications', 'offline-sync')"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Task, AskUserQuestion, TodoWrite
---

When this skill is invoked:

## 1. Parse Arguments & Validate

A feature name argument is **required**. If missing, fail with:
> "Usage: `/design-system <feature-name>` — e.g., `/design-system auth`
> Run `/map-systems` first to create the features index, then use this skill
> to write individual feature specs."

Normalize the feature name to kebab-case for the filename (e.g., "offline sync"
becomes `offline-sync`).

---

## 2. Gather Context (Read Phase)

Read all relevant context **before** asking the user anything. This is the skill's
primary advantage over ad-hoc design — it arrives informed.

### 2a: Required Reads

- **App concept**: Read `design/app-concept.md` — fail if missing:
  > "No app concept found. Run `/feature-brainstorm` first."
- **Features index**: Read `design/features/index.md` — fail if missing:
  > "No features index found. Run `/map-systems` first to map your features."
- **Target feature**: Find the feature in the index. If not listed, warn:
  > "[feature-name] is not in the features index. Would you like to add it, or
  > design it as an off-index feature?"

### 2b: Dependency Reads

From the features index, identify:
- **Upstream dependencies**: Features this one depends on. Read their specs if they
  exist (these contain decisions this feature must respect).
- **Downstream dependents**: Features that depend on this one. Read their specs if
  they exist (these contain expectations this feature must satisfy).

For each dependency spec that exists, extract and hold in context:
- Key interfaces (what data flows between the features)
- Configuration values that reference this feature's outputs
- Edge cases that assume this feature's behavior
- Tuning knobs that feed into this feature

### 2c: Optional Reads

- **App pillars**: Read `design/app-pillars.md` if it exists
- **Existing spec**: Read `design/features/[feature-name].md` if it exists (resume, don't
  restart from scratch)
- **Related specs**: Glob `design/features/*.md` and read any that are thematically related
  (e.g., if designing "offline-sync", also read "auth" even if it's not
  a direct dependency)

### 2d: Present Context Summary

Before starting design work, present a brief summary to the user:

> **Designing: [Feature Name]**
> - Priority: [from index] | Layer: [from index]
> - Depends on: [list, noting which have specs vs. undesigned]
> - Depended on by: [list, noting which have specs vs. undesigned]
> - Existing decisions to respect: [key constraints from dependency specs]
> - Pillar alignment: [which pillar(s) this feature primarily serves]

If any upstream dependencies are undesigned, warn:
> "[dependency] doesn't have a spec yet. We'll need to make assumptions about
> its interface. Consider designing it first, or we can define the expected
> contract and flag it as provisional."

Use `AskUserQuestion`:
- "Ready to start designing [feature-name]?"
  - Options: "Yes, let's go", "Show me more context first", "Design a dependency first"

---

## 3. Create File Skeleton

Once the user confirms, **immediately** create the feature spec file with empty section
headers. This ensures incremental writes have a target.

Use the template structure from `.claude/docs/templates/feature-spec.md`:

```markdown
# [Feature Name]

> **Status**: In Design
> **Author**: [user + agents]
> **Last Updated**: [today's date]
> **Serves Pillar**: [from context]

## Overview

[To be designed]

## User Experience

[To be designed]

## Detailed Design

### Core Behavior

[To be designed]

### States and Transitions

[To be designed]

### Interactions with Other Features

[To be designed]

## Configuration

[To be designed]

## Edge Cases

[To be designed]

## Dependencies

[To be designed]

## Platform Considerations

[To be designed]

## UI Requirements

[To be designed]

## Acceptance Criteria

[To be designed]

## Open Questions

[To be designed]
```

Ask: "May I create the skeleton file at `design/features/[feature-name].md`?"

After writing, update `production/session-state/active.md` with:
- Task: Designing [feature-name] spec
- Current section: Starting (skeleton created)
- File: design/features/[feature-name].md

---

## 4. Section-by-Section Design

Walk through each section in order. For **each section**, follow this cycle:

### The Section Cycle

```
Context  ->  Questions  ->  Options  ->  Decision  ->  Draft  ->  Approval  ->  Write
```

1. **Context**: State what this section needs to contain, and surface any relevant
   decisions from dependency specs that constrain it.

2. **Questions**: Ask clarifying questions specific to this section. Use
   `AskUserQuestion` for constrained questions, conversational text for open-ended
   exploration.

3. **Options**: Where the section involves design choices (not just documentation),
   present 2-4 approaches with pros/cons. Explain reasoning in conversation text,
   then use `AskUserQuestion` to capture the decision.

4. **Decision**: User picks an approach or provides custom direction.

5. **Draft**: Write the section content in conversation text for review. Flag any
   provisional assumptions about undesigned dependencies.

6. **Approval**: Ask "Approve this section, or would you like changes?"

7. **Write**: Use the Edit tool to replace the `[To be designed]` placeholder with
   the approved content. Confirm the write.

After writing each section, update `production/session-state/active.md` with the
completed section name.

### Section-Specific Guidance

Each section has unique design considerations and may benefit from specialist agents:

---

### Section A: Overview

**Goal**: One paragraph a stranger could read and understand.

**Questions to ask**:
- What is this feature in one sentence?
- How does a user interact with it? (active/passive/automatic)
- Why does this feature exist — what would the app lose without it?

**Cross-reference**: Check that the description aligns with how the features index
describes it. Flag discrepancies.

---

### Section B: User Experience

**Goal**: The user-centered target — what the user should *feel* and *accomplish*.

**Questions to ask**:
- What user need or pain point does this serve?
- What is the primary user journey through this feature?
- Is this "a feature users love engaging with" or "infrastructure they don't notice"?

**Cross-reference**: Must align with the app pillars. If the feature serves a pillar,
quote the relevant pillar text.

---

### Section C: Detailed Design (Core Behavior, States, Interactions)

**Goal**: Unambiguous specification a programmer could implement without questions.

This is usually the largest section. Break it into sub-sections:

1. **Core Behavior**: The fundamental logic. Use numbered rules for sequential
   processes, bullets for properties.
2. **States and Transitions**: If the feature has states, map every state and
   every valid transition. Use a table.
3. **Interactions with Other Features**: For each dependency (upstream and downstream),
   specify what data flows in, what flows out, and who owns the interface.

**Questions to ask**:
- Walk me through a typical use of this feature, step by step
- What are the key decisions the user makes?
- What can the user NOT do? (Constraints are as important as capabilities)

**Agent delegation**: For complex features, use the Task tool to delegate to
`feature-developer` for implementation review, or `state-management-specialist` for
state machine modeling. Provide the full context gathered in Phase 2.

**Cross-reference**: For each interaction listed, verify it matches what the
dependency spec specifies. If auth says "tokens expire after 15min" and
this feature expects longer sessions, flag the conflict.

---

### Section D: Configuration

**Goal**: Every configurable value, with safe ranges and extreme behaviors.

**Questions to ask**:
- What values should operators be able to tweak without code changes?
- For each knob, what breaks if it's set too high? Too low?
- Which knobs interact with each other? (Changing A makes B irrelevant)

**Agent delegation**: For configuration-heavy features, delegate to
`feature-developer` to identify which values should be runtime-configurable.

**Cross-reference**: If a dependency spec defines configuration that affects this
feature, reference it explicitly. Don't reinvent — connect.

---

### Section E: Edge Cases

**Goal**: Explicitly handle unusual situations so they don't become bugs.

**Questions to ask**:
- What happens at zero? At maximum? At negative values?
- What happens when two effects trigger simultaneously?
- What happens if the user tries to exploit this? (Identify edge cases)
- Network unavailable, slow, or intermittent?

**Agent delegation**: For features with complex interactions, delegate to
`feature-developer` to identify edge cases from the logic space.

**Cross-reference**: Check edge cases against dependency specs. If auth says
"tokens are invalidated on password change" but this feature caches tokens
indefinitely, that's a conflict to resolve.

---

### Section F: Dependencies

**Goal**: Map every feature connection with direction and nature.

This section is partially pre-filled from the context gathering phase. Present the
known dependencies from the features index and ask:
- Are there dependencies I'm missing?
- For each dependency, what's the specific data interface?
- Which dependencies are hard (feature cannot function without it) vs. soft
  (enhanced by it but works without it)?

**Cross-reference**: This section must be bidirectionally consistent. If this feature
lists "depends on Auth", then the Auth spec should list "depended on by [this
feature]". Flag any one-directional dependencies for correction.

---

### Section G: Platform Considerations

**Goal**: Note any platform-specific behavior, limitations, or requirements.

**Questions to ask**:
- Does this feature work differently on iOS vs Android vs Web?
- Are there platform-specific APIs or capabilities?
- What are the offline behavior expectations?
- Are there permission requirements (camera, location, notifications)?

**Cross-reference**: Consult platform-specific docs in `docs/engine-reference/flutter/`
for platform capabilities and limitations.

---

### Section H: UI Requirements

**Goal**: Specify what interfaces this feature exposes to the UI layer.

**Questions to ask**:
- What screens or widgets does this feature need?
- What data does the UI need to display?
- What user actions trigger feature behavior?
- How does offline state affect the UI?

**Agent delegation**: For complex UI, coordinate with `mobile-ux-specialist`
for user flows and interaction patterns.

---

### Section I: Acceptance Criteria

**Goal**: Testable conditions that prove the feature works as designed.

**Questions to ask**:
- What's the minimum set of tests that prove this works?
- What performance budget does this feature get? (load time, memory)
- What would a QA tester check first?

**Cross-reference**: Include criteria that verify cross-feature interactions work,
not just this feature in isolation.

---

### Optional Sections: Open Questions

This section is included in the template but isn't part of the required
sections. Offer it after the required sections are done:

Use `AskUserQuestion`:
- "The required sections are complete. Do you want to capture open questions now?"
  - Options: "Yes", "Skip — I'll add these later"

For **Open Questions**: Capture anything that came up during design that wasn't
fully resolved. Each question should have an owner and target resolution date.

---

## 5. Post-Design Validation

After all sections are written:

### 5a: Self-Check

Read back the complete spec from file (not from conversation memory — the file is
the source of truth). Verify:
- All required sections have real content (not placeholders)
- Configuration references defined variables
- Edge cases have resolutions
- Dependencies are listed with interfaces
- Acceptance criteria are testable

### 5b: Offer Design Review

Present a completion summary:

> **Spec Complete: [Feature Name]**
> - Sections written: [list]
> - Provisional assumptions: [list any assumptions about undesigned dependencies]
> - Cross-feature conflicts found: [list or "none"]

Use `AskUserQuestion`:
- "Run `/design-review` now to validate the spec?"
  - Options: "Yes, run review now", "I'll review it myself first", "Skip review"

If yes, invoke the design-review skill on the completed file.

### 5c: Update Features Index

After the spec is complete (and optionally reviewed):

- Read the features index
- Update the target feature's row:
  - If design-review was run and verdict is APPROVED: Status → "Approved"
  - If design-review was run and verdict is NEEDS REVISION: Status → "In Review"
  - If design-review was skipped: Status → "Designed" (pending review)
  - If the user chose "I'll review it myself first": Status → "Designed"
  - Design Doc: link to `design/features/[feature-name].md`
- Update the Progress Tracker counts

Ask: "May I update the features index at `design/features/index.md`?"

### 5d: Update Session State

Update `production/session-state/active.md` with:
- Task: [feature-name] spec
- Status: Complete (or In Review if design-review was run)
- File: design/features/[feature-name].md
- Sections: All written
- Next: [suggest next feature from design order]

### 5e: Suggest Next Steps

Use `AskUserQuestion`:
- "What's next?"
  - Options:
    - "Design next feature ([next-in-order])" — if undesigned features remain
    - "Fix review findings" — if design-review flagged issues
    - "Stop here for this session"
    - "Run `/gate-check`" — if enough MVP features are designed

---

## 6. Specialist Agent Routing

This skill delegates to specialist agents for domain expertise. The main session
orchestrates the overall flow; agents provide expert content.

| Feature Category | Primary Agent | Supporting Agent(s) |
|----------------|---------------|---------------------|
| Authentication, authorization | `feature-developer` | `security-engineer` (security review) |
| Data persistence, offline | `feature-developer` | `state-management-specialist` (state) |
| Notifications, messaging | `feature-developer` | `platform-specific` (push notifications) |
| Payments, subscriptions | `feature-developer` | `security-engineer` (PCI compliance) |
| Analytics, tracking | `analytics-engineer` | `feature-developer` (integration) |
| UI features (search, filters) | `mobile-ux-specialist` | `ui-engineer` (implementation) |
| Camera, media | `feature-developer` | `platform-specific` (iOS/Android APIs) |
| Location, maps | `feature-developer` | `platform-specific` (permissions) |

**When delegating via Task tool**:
- Provide: feature name, app concept summary, dependency spec excerpts, the specific
  section being worked on, and what question needs expert input
- The agent returns analysis/proposals to the main session
- The main session presents the agent's output to the user via `AskUserQuestion`
- The user decides; the main session writes to file
- Agents do NOT write to files directly — the main session owns all file writes

---

## 7. Recovery & Resume

If the session is interrupted (compaction, crash, new session):

1. Read `production/session-state/active.md` — it records the current feature and
   which sections are complete
2. Read `design/features/[feature-name].md` — sections with real content are done;
   sections with `[To be designed]` still need work
3. Resume from the next incomplete section — no need to re-discuss completed ones

This is why incremental writing matters: every approved section survives any
disruption.

---

## Collaborative Protocol

This skill follows the collaborative design principle at every step:

1. **Question -> Options -> Decision -> Draft -> Approval** for every section
2. **AskUserQuestion** at every decision point (Explain -> Capture pattern):
   - Phase 2: "Ready to start, or need more context?"
   - Phase 3: "May I create the skeleton?"
   - Phase 4 (each section): Design questions, approach options, draft approval
   - Phase 5: "Run design review? Update features index? What's next?"
3. **"May I write to [filepath]?"** before the skeleton and before each section write
4. **Incremental writing**: Each section is written to file immediately after approval
5. **Session state updates**: After every section write
6. **Cross-referencing**: Every section checks existing specs for conflicts
7. **Specialist routing**: Complex sections get expert agent input, presented to
   the user for decision — never written silently

**Never** auto-generate the full spec and present it as a fait accompli.
**Never** write a section without user approval.
**Never** contradict an existing approved spec without flagging the conflict.
**Always** show where decisions come from (dependency specs, pillars, user choices).
