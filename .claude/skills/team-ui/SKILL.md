---
name: team-ui
description: "Orchestrate the UI team: coordinates mobile-ux-specialist, ui-engineer, and art-director to design, implement, and polish a user interface feature from wireframe to final."
argument-hint: "[UI feature description]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, AskUserQuestion, TodoWrite
---
When this skill is invoked, orchestrate the UI team through a structured pipeline.

**Decision Points:** At each phase transition, use `AskUserQuestion` to present
the user with the subagent's proposals as selectable options. Write the agent's
full analysis in conversation, then capture the decision with concise labels.
The user must approve before moving to the next phase.

## Team Composition
- **mobile-ux-specialist** — User flows, wireframes, accessibility, input handling
- **ui-engineer** — UI framework, screens, widgets, data binding, implementation
- **art-director** — Visual style, layout polish, consistency with design system

## How to Delegate

Use the Task tool to spawn each team member as a subagent:
- `subagent_type: mobile-ux-specialist` — User flows, wireframes, accessibility, input handling
- `subagent_type: ui-engineer` — UI framework, screens, widgets, data binding
- `subagent_type: art-director` — Visual style, layout polish, design system consistency

Always provide full context in each agent's prompt (feature requirements, existing UI patterns, platform targets). Launch independent agents in parallel where the pipeline allows it (e.g., Phase 4 review agents can run simultaneously).

## Pipeline

### Phase 1: UX Design
Delegate to **mobile-ux-specialist**:
- Define the user flow for this feature (entry points, states, exit points)
- Create wireframes for each screen/state
- Specify interaction patterns: how does touch/keyboard/mouse navigate this?
- Define accessibility requirements: text sizes, contrast, screen reader support
- Identify data the UI needs to display
- Output: UX spec with wireframes and interaction map

### Phase 2: Visual Design
Delegate to **art-director**:
- Review wireframes against the design system
- Define visual treatment: colors, typography, spacing, animations
- Specify asset requirements (icons, backgrounds, decorative elements)
- Ensure consistency with existing UI screens
- Output: visual design spec with style notes

### Phase 3: Implementation
Delegate to **ui-engineer**:
- Implement the UI following the UX spec and visual design
- UI NEVER owns or modifies business state — display only, events for actions
- All text through localization system — no hardcoded strings
- Support multiple input methods (touch, keyboard, mouse)
- Implement accessibility features (text scaling, screen reader support)
- Wire up data binding to state management
- Output: implemented UI feature

### Phase 4: Review (parallel)
Delegate in parallel:
- **mobile-ux-specialist**: Verify implementation matches wireframes and interaction spec. Test keyboard-only and touch navigation. Check accessibility.
- **art-director**: Verify visual consistency with design system. Check at minimum and maximum supported resolutions.

### Phase 5: Polish
- Address review feedback
- Verify animations are skippable and respect motion preferences
- Test at all supported resolutions and aspect ratios
- Verify platform-specific behaviors (iOS gestures, Android back button, web scroll)

## Output
A summary report covering: UX spec status, visual design status, implementation status, accessibility compliance, input method support, and any outstanding issues.
