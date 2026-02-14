# Flutter Catalog Project Overview

An interactive Flutter application showcasing a wide range of Flutter components, layouts, and features with integrated side-by-side source code views.

## Project Summary

- **Primary Technology:** Flutter & Dart
- **Architecture:** Feature-based organization with a central routing table.
- **State Management:** Uses a mix of `flutter_riverpod` and `provider`.
- **Backend/Services:** Heavily integrated with Firebase (Auth, Analytics, Crashlytics, Firestore, etc.), Google Mobile Ads (AdMob), and AI services (OpenAI, Groq).
- **Core Functionality:** Each example is a "route" that includes both the running widget and its source code. Source files are treated as assets to enable the "Code" view.

## Building and Running

### Prerequisites
- Flutter SDK (Check `.fvmrc` if present for preferred version).
- Firebase setup (requires `firebase_options.dart` and platform-specific config files like `google-services.json`).

### Key Commands
- **Install Dependencies:** `flutter pub get`
- **Run the App:** `flutter run`
- **Build Web Version:** `flutter build web`
- **Code Generation:** `dart run build_runner build --delete-conflicting-outputs` (used for `freezed`, `json_serializable`, etc.)

### Code Quality & Maintenance
- **Static Analysis:** `flutter analyze`
- **Format Code:** `dart format .`
- **Auto-fix Lint Issues:** `dart fix --apply`
- **Testing:** `flutter test`

## Project Structure

- `lib/main.dart`: Entry point, initializes Firebase and settings.
- `lib/my_main_app.dart`: Root `MaterialApp` widget.
- `lib/my_app_routes.dart`: The "brain" of the app; defines the entire catalog structure and routing table.
- `lib/my_route.dart`: A wrapper widget for all examples, providing the backdrop and code-view toggle.
- `lib/routes/`: Contains individual example implementations (e.g., `widgets_text_ex.dart`).
- `lib/my_app_settings.dart`: Manages persistent user preferences (Dark mode, Bookmarks, etc.) using `shared_preferences`.
- `res/`: Contains application assets (images, lottie animations).
- `packages/`: Contains local package modifications or custom widgets (e.g., `widget_with_codeview`).

## Development Conventions

- **Side-by-Side Source View:** Every new example should be added to `lib/routes/` and registered in `lib/my_app_routes.dart`. The source file MUST be included in the `assets` section of `pubspec.yaml` to be viewable in the app.
- **Naming Convention:** Route files typically follow the pattern `{category}_{feature}_ex.dart`.
- **Linting:** Follows `package:flutter_lints` with some relaxations defined in `analysis_options.yaml` (e.g., allowing `this` for clarity).
- **Firebase:** Ensure all Firebase features are initialized conditionally for supported platforms (Mobile/Web).

## Key Files

- `pubspec.yaml`: Manages extensive dependencies and asset declarations.
- `lib/my_app_routes.dart`: Centralized location for the catalog's content hierarchy.
- `lib/constants.dart`: Global constants and platform detection logic.
- `analysis_options.yaml`: Project-specific linting and static analysis rules.
