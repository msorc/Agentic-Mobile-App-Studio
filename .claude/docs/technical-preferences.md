# Technical Preferences

<!-- Populated during project setup. Updated as architectural decisions are made. -->
<!-- All agents reference this file for project-specific standards and conventions. -->

## Framework & Language

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: [SELECT: Riverpod / Bloc / Provider / Cubit — use /state-management skill to decide]
- **Architecture**: Clean Architecture (domain/data/presentation layers)

## Target Platforms

- [ ] iOS
- [ ] Android
- [ ] Web
- [ ] Windows
- [ ] macOS
- [ ] Linux

## Cloud Services (optional)

- [ ] Firebase (Auth, Firestore, Analytics, etc.)
- [ ] Supabase
- [ ] AWS Amplify
- [ ] GraphQL Backend
- [ ] REST API (custom backend)
- [ ] Local-only (no cloud)

## Naming Conventions

### Dart/Flutter

- **Classes**: `PascalCase` (e.g., `UserRepository`)
- **Files**: `snake_case` (e.g., `user_repository.dart`)
- **Variables**: `camelCase` (e.g., `userName`)
- **Constants**: `kCamelCase` for app constants (e.g., `kMaxLoginAttempts`)
- **Private members**: `_camelCase` (leading underscore)
- **Enums**: `PascalCase` values (e.g., `Status.active`)

### Widget Naming

- **Screen widgets**: `[Feature]Screen` (e.g., `LoginScreen`)
- **Reusable widgets**: `[Description]Widget` (e.g., `PrimaryButton`)
- **BLoC/Cubit**: `[Feature][State]` (e.g., `LoginBloc`, `LoginState`)

## Performance Budgets

- **Target FPS**: 60fps (desktop/mobile), 30fps minimum (web)
- **Widget Rebuild Budget**: < 16ms per frame
- **App Startup**: < 2 seconds cold start
- **Memory Ceiling**: < 200MB baseline (mobile)

## Testing Requirements

- **Framework**: flutter_test, integration_test
- **Minimum Coverage**: 80% for business logic (use cases, repositories)
- **Required Tests**: Widget tests for all screens, unit tests for use cases

## Forbidden Patterns

<!-- Add patterns that should never appear in this project's codebase -->
- [ ] `final list = List<int>()` — use `List<int>.empty()` or `[]` with type
- [ ] `dynamic` unless absolutely necessary — prefer `object` or specific types
- [ ] Hardcoded strings — use localization
- [ ] Business logic in widgets — delegate to BLoC/Cubit/Use Cases

## Allowed Packages

<!-- Add approved third-party dependencies here -->
<!-- Example: flutter_riverpod, go_router, dio, freezed, json_serializable -->

## Architecture Decisions Log

<!-- Quick reference linking to full ADRs in docs/architecture/ -->
- [No ADRs yet — use /architecture-decision to create one]
