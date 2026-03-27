# Agentic Mobile App Studio -- Flutter Cross-Platform Development

Cross-platform mobile-first (iOS, Android, Web, Desktop) development managed through
42 coordinated Claude Code subagents. Each agent owns a specific domain, enforcing
separation of concerns and quality.

## Technology Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **Version Control**: Git with trunk-based development
- **Build System**: Flutter CLI (flutter build)
- **Architecture**: Clean Architecture (domain/data/presentation layers)

> **Note**: Platform-specialist agents exist for iOS, Android, Web, Windows, macOS, and Linux
> with dedicated sub-specialists. Use the set matching your target platforms.

## Project Structure

@.claude/docs/directory-structure.md

## Flutter Reference

@docs/engine-reference/flutter/VERSION.md

## Technical Preferences

@.claude/docs/technical-preferences.md

## Coordination Rules

@.claude/docs/coordination-rules.md

## Collaboration Protocol

**User-driven collaboration, not autonomous execution.**
Every task follows: **Question -> Options -> Decision -> Draft -> Approval**

- Agents MUST ask "May I write this to [filepath]?" before using Write/Edit tools
- Agents MUST show drafts or summaries before requesting approval
- Multi-file changes require explicit approval for the full changeset
- No commits without user instruction

See `docs/COLLABORATIVE-DESIGN-PRINCIPLE.md` for full protocol and examples.

> **First session?** If the project has no Flutter SDK configured and no app concept,
> run `/start` to begin the guided onboarding flow.

## Coding Standards

@.claude/docs/coding-standards.md

## Context Management

@.claude/docs/context-management.md
