# CLAUDE.md — Flutter Project

## Commands

```bash
# Development
flutter run                          # Run on connected device / emulator
flutter run -d chrome                # Run on Chrome (web)
flutter run --flavor development     # Run with a specific flavor
flutter pub get                      # Install dependencies
flutter pub upgrade                  # Upgrade dependencies

# Code quality (run before every commit)
flutter analyze                      # Static analysis
dart format . --line-length 120      # Format all Dart files
flutter test                         # Run all unit + widget tests
flutter test --coverage              # Run tests with coverage report

# Build
flutter build apk --flavor production --release
flutter build ios --flavor production --release
flutter build web --release

# Code generation (run after modifying models, routes, or providers)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs  # Watch mode

# Localization
flutter gen-l10n                     # Regenerate ARB / l10n files
```

---

## Project Structure

```
lib/
├── main.dart                        # Entry point — minimal, only bootstraps app
├── app/
│   ├── app.dart                     # MaterialApp / root widget
│   ├── router/
│   │   └── app_router.dart          # go_router configuration
│   └── theme/
│       ├── app_theme.dart
│       └── app_colors.dart
├── core/
│   ├── constants/                   # App-wide constants
│   ├── extensions/                  # Dart extension methods
│   ├── utils/                       # Pure helper functions (no Flutter deps)
│   ├── errors/                      # Failure / AppException classes
│   └── network/                     # Dio client, interceptors, base URLs
├── features/
│   └── <feature_name>/              # One folder per feature
│       ├── data/
│       │   ├── datasources/         # Remote & local data sources
│       │   ├── models/              # JSON-serializable DTOs (Freezed)
│       │   └── repositories/        # Repository implementations
│       ├── domain/
│       │   ├── entities/            # Pure Dart business objects
│       │   ├── repositories/        # Abstract repository interfaces
│       │   └── usecases/            # Single-responsibility use case classes
│       └── presentation/
│           ├── providers/           # Riverpod providers / notifiers
│           ├── pages/               # Full-screen route pages
│           └── widgets/             # Feature-scoped widgets
└── shared/
    ├── providers/                   # Global / cross-feature providers
    └── widgets/                     # Reusable UI components
```

**Key rule:** Dependencies only flow inward — `presentation → domain ← data`. Never import `presentation` from `data` or `domain`.

---

## Tech Stack

| Concern              | Package                            |
|----------------------|------------------------------------|
| State management     | `riverpod` + `flutter_riverpod`    |
| Code generation      | `riverpod_generator` + `freezed`   |
| Routing              | `go_router`                        |
| Networking           | `dio`                              |
| Local storage        | `hive_flutter` or `shared_preferences` |
| JSON serialization   | `freezed` + `json_serializable`    |
| Dependency injection | Riverpod providers (no get_it)     |
| Testing              | `flutter_test` + `mocktail`        |
| Linting              | `flutter_lints` + custom rules     |
| Localization         | `flutter_localizations` + ARB      |

---

## Architecture — Clean Architecture + Feature-First

- **Entities** — plain Dart classes, no Flutter, no JSON annotations.
- **Use Cases** — one public `call()` method, one responsibility. Accept repository interfaces.
- **Repositories** — interfaces defined in `domain/`, implemented in `data/`.
- **Providers** — `@riverpod` annotated notifiers in `presentation/providers/`. Never put business logic here; call use cases instead.
- **Pages / Widgets** — consume providers via `ref.watch` / `ref.read`. No direct repository or use case imports.

```dart
// ✅ Correct provider pattern
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<User> build(String userId) =>
      ref.read(getUserUseCaseProvider).call(userId);
}

// ❌ Wrong — business logic in provider
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  FutureOr<User> build(String userId) =>
      ref.read(userRepositoryProvider).fetchUser(userId); // skip use case
}
```

---

## Code Style

- **Line length:** 120 characters (`dart format --line-length 120`).
- **Naming:**
  - Files and directories: `snake_case`
  - Classes: `PascalCase`
  - Variables, methods, parameters: `camelCase`
  - Constants: `camelCase` (never `SCREAMING_SNAKE_CASE`)
  - Private members: `_camelCase`
- **Imports order** (enforced by `dart format`):
  1. `dart:` SDK
  2. `package:flutter/`
  3. Third-party packages
  4. Project-relative imports (`package:<app>/...`)
- **`const` everywhere** possible — constructors, literals, widgets.
- **`late` is banned** unless absolutely unavoidable; prefer nullable + null-check or lazy initialization.
- **No `dynamic`** — always type explicitly.
- **Avoid `BuildContext` across async gaps** — store before `await`, check `mounted` after.

```dart
// ✅ Correct async context usage
Future<void> _submit() async {
  final messenger = ScaffoldMessenger.of(context);
  await someAsyncCall();
  if (!mounted) return;
  messenger.showSnackBar(...);
}
```

---

## Models — Freezed

All DTOs and entities use `@freezed`. Run `build_runner` after any model change.

```dart
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    String? displayName,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

---

## Error Handling

- Domain errors are represented as `sealed class Failure` subtypes (e.g., `NetworkFailure`, `CacheFailure`, `AuthFailure`).
- Repository methods return `Either<Failure, T>` (via `fpdart`) or throw typed `AppException` — pick one strategy per project and be consistent.
- **Never** swallow exceptions silently. Always log + surface to UI.
- Use `AsyncValue` in Riverpod providers — handle `.loading`, `.data`, and `.error` states in the UI.

---

## Routing — go_router

- All routes declared in `lib/app/router/app_router.dart`.
- Use `GoRoute` with typed `extra` or `queryParams`; never pass raw `Object?` without a cast guard.
- Redirect logic (auth guards) lives in the router's `redirect` callback, not in individual pages.
- Named routes are mandatory — navigate via `context.goNamed(...)`, never hardcoded paths.

---

## State Management Rules

- `ref.read` → inside callbacks / event handlers (fire-and-forget).
- `ref.watch` → inside `build()` or provider `build()` (reactive).
- `ref.listen` → for side-effects triggered by state changes (navigation, snackbars).
- Keep providers **granular** — one provider per distinct piece of state.
- Avoid `.autoDispose` only when state must survive widget unmount (e.g., a cart); use it everywhere else.

---

## Git Workflow

- Branch naming: `feat/<ticket-id>-short-description`, `fix/...`, `chore/...`
- Commit format: `feat(auth): add biometric login support` (Conventional Commits)
- Never commit generated files (`.g.dart`, `.freezed.dart`) — they are in `.gitignore`.
- Run `flutter analyze && flutter test` before every push.
- PRs require at least one approval; squash-merge into `main`.

---

## Environment & Flavors

```
flavors: development | staging | production
```

- Config per flavor lives in `lib/core/constants/env_config.dart`.
- Secrets are injected via `--dart-define` at build time — never hardcoded.
- `flutter_dotenv` is **not** used; use `--dart-define-from-file=.env.json` instead.

---

## Do Not

- Do **not** use `setState` outside of simple, local-only ephemeral UI state (e.g., a toggle inside a single widget with no external effects). Use Riverpod for everything else.
- Do **not** add logic to `main.dart` beyond `runApp`.
- Do **not** use `MediaQuery` directly in widgets — use the responsive utility wrappers in `core/extensions/`.
- Do **not** import feature A's internals into feature B — go through shared providers or use cases only.
- Do **not** run `pub upgrade` without team approval — lock `pubspec.lock` in version control.