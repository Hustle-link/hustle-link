// create strings for firebase auth errors
class FirebaseAuthStrings {
  static const String userNotFound = 'No user found for that email.';
  static const String wrongPassword = 'Wrong password provided for that user.';
  static const String emailAlreadyInUse =
      'The account already exists for that email.';
  static const String weakPassword = 'The password provided is too weak.';
  static const String operationNotAllowed = 'Operation not allowed.';
  static const String invalidEmail = 'The email address is not valid.';
  static const String userDisabled = 'User has been disabled.';
}

// create strings for firebase auth success messages
class FirebaseAuthSuccessStrings {
  static const String signInSuccess = 'Successfully signed in.';
  static const String signOutSuccess = 'Successfully signed out.';
  static const String registrationSuccess =
      'Successfully registered. Please log in.';
  static const String passwordResetEmailSent = 'Password reset email sent.';
}

// create strings for firebase auth general messages
class FirebaseAuthGeneralStrings {
  static const String loading = 'Loading...';
  static const String errorOccurred = 'An error occurred. Please try again.';
  static const String welcomeBack = 'Welcome back!';
  static const String welcome = 'Welcome to Hustle Link!';
}
