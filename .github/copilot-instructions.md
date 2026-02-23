# Mysterybag Flutter App - Copilot Instructions

## Architecture Overview

This is a **Clean Architecture** Flutter app using **Cubit** state management. Every feature follows strict layer separation:

- **Domain** (`lib/features/[feature]/domains/`): Abstract `repos` and `entities` (business logic contracts). Repos return `Either<Failure, T>` from `dartz`.
- **Data** (`lib/features/[feature]/data/`): `models` (extends entities, handles JSON serialization) and concrete `repos` implementations. Map exceptions to failures.
- **Presentation** (`lib/features/[feature]/presentation/`): `views` (UI screens) and `manager/cubits/` (state management with Cubits).

**Core flow**: Services throw `CustomException` → Repositories catch and convert to `Left(Failure)` → Cubits emit states → UI responds.

## State Management with Cubits

Each Cubit follows this pattern:

```dart
class SignupCubit extends Cubit<SignupCubitState> {
  SignupCubit(this.authRepo) : super(SignupCubitInitial());
  final AuthRepo authRepo;

  Future<void> signup({required String email, required String password}) async {
    emit(SignupCubitLoading());
    final result = await authRepo.createUserWithEmailAndPassword(email, password, name);
    result.fold(
      (failure) => emit(SignupCubitError(failure.message)),
      (user) => emit(SignupCubitSuccess(user)),
    );
  }
}
```

**State naming**: `[FeatureName]CubitInitial`, `[FeatureName]CubitLoading`, `[FeatureName]CubitSuccess`, `[FeatureName]CubitError`. Use `BlocConsumer` to listen/build on state changes and call `showErrorBar(context, state.message)` for errors ([lib/core/helper_functions/build_error_bar.dart](lib/core/helper_functions/build_error_bar.dart)).

## Core Services & Dependency Injection

All services registered in [lib/core/services/get_it_service.dart](lib/core/services/get_it_service.dart):

- **FirebaseAuthServices**: Email/password, Google, Facebook auth
- **FirestoreServices** (implements `DatabaseServices`): Cloud Firestore CRUD
- **Prefs**: SharedPreferences singleton (`Prefs.setBool()`, `Prefs.getString()`, etc.)
- **AuthRepo**: Main auth repo (singleton)

Access via `getIt<ServiceType>()` - imported from `get_it_service.dart`.

## Error Handling: Exception → Failure → State

1. Services throw `CustomException(message: S.current.localizationKey)` ([lib/core/errors/exception.dart](lib/core/errors/exception.dart))
2. Repos catch and return `Left(Failure(message))` or `Right(data)` ([lib/core/errors/failures.dart](lib/core/errors/failures.dart))
3. Cubits use `.fold()` to emit error states
4. UI calls `showErrorBar()` in BlocConsumer's listener

Never throw exceptions from repos—always use Either.

## Localization & Constants

- **Strings**: `S.current.keyName` (ARB sources in `lib/l10n/`, auto-generated in `lib/generated/l10n.dart`)
- **Colors/Dimensions**: Define in [lib/constant.dart](lib/constant.dart) with `K` prefix (`KprimaryColor`, `KhorzontalPadding`)
- **Keys**: Use K-prefixed const for SharedPrefs keys (e.g., `KUserData`, `Klocale`)

## Feature Structure

```
features/[feature]/
├── data/
│   ├── models/          # Model extends Entity, JSON serialization
│   └── repos/           # ConcreteRepoImpl implements AbstractRepo
├── domains/
│   ├── entities/        # Pure data objects (no JSON logic)
│   └── repos/           # Abstract repo interfaces
└── presentation/
    ├── manager/cubits/  # Cubits (extends Cubit<State>)
    ├── views/           # Screens with static routeName
    └── widgets/         # Reusable components
```

Each feature must include: abstract repo + implementation, entity + model, Cubit + states.

## Routing Convention

1. Define `static const String routeName = '/routeName'` on each view
2. Route through [lib/core/helper_functions/on_generate_routes.dart](lib/core/helper_functions/on_generate_routes.dart)
3. Provide Cubits via `BlocProvider` (auto-provided by routing or manual)

## Build & Run Commands

```bash
flutter clean && flutter pub get
flutter gen-l10n                          # After editing lib/l10n/*.arb
flutter pub run build_runner build        # After adding JSON serialization
dart format lib/
flutter analyze
flutter run                               # Development build
flutter build apk --debug                 # Debug APK
```

## Key Dependencies

- **State**: `flutter_bloc` + `bloc` (Cubits for state)
- **DI**: `get_it` (service registration in `setupGetIt()`)
- **Errors**: `dartz` (Either<Failure, T>)
- **i18n**: `flutter_localization` + `intl` + ARB files
- **Firebase**: `firebase_auth`, `cloud_firestore`, `firebase_core`
- **Auth**: `google_sign_in`, `flutter_facebook_auth`
- **Storage**: `shared_preferences`

## Naming Conventions

- **Features**: Lowercase folders (`auth`, `home`, `splash`)
- **Entities/Models**: Singular PascalCase (`UserEntity`, `UserModel`)
- **Services**: Plural with "Services" suffix (`FirebaseAuthServices`)
- **Cubits**: `[Feature]Cubit` (e.g., `SignupCubit`)
- **Files**: Mixed case - screens use capitals with underscores (`Sign_in_view.dart`), helpers lowercase (`on_boarding.dart`)
- **Constants**: K-prefixed (`KprimaryColor`, `KUserData`)

## Important Files

- [lib/main.dart](lib/main.dart): Firebase init, Prefs init, GetIt setup, initial route to SplashView
- [lib/core/services/get_it_service.dart](lib/core/services/get_it_service.dart): Service registration
- [lib/constant.dart](lib/constant.dart): K-prefixed consts (colors, padding, keys)
- [lib/core/helper_functions/on_generate_routes.dart](lib/core/helper_functions/on_generate_routes.dart): Routing
- [lib/core/errors/exception.dart](lib/core/errors/exception.dart): CustomException
- [lib/core/errors/failures.dart](lib/core/errors/failures.dart): Failure classes

When adding features: Build repos + models + entities first, then Cubits, then UI. This ensures proper abstraction.
