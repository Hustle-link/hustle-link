# Hustle Link (Botswana)

Hustle Link is a Botswana-based jobs and gigs marketplace that connects local employers with "hustlers" (freelancers and job seekers). The app focuses on the Botswana context, helping people find work opportunities and enabling businesses to quickly source local talent.

## What you can do

- Role-based experience for Botswana users:
 	- Hustlers: create a profile, browse jobs/gigs, apply, and track applications.
 	- Employers: create a profile, post jobs/gigs, manage listings, and review applicants.
- Secure sign-in and role selection.
- Manage profiles with photo upload and edits.
- View dashboards for both hustlers and employers.
- Backed by Firebase for auth, data, and storage.

## Tech stack

- Flutter (Dart)
- State management: Riverpod (flutter_riverpod, hooks_riverpod)
- Routing: go_router
- UI: Material 3, sizer, flutter_svg, flutter_animate, Flutter Smart Dialog
- Backend: Firebase (Auth, Cloud Firestore, Storage)

Key packages (see `pubspec.yaml` for full list): firebase_core, firebase_auth, cloud_firestore, firebase_storage, shared_preferences, image_picker, permission_handler.

## Botswana focus

This app is designed for Botswana-based users and organizations. Keep the following in mind when configuring data and content:

- Locations, contact details, and pricing should reflect Botswana (e.g., +267 phone numbers, Pula currency where applicable).
- Ensure compliance with your organization’s privacy and data policies; Firebase services are used for authentication, data, and media storage.

## Getting started (local development)

Prerequisites:

- Flutter SDK installed
- A Firebase project (Web, Android, and/or iOS apps added)

Set up and run:

1. Install dependencies

```powershell
flutter pub get
```

1. Configure Firebase

- Follow the steps in `FIREBASE_SETUP.md`.
- The repository includes templates you can copy/fill:
 	- `firebase.json.template` → `firebase.json`
 	- `firestore.rules.template` → `firestore.rules`
 	- `firestore.indexes.json.template` → `firestore.indexes.json`
 	- `lib/firebase_options.dart.template` → `lib/firebase_options.dart` (or generate via FlutterFire)

1. Run the app (choose your target device)

```powershell
flutter run -d windows        # Windows desktop
# or
flutter run -d chrome         # Web
# or
flutter run -d android        # Android
# or
flutter run -d ios            # iOS (on macOS)
```

## Project structure (high level)

- `lib/`
 	- `main.dart` – app entry
 	- `src/pages/` – feature pages
  		- `auth/` – login/registration/role selection
  		- `welcome/` – onboarding/welcome screens
  		- `home/` – home shell
  		- `hustler/` – hustler dashboard, profile, applications
  		- `employer/` – employer dashboard, post/manage jobs, profile
 	- `src/shared/`, `src/models/` – shared code and data models

## Scripts and notes

- Deploy rules/hosting: see `FIREBASE_SETUP.md` and `deploy-storage.sh` (if using a compatible shell).
- Native splash is configured via `flutter_native_splash` in `pubspec.yaml`.

## Contributing

Issues and contributions are welcome. Please ensure changes align with the Botswana-focused user base and follow the existing code style (see `analysis_options.yaml`).

## License

Proprietary – all rights reserved unless stated otherwise.
