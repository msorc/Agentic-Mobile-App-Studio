# Upgrading Agentic Mobile App Studio

This guide covers upgrading from the Game Studio template to the Flutter Mobile App Studio.

---

## Game Studio → Flutter App Studio

**Commit:** `1fed931554480692c2c3e297f271f528c79cdedd`

This was a complete conversion, not an incremental upgrade. The following changes were made:

### Agents

**Removed (game-specific):**
- `creative-director`, `technical-director`, `producer`
- `game-designer`, `systems-designer`, `level-designer`, `economy-designer`
- `narrative-director`, `writer`, `world-builder`
- `audio-director`, `sound-designer`
- `gameplay-programmer`, `engine-programmer`, `network-programmer`
- `art-director`, `technical-artist`
- `prototyper`, `live-ops-designer`
- All engine specialists: `godot-specialist`, `unity-specialist`, `unreal-specialist`, etc.

**Added (Flutter/mobile):**
- `flutter-specialist`, `ios-specialist`, `android-specialist`, `web-specialist`, `desktop-specialist`
- `app-architecture-specialist`, `feature-developer`, `state-management-specialist`
- `mobile-ux-specialist`, `app-flow-designer`

### Skills

**Removed:** `brainstorm`, `team-combat`, `team-narrative`, `team-audio`, `team-level`, `balance-check`, `playtest-report`, `setup-engine`

**Added:** `app-prototype`, `app-testing`, `flutter-ci-cd`, `mobile-ui-patterns`, `platform-specific`, `state-management`, `feature-brainstorm`

### Directories

| Old (Game) | New (App) |
|------------|-----------|
| `design/gdd/` | `design/features/` or `design/prd/` |
| `design/narrative/` | Removed |
| `design/levels/` | Removed |
| `src/gameplay/` | `lib/features/[name]/` |
| `src/ai/` | `lib/core/` or `lib/shared/` |
| `src/networking/` | `lib/shared/services/` |
| `docs/engine-reference/godot/` | `docs/engine-reference/flutter/` |
| `docs/engine-reference/unity/` | Removed |
| `docs/engine-reference/unreal/` | Removed |

### Rules

| Old | New |
|-----|-----|
| `gameplay-code.md` | `flutter-code.md` |
| `engine-code.md` | (merged into `flutter-code.md`) |
| `shader-code.md` | Removed |
| `narrative.md` | Removed |

### Templates

**Removed:** `game-design-document.md`, `game-pillars.md`, `level-design-document.md`, `narrative-character-sheet.md`, `sound-bible.md`, `faction-design.md`, `economy-model.md`

**Renamed/Updated:** `game-concept.md` → feature-focused templates

---

## After Switching

1. Delete old game-specific directories if present
2. Run `/project-stage-detect` to verify Flutter project detection
3. Update any custom agent configurations to use new agent names

---

*This file documents the initial conversion. Future updates will follow standard upgrade patterns.*
