---
paths:
  - "lib/**/presentation/**"
  - "lib/shared/widgets/**"
---

# Flutter UI Code Rules

- UI must NEVER own business logic — delegate to BLoC/Cubit/Provider
- All UI text must go through the localization system — no hardcoded user-facing strings
- Use `Theme.of(context)` for all colors and text styles — no hardcoded values
- All animations must respect user motion/accessibility preferences (`MediaQuery.disableAnimations`)
- UI must be responsive — test on multiple screen sizes and platforms
- Use `const` constructors wherever possible to optimize rebuilds
- Use `Semantics` widget for accessibility — all interactive elements must be labeled
- Handle loading, error, and empty states for all async operations
- Use `LayoutBuilder` for responsive layouts, not `MediaQuery.of(context).size`
