---
name: app-testing
description: "Flutter testing guide covering widget tests, integration tests, and unit tests. Includes Golden testing, mocking, and test-driven development workflows."
argument-hint: "[test-type: widget|integration|unit|golden]"
user-invocable: true
allowed-tools: Read, Glob, Grep, Bash
---

# App Testing

Comprehensive testing guide for Flutter applications covering widget tests,
integration tests, unit tests, and Golden tests.

---

## Testing Pyramid

```
        ┌─────────────┐
        │ Integration │  (Full app, real environment)
        │    Tests    │
       ┌┴─────────────┴┐
       │   Widget Tests │  (Component testing, mocked dependencies)
      ┌┴───────────────┴┐
      │    Unit Tests   │  (Business logic, use cases, repositories)
      └─────────────────┘
```

---

## Unit Tests

### What to Test
- Use cases (domain layer)
- Repository implementations (data layer)
- Utility functions
- State management (BLoC/Cubit/Notifier logic)

### Structure
```dart
// test/unit/features/auth/login_usecase_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    test('should return user when login succeeds', () async {
      const email = 'test@example.com';
      const password = 'password';
      final user = User(id: '1', email: email);

      when(() => mockRepository.login(email, password))
          .thenAnswer((_) async => Right(user));

      final result = await useCase(const LoginParams(email, password));

      expect(result, Right(user));
      verify(() => mockRepository.login(email, password)).called(1);
    });

    test('should return failure when login fails', () async {
      const email = 'test@example.com';
      const password = 'wrong';

      when(() => mockRepository.login(email, password))
          .thenAnswer((_) async => const Left(AuthFailure.invalidCredentials()));

      final result = await useCase(const LoginParams(email, password));

      expect(result.isLeft(), true);
    });
  });
}
```

### Running Unit Tests
```bash
flutter test test/unit/
dart test test/unit/
```

---

## Widget Tests

### What to Test
- All screens (full screen widgets)
- Reusable custom widgets
- Form validation
- Navigation flows (mocked)

### Structure
```dart
// test/widget/features/auth/login_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginCubit extends Mock implements LoginCubit {}
class FakeLoginState extends Fake implements LoginState {}

void main() {
  late MockLoginCubit mockCubit;

  setUpAll(() {
    registerFallbackValue(FakeLoginState());
  });

  setUp(() {
    mockCubit = MockLoginCubit();
    when(() => mockCubit.state).thenReturn(const LoginState.initial());
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(const LoginState.initial()));
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Provider<LoginCubit>.value(
        value: mockCubit,
        child: const LoginScreen(),
      ),
    );
  }

  testWidgets('shows email and password fields', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('calls cubit.login when button pressed', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(() => mockCubit.login()).called(1);
  });
}
```

### Running Widget Tests
```bash
flutter test test/widget/
```

---

## Integration Tests

### What to Test
- Complete user flows (e.g., login → home → profile)
- Navigation between features
- Deep linking
- Platform-specific behavior (iOS/Android only)

### Structure
```dart
// test_integration/auth/login_flow_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow', () {
    testWidgets('complete login flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Enter credentials
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );

      // Tap login
      await tester.tap(find.byKey(const Key('login_button')));

      // Wait for navigation
      await tester.pumpAndSettle();

      // Verify we're on home screen
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
```

### Running Integration Tests
```bash
flutter test integration_test/
```

---

## Golden Tests

### What to Test
- Custom widget appearance
- Design system consistency
- Theme application

### Structure
```dart
// test/golden/my_button_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/shared/widgets/my_button.dart';

void main() {
  testWidgets('MyButton matches golden', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MyButton(label: 'Click Me'),
        ),
      ),
    );

    await expectLater(find.byType(MyButton), matchesGoldenFile('my_button.png'));
  });
}
```

### Running Golden Tests
```bash
flutter test --update-goldens
```

---

## Mocking

### Using mocktail
```dart
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements HttpClient {}
class MockSharedPreferences extends Mock implements SharedPreferences {}

// Register fallbacks
setUpAll(() {
  registerFallbackValue(Uri.parse('https://example.com'));
});

// Use in tests
when(() => mockClient.get(any())).thenAnswer((_) async => Response('{}', 200));
```

---

## Test Coverage

### Running with Coverage
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Coverage Requirements
- Domain layer: 90%+ coverage
- Data layer: 80%+ coverage
- Presentation layer: 60%+ coverage (widget tests)

---

## TDD Workflow

1. **Write a failing test** for the new behavior
2. **Run tests** to confirm failure
3. **Write minimal code** to make the test pass
4. **Refactor** while keeping tests green
5. **Repeat**

### Example
```dart
// 1. Write failing test
test('UserRepository returns User when getCurrentUser succeeds', () async {
  final repo = UserRepositoryImpl(mockDataSource);
  final result = await repo.getCurrentUser();
  expect(result, isA<User>());
});

// 2. Run test - FAILS (repo not implemented)

// 3. Write minimal implementation
class UserRepositoryImpl implements UserRepository {
  @override
  Future<User> getCurrentUser() async {
    return User(id: '1', name: 'Test');
  }
}

// 4. Test PASSES

// 5. Refactor if needed
```
