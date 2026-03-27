---
paths:
  - "lib/core/**"
  - "lib/features/**/domain/**"
---

# Flutter Core Code Rules

- Clean Architecture: domain layer has NO external dependencies
- All external dependencies (packages, platform channels) accessed through interfaces
- Use dependency injection (Riverpod/Provider) for all dependencies
- Dart files: `snake_case.dart`, classes: `PascalCase`, variables: `camelCase`
- Private members: `_camelCase` (leading underscore)
- Constants: `kPascalCase` for app constants, `kCamelCase` for local constants
- Use `Either` from `dartz` for error handling in use cases (Left = failure, Right = success)
- Never use `dynamic` — prefer `Object?` or specific types
- Empty collections: use `[]` or `List.empty()` not `List<T>()`
- Use `late` only when initialization cannot be done in constructor
- All feature modules should be self-contained with their own data/domain/presentation
