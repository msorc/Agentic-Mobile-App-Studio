# Agentic Mobile App Studio -- Quick Start Guide

## What Is This?

This is a complete Claude Code agent architecture for Flutter cross-platform
app development. It organizes 24 specialized AI agents into a studio hierarchy
that mirrors real mobile app development teams, with defined responsibilities,
delegation rules, and coordination protocols. It includes platform-specialist
agents for iOS, Android, Web, and Desktop — each with dedicated sub-specialists
for major Flutter subsystems. All design agents and templates follow established
mobile app design patterns and Flutter best practices.

## How to Use

### 1. Understand the Hierarchy

There are three tiers of agents:

- **Tier 1 (Opus)**: Directors who make high-level decisions
  - `technical-lead` -- architecture and technology decisions
  - `product-designer` -- product vision and feature prioritization
  - `project-manager` -- scheduling, coordination, and risk management

- **Tier 2 (Sonnet)**: Department leads who own their domain
  - `flutter-specialist`, `ios-specialist`, `android-specialist`, `web-specialist`,
    `desktop-specialist`, `qa-lead`, `release-manager`, `localization-lead`

- **Tier 3 (Sonnet/Haiku)**: Specialists who execute within their domain
  - Designers, programmers, testers, engineers

### 2. Pick the Right Agent for the Job

Ask yourself: "What department would handle this in a real app studio?"

| I need to... | Use this agent |
|-------------|---------------|
| Design a new feature | `product-designer` |
| Write Flutter code | `feature-developer` |
| Design app architecture | `app-architecture-specialist` |
| Create UI screens | `ui-engineer` |
| Plan the next sprint | `project-manager` |
| Review code quality | `technical-lead` |
| Write test cases | `qa-tester` |
| Design user flows | `app-flow-designer` |
| Fix a performance problem | `performance-analyst` |
| Set up CI/CD | `devops-engineer` |
| Make an architecture decision | `technical-lead` |
| Manage a release | `release-manager` |
| Prepare strings for translation | `localization-lead` |
| Prototype a feature quickly | Use `/app-prototype` skill |
| Review code for security issues | `security-engineer` |
| Check accessibility compliance | `accessibility-specialist` |
| Get iOS-specific advice | `ios-specialist` |
| Get Android-specific advice | `android-specialist` |
| Get Web-specific advice | `web-specialist` |
| Get Desktop-specific advice | `desktop-specialist` |
| Choose state management | `state-management-specialist` |
| Design mobile UX patterns | `mobile-ux-specialist` |
| Brainstorm a new app idea | Use `/feature-brainstorm` skill |

### 3. Use Slash Commands for Common Tasks

| Command | What it does |
|---------|-------------|
| `/start` | First-time onboarding — asks where you are, guides you to the right workflow |
| `/design-review` | Reviews a design document |
| `/code-review` | Reviews code for quality and architecture |
| `/sprint-plan` | Creates or updates sprint plans |
| `/architecture-decision` | Creates an ADR |
| `/asset-audit` | Audits assets for compliance |
| `/milestone-review` | Reviews milestone progress |
| `/onboard` | Generates onboarding docs for a role |
| `/app-prototype` | Scaffolds a throwaway prototype |
| `/release-checklist` | Validates pre-release checklist |
| `/changelog` | Generates changelog from git history |
| `/retrospective` | Runs sprint/milestone retrospective |
| `/estimate` | Produces structured effort estimates |
| `/hotfix` | Emergency fix with audit trail |
| `/tech-debt` | Scan, track, and prioritize tech debt |
| `/scope-check` | Detect scope creep against plan |
| `/localize` | Localization scan, extract, validate |
| `/perf-profile` | Performance profiling and bottleneck ID |
| `/gate-check` | Validate phase readiness (PASS/CONCERNS/FAIL) |
| `/project-stage-detect` | Analyze project state, detect stage, identify gaps |
| `/reverse-document` | Generate design/architecture docs from existing code |
| `/map-systems` | Decompose concept into systems, map dependencies, guide per-system designs |
| `/design-system` | Guided, section-by-section PRD authoring for a single feature |
| `/team-ui` | Orchestrate full UI team pipeline |
| `/team-release` | Orchestrate full release team pipeline |
| `/team-polish` | Orchestrate full polish team pipeline |
| `/launch-checklist` | Complete launch readiness validation |
| `/patch-notes` | Generate user-facing update notes |
| `/feature-brainstorm` | Guided app concept ideation from scratch |
| `/app-testing` | Flutter testing guide and TDD workflows |
| `/flutter-ci-cd` | CI/CD pipeline setup for Flutter apps |
| `/mobile-ui-patterns` | Reference guide for Flutter widget patterns |
| `/platform-specific` | Platform-specific considerations for iOS, Android, Web, Desktop |
| `/state-management` | State management solution selection and implementation |

### 4. Use Templates for New Documents

Templates are in `.claude/docs/templates/`:

- `product-requirements-doc.md` -- for new features and requirements
- `feature-spec.md` -- for detailed feature specifications
- `architecture-decision-record.md` -- for technical decisions
- `risk-register-entry.md` -- for new risks
- `test-plan.md` -- for feature test plans
- `sprint-plan.md` -- for sprint planning
- `milestone-definition.md` -- for new milestones
- `app-architecture-doc.md` -- for app architecture documentation
- `post-mortem.md` -- for project/milestone retrospectives
- `release-checklist-template.md` -- for platform release checklists
- `changelog-template.md` -- for user-facing changelogs
- `release-notes.md` -- for user-facing release notes
- `incident-response.md` -- for live incident response playbooks
- `pitch-document.md` -- for pitching the app to stakeholders
- `systems-index.md` -- for systems decomposition and dependency mapping
- `project-stage-report.md` -- for project stage detection output
- `design-doc-from-implementation.md` -- for reverse-documenting existing code into specs
- `architecture-doc-from-code.md` -- for reverse-documenting code into architecture docs
- `concept-doc-from-prototype.md` -- for reverse-documenting prototypes into concept docs
- `technical-design-document.md` -- for per-feature technical designs
- `art-bible.md` -- for visual style reference
- `milestone-definition.md` -- for milestone definitions

### 5. Follow the Coordination Rules

1. Work flows down the hierarchy: Directors -> Leads -> Specialists
2. Conflicts escalate up the hierarchy
3. Cross-department work is coordinated by the `project-manager`
4. Agents do not modify files outside their domain without delegation
5. All decisions are documented

## First Steps for a New Project

**Don't know where to begin?** Run `/start`. It asks where you are and routes
you to the right workflow. No assumptions about your app, platform, or experience level.

If you already know what you need, jump directly to the relevant path:

### Path A: "I have no idea what to build"

1. **Run `/start`** (or `/feature-brainstorm open`) — guided creative exploration:
   what excites you, what apps you admire, your constraints
   - Generates 3 concepts, helps you pick one, defines core loop and pillars
   - Produces a product concept document and recommends a feature set
2. **Set up the project** — Run `/project-stage-detect`
   - Configures CLAUDE.md, detects knowledge gaps
   - Creates `.claude/docs/technical-preferences.md` with naming conventions
3. **Validate the concept** — Run `/design-review design/prd/product-concept.md`
4. **Decompose into systems** — Run `/map-systems` to map all systems and dependencies
5. **Design each system** — Run `/design-system [system-name]` (or `/map-systems next`)
   to write PRDs in dependency order
6. **Test the core loop** — Run `/app-prototype [core-feature]`
7. **Test it** — Run `/app-testing` to validate the implementation
8. **Plan the first sprint** — Run `/sprint-plan new`
9. Start building

### Path B: "I know what I want to build"

If you already have an app concept and feature set:

1. **Set up the project** — Run `/project-stage-detect`
   - Configures CLAUDE.md and creates technical preferences
2. **Write the Product Pillars** — delegate to `product-designer`
3. **Decompose into systems** — Run `/map-systems` to enumerate systems and dependencies
4. **Design each system** — Run `/design-system [system-name]` for PRDs in dependency order
5. **Create the initial ADR** — Run `/architecture-decision`
6. **Create the first milestone** in `production/milestones/`
7. **Plan the first sprint** — Run `/sprint-plan new`
8. Start building

### Path C: "I know the app but not the architecture"

If you have a concept but need help with architecture:

1. **Run `/architecture-decision`** — helps define your app architecture
2. **Choose state management** — delegate to `state-management-specialist`
3. Follow Path B from step 3 onward

### Path D: "I have an existing project"

If you have design docs, prototypes, or code already:

1. **Run `/start`** (or `/project-stage-detect`) — analyzes what exists,
   identifies gaps, and recommends next steps
2. **Validate phase readiness** — Run `/gate-check` to see where you stand
3. **Plan the next sprint** — Run `/sprint-plan new`

## File Structure Reference

```
CLAUDE.md                          -- Master config (read this first, ~60 lines)
.claude/
  settings.json                    -- Claude Code hooks and project settings
  agents/                          -- 24 agent definitions (YAML frontmatter)
  skills/                          -- 35 slash command definitions (YAML frontmatter)
  hooks/                           -- Hook scripts (.sh) wired by settings.json
  rules/                           -- Path-specific rule files
  docs/
    quick-start.md                 -- This file
    technical-preferences.md       -- Project-specific standards
    coding-standards.md            -- Coding and design doc standards
    coordination-rules.md          -- Agent coordination rules
    context-management.md          -- Context budgets and compaction instructions
    directory-structure.md         -- Project directory layout
    agent-roster.md                -- Full agent list with tiers
    skills-reference.md            -- All slash commands
    rules-reference.md             -- Path-specific rules
    hooks-reference.md             -- Active hooks
    agent-coordination-map.md      -- Full delegation and workflow map
    templates/                     -- Document templates
    collaborative-protocols/       -- Agent collaboration protocols
```
