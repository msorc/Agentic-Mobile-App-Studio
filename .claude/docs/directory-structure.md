# Directory Structure

Flutter Clean Architecture project structure with separation of concerns.

```text
/
├── CLAUDE.md                    # Master configuration
├── .claude/                     # Agent definitions, skills, hooks, rules, docs
├── lib/                         # Dart source code
│   ├── core/                    # Shared utilities, constants, themes, extensions
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── extensions/
│   ├── features/                # Feature modules (vertical slice architecture)
│   │   └── [feature_name]/
│   │       ├── data/           # Repositories, data sources, models
│   │       ├── domain/         # Entities, use cases, repository interfaces
│   │       └── presentation/   # Widgets, screens, blocs/cubits
│   ├── shared/                  # Cross-feature shared widgets, utils, services
│   │   ├── widgets/
│   │   ├── services/
│   │   └── providers/
│   └── main.dart               # App entry point
├── assets/                      # Static assets
│   ├── images/
│   ├── fonts/
│   └── l10n/                    # Localization arb files
├── test/                        # Test suites
│   ├── widget/
│   ├── integration/
│   └── unit/
├── platform/                    # Platform-specific code
│   ├── ios/
│   ├── android/
│   ├── web/
│   ├── linux/
│   ├── macos/
│   └── windows/
├── docs/                        # Technical documentation
│   └── engine-reference/        # Flutter SDK reference (version-pinned)
├── design/                      # Design documents (prd, feature specs, ux)
├── production/                  # Production management (sprints, milestones, releases)
│   ├── session-state/           # Ephemeral session state (active.md — gitignored)
│   └── session-logs/            # Session audit trail (gitignored)
└── pubspec.yaml                 # Flutter dependencies
```

## Clean Architecture Layers

| Layer | Purpose | Dependencies |
|-------|---------|--------------|
| `presentation/` | UI widgets, screens, state management (BLoC/Cubit/Provider) | Depends on domain |
| `domain/` | Business entities, use cases, repository interfaces | No external dependencies |
| `data/` | Repository implementations, data sources, models | Depends on domain |

## Feature Module Structure

Each feature should be self-contained:

```
features/[feature_name]/
├── data/
│   ├── models/          # JSON-serializable models
│   ├── datasources/    # Local and remote data sources
│   └── repositories/    # Repository implementations
├── domain/
│   ├── entities/        # Business objects
│   ├── repositories/    # Abstract repository interfaces
│   └── usecases/       # Business logic
└── presentation/
    ├── screens/        # Full screens
    ├── widgets/        # Reusable UI components
    └── providers/      # State management
```
