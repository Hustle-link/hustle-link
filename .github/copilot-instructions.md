# Hustle Link - AI Coding Agent Instructions

## Project Overview
Hustle Link is a **Botswana-focused job marketplace** Flutter app connecting "hustlers" (freelancers/job seekers) with employers. Uses **dual-role architecture** where users select Hustler or Employer roles with separate UI flows and data models.

## Architecture Patterns

### State Management: Riverpod Ecosystem
- **Core**: `hooks_riverpod` + `riverpod_annotation` for code generation
- **Pattern**: Use `@riverpod` annotations for providers, generates `.g.dart` files
- **Services**: Wrap Firebase services in Riverpod providers (see `firebase_auth.dart`)
- **State**: Use `Notifier`/`AsyncNotifier` for complex state, `Provider` for simple values
- **Mutations**: `riverpod_community_mutation` for async operations with loading states

### Data Layer: Firebase + Freezed Models
- **Models**: All in `lib/src/models/` use `@freezed` with JSON serialization
- **Pattern**: `AppUser` -> `Hustler`/`Employer` inheritance for role-specific data
- **Firebase**: Services in `lib/src/shared/services/` wrap Firebase Auth/Firestore/Storage
- **JSON**: Use `explicit_to_json: true` for Firebase compatibility (see `build.yaml`)

### Navigation: GoRouter with Role-Based Shells
- **Router**: `lib/src/shared/routing/app_router.dart` - complex redirect logic based on auth + role
- **Flow**: Language Selection → Welcome → Auth → Role Selection → Role-Specific Shell
- **Shells**: `HustlerShell`/`EmployerShell` provide different bottom navigation and theme colors
- **Theme Swapping**: Employer shell swaps primary/secondary colors for visual distinction

### UI Architecture
- **Responsive**: `sizer` package for screen-adaptive layouts (`10.w`, `30.h`)
- **Theme**: Material 3 with custom `AppColors` class, Google Fonts (Lato)
- **Animations**: `flutter_animate` for entrance effects, see `WelcomePage` patterns
- **Dialogs**: `flutter_smart_dialog` instead of native dialogs

## Key Developer Workflows

### Code Generation (Required for models/providers)
```powershell
# Run after modifying @freezed models or @riverpod providers
flutter packages pub run build_runner build

# Watch mode during development
flutter packages pub run build_runner watch
```

### Firebase Setup (First Time)
1. Copy templates: `firebase.json.template` → `firebase.json`
2. Configure: `lib/firebase_options.dart.template` → `lib/firebase_options.dart`
3. Platform files: Download `google-services.json` (Android), `GoogleService-Info.plist` (iOS)
4. See `FIREBASE_SETUP.md` for complete steps

### Localization
- **Files**: `lib/src/shared/l10n/` contains ARB files for en/tn (Setswana)
- **Usage**: Access via `AppLocalizations.of(context)` or `l10n.welcomeScreen1Title`
- **Fallback**: Custom delegates handle unsupported locales

### Beta Release Process (APK)
```powershell
# Build beta APK for release
flutter build apk --release --build-name=1.0.x-beta --build-number=x

# Create GitHub release as beta/pre-release
# Upload APK to GitHub releases with beta tag
# Mark as "Pre-release" in GitHub UI
```
- **Version Pattern**: Use semantic versioning with `-beta` suffix (e.g., `1.0.2-beta`)
- **GitHub Releases**: Always mark APK releases as "Pre-release" since project is in beta
- **Release Notes**: Include changelog and known issues in release description

## Project-Specific Conventions

### Code Documentation & TODOs
- **Comments**: ALWAYS add comprehensive comments explaining business logic, complex algorithms, and architectural decisions
- **Method Documentation**: Use Dart doc comments (`///`) for all public methods and classes
- **TODOs**: Formatted as `TODO(category): description` for categorization (see existing patterns)
- **Future Improvements**: Document potential optimizations and enhancements as TODOs with specific categories

### Naming & Organization
- **Files**: Snake_case for files, PascalCase for classes
- **Exports**: Each folder has main export file (`shared.dart`, `models.dart`, etc.)
- **Routes**: Centralized in `AppRoutes` class with both paths and route names

### Role-Specific Patterns
- **User Types**: Check `UserRole.hustler` vs `UserRole.employer` enum values
- **Models**: `Hustler` extends `AppUser`, `Employer` extends `AppUser`
- **Navigation**: Different shells and navigation flows post-authentication
- **Theme**: Employer sections use swapped color scheme (secondary becomes primary)

### Firebase Integration
- **Auth**: Always check `FirebaseAuth.instance.currentUser?.uid`
- **Firestore**: Use generated service providers, not direct Firebase calls
- **Storage**: Image uploads via `firebase_storage` with permission handling
- **Error Handling**: Use `UserFriendlyException` with localized error keys

### Shared Utilities
- **Extensions**: Check `lib/src/shared/utils/` for common extensions
- **Debug**: Use `DebugHelper` class for consistent logging
- **Errors**: Map Firebase errors to user-friendly messages via `AuthErrorMapper`

## Critical Implementation Notes

### SharedPreferences Integration
- **Pattern**: Wrap in ChangeNotifier providers for GoRouter refresh
- **Example**: `WelcomePageSharedPreferencesNotifier` for onboarding state
- **Usage**: Router redirect logic depends on these preference states

### Image Handling
- **Picker**: `image_picker` + `file_selector` for cross-platform file selection
- **Upload**: Firebase Storage with progress tracking
- **Display**: `extended_image` for better caching and loading states

### Botswana Context
- **Phone Numbers**: +267 country code format
- **Currency**: Consider Pula (BWP) for pricing
- **Localization**: Support for Setswana (tn) language alongside English

When modifying this codebase:
1. Run code generation after model changes
2. Update both role shells if adding navigation
3. Consider localization for new strings
4. Test auth flow changes across both user roles
5. Verify Firebase configuration templates remain in sync