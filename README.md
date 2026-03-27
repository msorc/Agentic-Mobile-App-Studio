<p align="center">
  <h1 align="center">Agentic Mobile App Studio</h1>
  <p align="center">
    Turn a single Claude Code session into a full cross-platform mobile app development studio.
    <br />
    24 agents. 35 skills. One coordinated AI team.
  </p>
</p>

> **Experimental** — This project is a fork of
> [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios)
> adapted for Flutter mobile app development. Created with MiniMax-M2.7 to test
> multi-agent coordination capabilities. Not yet tested in production.

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="MIT License"></a>
  <a href=".claude/agents"><img src="https://img.shields.io/badge/agents-24-blueviolet" alt="24 Agents"></a>
    <a href=".claude/skills"><img src="https://img.shields.io/badge/skills-35-green" alt="35 Skills"></a>
  <a href=".claude/hooks"><img src="https://img.shields.io/badge/hooks-8-orange" alt="8 Hooks"></a>
  <a href=".claude/rules"><img src="https://img.shields.io/badge/rules-8-red" alt="8 Rules"></a>
  <a href="https://docs.anthropic.com/en/docs/claude-code"><img src="https://img.shields.io/badge/built%20for-Claude%20Code-f5f5f5?logo=anthropic" alt="Built for Claude Code"></a>
</p>

---

## Why This Exists

Building a cross-platform mobile app solo with AI is powerful — but a single chat session has no structure. No one stops you from hardcoding API keys, skipping design specs, or writing tightly coupled code. There's no architecture review, no accessibility audit, no one asking "does this actually scale to all five platforms?"

**Agentic Mobile App Studio** solves this by giving your AI session the structure of a professional mobile dev team. Instead of one general-purpose assistant, you get 24 specialized agents organized into a studio hierarchy — leads who own their domains and specialists who do the hands-on work. Each agent has defined responsibilities, escalation paths, and quality gates.

The result: you still make every decision, but now you have a team that asks the right questions, catches mistakes early, and keeps your project organized from first feature brainstorm to multi-platform release.

---

## Table of Contents

- [What's Included](#whats-included)
- [Studio Hierarchy](#studio-hierarchy)
- [Slash Commands](#slash-commands)
- [Getting Started](#getting-started)
- [Upgrading](#upgrading)
- [Project Structure](#project-structure)
- [How It Works](#how-it-works)
- [Design Philosophy](#design-philosophy)
- [Customization](#customization)
- [Platform Support](#platform-support)
- [Community](#community)
- [License](#license)

---

## What's Included

| Category | Count | Description |
|----------|-------|-------------|
| **Agents** | 24 | Specialized subagents across Flutter, iOS, Android, Web, Desktop, design, QA, and production |
| **Skills** | 35 | Slash commands for common workflows (`/start`, `/sprint-plan`, `/code-review`, `/feature-brainstorm`, etc.) |
| **Hooks** | 8 | Automated validation on commits, pushes, file changes, session lifecycle, agent audit, and gap detection |
| **Rules** | 8 | Path-scoped coding standards for Flutter/Dart, UI code, and network code |
| **Templates** | 21 | Document templates for PRDs, feature specs, architecture docs, sprint plans, and milestones |

## Studio Hierarchy

Agents are organized into three tiers:

```
Tier 1 — Leadership (Opus)
  technical-lead    project-manager    product-designer

Tier 2 — Platform & Domain Leads (Sonnet)
  flutter-specialist     ios-specialist       android-specialist
  web-specialist         desktop-specialist   state-management-specialist
  mobile-ux-specialist   ui-engineer          app-architecture-specialist
  qa-lead                release-manager

Tier 3 — Specialists (Sonnet/Haiku)
  feature-developer       app-flow-designer    performance-analyst
  integration-specialist security-engineer    accessibility-specialist
  localization-lead      qa-tester            devops-engineer
  analytics-engineer
```

### Platform Specialists

The template includes platform-specific agents for all five target platforms:

| Platform | Lead Agent | Sub-Specialists |
|----------|-----------|-----------------|
| **Flutter** | `flutter-specialist` | State management, widgets, plugins, performance |
| **iOS** | `ios-specialist` | Swift/Objective-C, CocoaPods, SwiftUI, Xcode |
| **Android** | `android-specialist` | Kotlin/Java, Gradle, Jetpack Compose, Play Services |
| **Web** | `web-specialist` | Progressive Web Apps, responsive design, PWA APIs |
| **Desktop** | `desktop-specialist` | Windows/macOS/Linux desktop patterns |

## Slash Commands

Type `/` in Claude Code to access all 35 skills:

**Reviews & Analysis**
`/design-review` `/code-review` `/asset-audit` `/scope-check` `/perf-profile` `/tech-debt`

**Production**
`/sprint-plan` `/milestone-review` `/estimate` `/retrospective` `/bug-report`

**Project Management**
`/start` `/project-stage-detect` `/reverse-document` `/gate-check` `/map-systems` `/design-system`

**Release**
`/release-checklist` `/launch-checklist` `/changelog` `/patch-notes` `/hotfix`

**Creative**
`/app-prototype` `/onboard` `/localize`

**Team Orchestration** (coordinate multiple agents on a single feature)
`/team-ui` `/team-release` `/team-polish`

## Getting Started

### Prerequisites

- [Git](https://git-scm.com/)
- [Flutter SDK](https://flutter.dev/) (3.x)
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) (`npm install -g @anthropic-ai/claude-code`)
- **Recommended**: [jq](https://jqlang.github.io/jq/) (for hook validation) and Python 3 (for JSON validation)

All hooks fail gracefully if optional tools are missing — nothing breaks, you just lose validation.

### Setup

1. **Clone or use as template**:
   ```bash
   git clone https://github.com/your-org/Agentic-Mobile-App-Studio.git my-app
   cd my-app
   ```

2. **Open Claude Code** and start a session:
   ```bash
   claude
   ```

3. **Run `/start`** — the system asks where you are (no idea, vague concept,
   clear design, existing work) and guides you to the right workflow. No assumptions.

   Or jump directly to a specific skill if you already know what you need:
   - `/feature-brainstorm` — explore app features from scratch
   - `/project-stage-detect` — analyze an existing Flutter project
   - `/sprint-plan new` — plan your first sprint

## Upgrading

Already using an older version of this template? See [UPGRADING.md](UPGRADING.md)
for step-by-step migration instructions, a breakdown of what changed between
versions, and which files are safe to overwrite vs. which need a manual merge.

## Project Structure

```
CLAUDE.md                           # Master configuration
.claude/
  settings.json                     # Hooks, permissions, safety rules
  agents/                           # 24 agent definitions (markdown + YAML frontmatter)
  skills/                           # 35 slash commands (subdirectory per skill)
  hooks/                            # 8 hook scripts (bash, cross-platform)
  rules/                            # 8 path-scoped coding standards
  docs/
    agent-roster.md                 # Full agent table with domains
    agent-coordination-map.md       # Delegation and escalation paths
    directory-structure.md          # Flutter Clean Architecture structure
    technical-preferences.md        # Platform naming conventions and budgets
    templates/                      # 5 document templates
lib/                                # App source code (Flutter/Dart)
lib/
  core/                             # Shared utilities, constants, extensions
  features/                         # Feature modules (Clean Architecture)
  shared/                           # Shared widgets, widgets, services
test/                               # Test suites
integration_test/                   # Integration tests
docs/                               # Technical documentation and ADRs
  engine-reference/                 # Platform reference docs
production/                        # Sprint plans, milestones, releases
```

## How It Works

### Agent Coordination

Agents follow a structured delegation model:

1. **Vertical delegation** — leads delegate to specialists
2. **Horizontal consultation** — same-tier agents can consult each other but can't make binding cross-domain decisions
3. **Conflict resolution** — disagreements escalate up to the shared parent (`technical-lead` for technical, `project-manager` for production)
4. **Change propagation** — cross-domain changes are coordinated by `project-manager`
5. **Domain boundaries** — agents don't modify files outside their domain without explicit delegation

### Collaborative, Not Autonomous

This is **not** an auto-pilot system. Every agent follows a strict collaboration protocol:

1. **Ask** — agents ask questions before proposing solutions
2. **Present options** — agents show 2-4 options with pros/cons
3. **You decide** — the user always makes the call
4. **Draft** — agents show work before finalizing
5. **Approve** — nothing gets written without your sign-off

You stay in control. The agents provide structure and expertise, not autonomy.

### Automated Safety

**Hooks** run automatically on every session:

| Hook | Trigger | What It Does |
|------|---------|--------------|
| `validate-commit.sh` | `git commit` | Checks for hardcoded secrets, TODO format, JSON validity, doc references |
| `validate-push.sh` | `git push` | Warns on pushes to protected branches |
| `session-start.sh` | Session open | Loads sprint context and recent git activity |
| `detect-gaps.sh` | Session open | Detects fresh projects (suggests `/start`) and missing documentation |
| `pre-compact.sh` | Context compression | Preserves session progress notes |
| `session-stop.sh` | Session close | Logs accomplishments |
| `log-agent.sh` | Agent spawned | Audit trail of all subagent invocations |

**Permission rules** in `settings.json` auto-allow safe operations (git status, test runs) and block dangerous ones (force push, `rm -rf`, reading `.env` files).

### Path-Scoped Rules

Coding standards are automatically enforced based on file location:

| Path | Enforces |
|------|----------|
| `lib/core/**` | Zero allocations in hot paths, thread safety, API stability |
| `lib/features/**` | Clean Architecture layers, dependency injection, testability |
| `lib/shared/**` | Reusability, no feature dependencies, accessibility |
| `test/**` | Test naming, coverage requirements, fixture patterns |
| `integration_test/**` | Integration test patterns, app lifecycle testing |

## Design Philosophy

This template is grounded in professional mobile development practices:

- **Clean Architecture** — Separation of domain, data, and presentation layers
- **Platform Conventions** — Native patterns for each target platform (iOS HIG, Material Design, Web APIs)
- **Progressive Enhancement** — Core functionality first, platform-specific polish on top
- **Accessibility-First** — WCAG compliance built into every UI decision

## Customization

This is a **template**, not a locked framework. Everything is meant to be customized:

- **Add/remove agents** — delete agent files you don't need, add new ones for your domains
- **Edit agent prompts** — tune agent behavior, add project-specific knowledge
- **Modify skills** — adjust workflows to match your team's process
- **Add rules** — create new path-scoped rules for your project's directory structure
- **Tune hooks** — adjust validation strictness, add new checks
- **Pick your state management** — use Riverpod, Bloc, Provider, or Cubit as fits your app

## Platform Support

Target platforms: **iOS**, **Android**, **Web**, **Windows**, **macOS**, **Linux**.

All hooks use POSIX-compatible patterns (`grep -E`, not `grep -P`) and include fallbacks for missing tools.

---

> **Note**: This is an experimental project. The agent architecture, skills, and
> coordination system are in early testing. Use at your own discretion.

## License

MIT License. See [LICENSE](LICENSE) for details.
