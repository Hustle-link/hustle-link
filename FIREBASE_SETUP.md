# Firebase Setup Instructions

This project uses Firebase for authentication, database, and hosting. The Firebase configuration files are not tracked in Git for security reasons.

## Setup Steps

### 1. Install Firebase CLI
```bash
npm install -g firebase-tools
```

### 2. Login to Firebase
```bash
firebase login
```

### 3. Initialize Firebase Project
```bash
firebase init
```

### 4. Configure Firebase Options
1. Copy `lib/firebase_options.dart.template` to `lib/firebase_options.dart`
2. Replace all placeholder values (YOUR_*) with your actual Firebase project configuration
3. You can find these values in your Firebase Console > Project Settings > General > Your apps

### 5. Configure Firebase JSON
1. Copy `firebase.json.template` to `firebase.json`
2. Replace `YOUR_PROJECT_ID` with your actual Firebase project ID

### 6. Configure Firestore Rules (Optional)
1. Copy `firestore.rules.template` to `firestore.rules`
2. Modify the rules according to your security requirements

### 7. Configure Firestore Indexes (Optional)
1. Copy `firestore.indexes.json.template` to `firestore.indexes.json`
2. Add any additional indexes your app requires

### 8. Configure Platform-Specific Files

#### Android
- Download `google-services.json` from Firebase Console
- Place it in `android/app/google-services.json`

#### iOS
- Download `GoogleService-Info.plist` from Firebase Console  
- Place it in `ios/Runner/GoogleService-Info.plist`

## Important Notes

- Never commit the actual configuration files to Git
- The `.gitignore` file is configured to exclude all Firebase configuration files
- Template files are provided to help you set up your configuration
- Make sure to keep your API keys and configuration secure

## FlutterFire CLI (Alternative Method)

You can also use FlutterFire CLI to automatically configure Firebase:

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your Flutter app
flutterfire configure
```

This will automatically generate the `firebase_options.dart` file and configure platform-specific files.
