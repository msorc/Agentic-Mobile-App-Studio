---
name: state-management
description: "Guides the selection and implementation of Flutter state management solutions. Compares Provider, Riverpod, Bloc, and Cubit with decision criteria."
argument-hint: "[no arguments - decision guide]"
user-invocable: true
allowed-tools: Read, Glob, Grep, AskUserQuestion
---

# State Management Guide

Guides the selection of Flutter state management solutions. Analyzes project
needs and recommends the most appropriate approach.

---

## Decision Framework

### 1. Assess Project Complexity

| Complexity | Characteristics | Recommended |
|------------|-----------------|-------------|
| Low | Few screens, simple state, single developer | Provider or Cubit |
| Medium | Multiple features, shared state, team | Riverpod or Bloc |
| High | Complex async, large team, test requirements | Riverpod or Bloc |

### 2. Evaluate Team Experience

| If team knows... | Consider |
|-----------------|----------|
| Nothing specific | Provider (easiest to learn) |
| Provider | Riverpod (natural upgrade) |
| React patterns | Bloc ( Redux-like) |
| Simple reactive | Cubit (simplified Bloc) |

---

## Comparison Matrix

| Criteria | Provider | Riverpod | Bloc | Cubit |
|----------|----------|----------|------|-------|
| Learning curve | Low | Medium | High | Medium |
| Boilerplate | Low | Low | High | Medium |
| Testability | Medium | High | High | High |
| Code generation | No | Optional | Optional | No |
| Async utilities | Manual | Built-in | Built-in | Manual |
| Provider overrides | No | Yes | N/A | N/A |
| Streams support | Yes | Yes | Yes | No |
| Recommended for | Simple apps | Complex apps | Large teams | Simple-medium |

---

## When to Use Each

### Provider
**Best for**: Simple apps, quick prototyping, small teams learning Flutter

```dart
ChangeNotifierProvider(
  create: (_) => CounterNotifier(),
  child: MyApp(),
)

// In widget
Consumer<CounterNotifier>(
  builder: (context, counter, _) => Text('${counter.count}'),
)
```

### Riverpod (Recommended for most cases)
**Best for**: Production apps, testable code, complex dependency graphs

```dart
final counterProvider = ChangeNotifierProvider((ref) => CounterNotifier());

// In widget
ref.watch(counterProvider)
```

### Bloc
**Best for**: Large teams, complex async workflows, strict architecture

```dart
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial()) {
    on<Increment>(_onIncrement);
  }
}

// Events
abstract class CounterEvent {}
class Increment extends CounterEvent {}

// State
abstract class CounterState {}
class CounterInitial extends CounterState {}
class CounterUpdated extends CounterState {
  final int count;
  CounterUpdated(this.count);
}
```

### Cubit
**Best for**: Simpler state, teams familiar with Bloc but want less boilerplate

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}
```

---

## Architecture Integration

### Clean Architecture with State Management

```
lib/
├── features/
│   └── [feature]/
│       ├── data/
│       │   └── repositories/
│       ├── domain/
│       │   └── usecases/
│       └── presentation/
│           ├── cubit/     # or bloc/, provider/
│           │   ├── feature_cubit.dart
│           │   └── feature_state.dart
│           └── widgets/
└── shared/
    └── providers/  # Cross-feature providers
```

### Provider in Clean Architecture
- Providers live in `presentation/providers/`
- Repositories injected into providers
- Use cases called from provider methods

### Riverpod in Clean Architecture
- Use `Provider` for repositories
- Use `ChangeNotifierProvider` or `NotifierProvider` for state
- Leverage `ref.read` for one-time reads, `ref.watch` for reactive

### Bloc in Clean Architecture
- BLoCs created per feature
- Events trigger use cases
- States represent UI states

---

## Migration Between Solutions

### Provider to Riverpod
```dart
// Before (Provider)
ChangeNotifierProvider(
  create: (_) => MyService(),
  child: Consumer<MyService>(
    builder: (_, service, __) => Text('${service.value}'),
  ),
)

// After (Riverpod)
final myServiceProvider = ChangeNotifierProvider((_) => MyService());

// In widget
final service = ref.watch(myServiceProvider);
```

### Cubit to Bloc
```dart
// Before (Cubit)
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> login() async {
    emit(AuthLoading());
    try {
      await api.login();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

// After (Bloc)
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
  }
}
```

---

## Testing Patterns

### Provider Test
```dart
test('counter increments', () {
  final notifier = CounterNotifier();
  notifier.increment();
  expect(notifier.count, 1);
});
```

### Riverpod Test
```dart
final container = ProviderContainer();
addTearDown(container.dispose);

test('counter increments', () {
  container.read(counterProvider.notifier).increment();
  expect(container.read(counterProvider).count, 1);
});
```

### Bloc Test
```dart
blocTest<CounterBloc, CounterState>(
  'emits [Loading, Success] when login succeeds',
  build: () => CounterBloc(),
  act: (bloc) => bloc.add(Increment()),
  expect: () => [CounterUpdated(1)],
);
```

---

## Recommendation Process

When asked to help choose:

1. Ask about team size and Flutter experience
2. Ask about project complexity and features
3. Ask about test requirements
4. Consider async operations complexity
5. Make a recommendation with rationale
6. Document the decision in `technical-preferences.md`
