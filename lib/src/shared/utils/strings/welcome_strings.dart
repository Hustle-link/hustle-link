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
