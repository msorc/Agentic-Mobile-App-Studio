# Agent Roster

The following agents are available. Each has a dedicated definition file in
`.claude/agents/`. Use the agent best suited to the task at hand. When a task
spans multiple domains, the coordinating agent (usually `project-manager` or the
domain lead) should delegate to specialists.

## Tier 1 -- Leadership Agents (Opus)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `product-owner` | High-level vision | Major product decisions, roadmap direction, stakeholder priorities |
| `technical-lead` | Technical vision | Architecture decisions, tech stack choices, performance strategy |
| `project-manager` | Production management | Sprint planning, milestone tracking, risk management, coordination |

## Tier 2 -- Department Lead Agents (Sonnet)
| Agent | Domain | When to Use |
|-------|--------|-------------|
| `product-designer` | Product design | Features, user flows, requirements, PRD creation |
| `app-architecture-specialist` | Code architecture | System design, code review, API design, Clean Architecture |
| `ux-design-lead` | UX direction | User experience strategy, design system, accessibility |
| `qa-lead` | Quality assurance | Test strategy, bug triage, release readiness, regression planning |
| `release-manager` | Release pipeline | Build management, versioning, changelogs, deployment, rollbacks |
| `devops-engineer` | Build/deploy | CI/CD, build scripts, version control workflow |

## Tier 3 -- Specialist Agents (Sonnet or Haiku)
| Agent | Domain | Model | When to Use |
|-------|--------|-------|-------------|
| `flutter-specialist` | Flutter core | Sonnet | Dart patterns, widget catalog, Flutter internals, performance |
| `ios-specialist` | iOS platform | Sonnet | Swift interop, iOS-specific widgets, App Store submission |
| `android-specialist` | Android platform | Sonnet | Kotlin interop, Material widgets, Play Store submission |
| `web-specialist` | Web platform | Sonnet | Web-specific widgets, PWA, web deployment |
| `desktop-specialist` | Desktop platforms | Sonnet | Windows/macOS/Linux native integration |
| `state-management-specialist` | State management | Sonnet | Riverpod/Bloc/Provider/Cubit selection and patterns |
| `platform-channel-specialist` | Native interop | Sonnet | Platform channels, method channels, native code integration |
| `mobile-ux-specialist` | UX implementation | Sonnet | User flows, wireframes, mobile patterns, accessibility |
| `feature-developer` | Feature implementation | Sonnet | Full-stack feature work within a feature module |
| `integration-specialist` | API/integration | Sonnet | REST/GraphQL/Firebase integration, data sync |
| `app-flow-designer` | App navigation | Sonnet | Navigation patterns, routing, deep linking |
| `ui-engineer` | UI implementation | Sonnet | Custom widgets, animations, responsive layouts |
| `performance-analyst` | Performance | Sonnet | Profiling, optimization, memory analysis, Flutter DevTools |
| `localization-lead` | Internationalization | Sonnet | l10n setup, arb files, locale testing |
| `security-engineer` | Security | Sonnet | Auth patterns, data encryption, secure storage |
| `qa-tester` | Test execution | Haiku | Writing test cases, bug reports, test checklists |
| `accessibility-specialist` | Accessibility | Haiku | WCAG compliance, screen reader support, text scaling |

## Platform-Specific Agents

### iOS Sub-Specialists
| Agent | Subsystem | Model | When to Use |
|-------|-----------|-------|-------------|
| `ios-widgets-specialist` | Cupertino widgets | Sonnet | iOS-native look and feel, CupertinoApp |
| `ios-signature-specialist` | Sign in with Apple | Sonnet | Apple authentication integration |

### Android Sub-Specialists
| Agent | Subsystem | Model | When to Use |
|-------|-----------|-------|-------------|
| `android-material-specialist` | Material Design | Sonnet | Material 3, Material widgets, theming |
| `android-play-specialist` | Play Store | Sonnet | Play Store submission, Android App Bundles |

### Web Sub-Specialists
| Agent | Subsystem | Model | When to Use |
|-------|-----------|-------|-------------|
| `web-pwa-specialist` | PWA | Sonnet | Service workers, manifest, offline support |
| `web-seo-specialist` | SEO | Sonnet | Meta tags, sematic HTML, search indexing |

### Desktop Sub-Specialists
| Agent | Subsystem | Model | When to Use |
|-------|-----------|-------|-------------|
| `desktop-linux-specialist` | Linux | Sonnet | Linux-specific builds, GTK integration |
| `desktop-windows-specialist` | Windows | Sonnet | Windows-specific builds, Win32 integration |
| `desktop-macos-specialist` | macOS | Sonnet | macOS-specific builds, macOS integration |

## Cross-Platform Specialists
| Agent | Domain | Model | When to Use |
|-------|--------|-------|-------------|
| `responsive-layout-specialist` | Responsive design | Sonnet | Adaptive layouts for multiple screen sizes |
| `offline-first-specialist` | Offline support | Sonnet | Local storage, sync strategies, optimistic updates |
| `testing-specialist` | Test automation | Sonnet | Widget tests, integration tests, Golden tests |
