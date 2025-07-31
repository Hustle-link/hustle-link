class AppStringsAuth {
  static const String loginTitle = 'Welcome Back to Hustle Link!';
  static const String loginSubtitle =
      'Sign in to continue exploring flexible side hustles and new opportunities.';
  static const String registerTitle = 'Join Hustle Link Today!';
  static const String registerSubtitle =
      'Create your free account and start connecting with amazing side hustles today!.';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = 'Confirm Password';
  static const String loginButton = 'Login';
  static const String registerButton = 'Register';
  static const String forgotPassword = 'Forgot Your Password?';
  static const String resetPassword = 'Reset Password';
  static const String resetPasswordSubtitle =
      'Enter your email to receive a password reset link.';
  static const String resetPasswordButton = 'Send Reset Link';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String createAccount = 'Create an account';
  static const String signOut = 'Sign Out';
  static const String signOutConfirmation =
      'Are you sure you want to sign out?';
  static const String signOutSuccess = 'You have successfully signed out.';
  static const String signOutError = 'Sign out failed. Please try again.';
  static const String registrationSuccess =
      'Registration successful! Please log in to continue.';
  static const String registrationError =
      'Registration failed. Please try again.';
  static const String loginError =
      'Login failed. Please check your credentials and try again.';
  static const String emailRequired = 'Email is required.';
  static const String passwordRequired = 'Password is required.';
  static const String confirmPasswordRequired = 'Please confirm your password.';
  static const String passwordsDoNotMatch = 'Passwords do not match.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String weakPassword =
      'Password must be at least 6 characters long.';
  static const String userNotFound = 'No user found with this email.';
  static const String noAccount = 'Don\'t have an account?';
  static const String createNewAccount = 'Create a new account';

  // login loading message
  static const String loadingMessage = 'Logging in, please wait...';
  // registration loading message
  static const String registrationLoadingMessage =
      'Registering, please wait...';
}

// app strings for the welcome screen
class WelcomeScreenStringModel {
  final String title;
  final String subtitle;
  String? buttonText;

  WelcomeScreenStringModel({
    required this.title,
    required this.subtitle,
    this.buttonText,
  });
}

// app strings for the welcome screen
class AppStringsWelcome {
  static final WelcomeScreenStringModel
  welcomeScreen1 = WelcomeScreenStringModel(
    title: 'Welcome to Hustle Link!',
    subtitle:
        '''Your ultimate platform for discovering flexible side hustles and connecting with new opportunities. Let's get started!''',
    buttonText: 'Get Started',
  );

  static final WelcomeScreenStringModel
  welcomeScreen2 = WelcomeScreenStringModel(
    title: 'Unlock Your Potential',
    subtitle:
        '''Go beyond your 9-to-5. Discover opportunities that fuel your passions and accelerate your financial goals.''',
    buttonText: 'Next',
  );

  static final WelcomeScreenStringModel
  welcomeScreen3 = WelcomeScreenStringModel(
    title: 'Your Next Big Idea Awaits',
    subtitle:
        '''Tired of the traditional job search? Find flexible gigs and projects that fit your life, not the other way around.''',
    buttonText: 'Next',
  );

  static final WelcomeScreenStringModel
  welcomeScreen4 = WelcomeScreenStringModel(
    title: 'Earn More, Live More',
    subtitle:
        '''Supplement your income and gain new skills. Transform your spare time into extra cash and exciting experiences.''',
    buttonText: 'Start Now',
  );
}
