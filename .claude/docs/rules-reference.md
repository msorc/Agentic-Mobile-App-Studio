# Path-Specific Rules

Rules in `.claude/rules/` are automatically enforced when editing files in matching paths:

| Rule File | Path Pattern | Enforces |
| ---- | ---- | ---- |
| `flutter-code.md` | `lib/**` | Dart/Flutter standards, null safety, performance |
| `design-docs.md` | `design/**` | Required sections, formula format, edge cases |
| `ui-code.md` | `lib/**/presentation/**` | No app state ownership, localization-ready, accessibility |
| `data-files.md` | `assets/data/**` | JSON validity, naming conventions, schema rules |
| `test-standards.md` | `test/**` | Test naming, coverage requirements, fixture patterns |
| `prototype-code.md` | `prototypes/**` | Relaxed standards, README required, hypothesis documented |
| `network-code.md` | `lib/**/data/**` | API patterns, error handling, offline-first |
