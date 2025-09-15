import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tn.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tn'),
  ];

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your hustle.'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Join Hustle Link Today!'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your free account and start connecting with amazing side hustles today!.'**
  String get registerSubtitle;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a password reset link.'**
  String get resetPasswordSubtitle;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get resetPasswordButton;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @signOutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirmation;

  /// No description provided for @signOutSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have successfully signed out.'**
  String get signOutSuccess;

  /// No description provided for @signOutError.
  ///
  /// In en, this message translates to:
  /// **'Sign out failed. Please try again.'**
  String get signOutError;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Please log in to continue.'**
  String get registrationSuccess;

  /// No description provided for @registrationError.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationError;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials and try again.'**
  String get loginError;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required.'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required.'**
  String get passwordRequired;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password.'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long.'**
  String get weakPassword;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No user found with this email.'**
  String get userNotFound;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get createNewAccount;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Logging in, please wait...'**
  String get loadingMessage;

  /// No description provided for @registrationLoadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Registering, please wait...'**
  String get registrationLoadingMessage;

  /// No description provided for @passwordResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Reset'**
  String get passwordResetTitle;

  /// No description provided for @passwordResetSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address below to receive a password reset link.'**
  String get passwordResetSubTitle;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @sendButtonText.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendButtonText;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// No description provided for @passwordResetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset link to:\n{email}'**
  String passwordResetLinkSent(Object email);

  /// No description provided for @resendLink.
  ///
  /// In en, this message translates to:
  /// **'Resend link'**
  String get resendLink;

  /// No description provided for @resendAvailableIn.
  ///
  /// In en, this message translates to:
  /// **'Resend available in {seconds}s'**
  String resendAvailableIn(Object seconds);

  /// No description provided for @didNotGetEmail.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get the email? Check your spam folder or try again.'**
  String get didNotGetEmail;

  /// No description provided for @completeYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get completeYourProfile;

  /// No description provided for @whatsYourName.
  ///
  /// In en, this message translates to:
  /// **'What\'s your name?'**
  String get whatsYourName;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @whatBringsYouToHustleLink.
  ///
  /// In en, this message translates to:
  /// **'What brings you to Hustle Link?'**
  String get whatBringsYouToHustleLink;

  /// No description provided for @chooseYourRole.
  ///
  /// In en, this message translates to:
  /// **'Choose your role to get started'**
  String get chooseYourRole;

  /// No description provided for @imAHustler.
  ///
  /// In en, this message translates to:
  /// **'I\'m a Hustler'**
  String get imAHustler;

  /// No description provided for @lookingForFreelanceWork.
  ///
  /// In en, this message translates to:
  /// **'Looking for freelance work and gigs'**
  String get lookingForFreelanceWork;

  /// No description provided for @imAnEmployer.
  ///
  /// In en, this message translates to:
  /// **'I\'m an Employer'**
  String get imAnEmployer;

  /// No description provided for @lookingToHireTalent.
  ///
  /// In en, this message translates to:
  /// **'Looking to hire talented freelancers'**
  String get lookingToHireTalent;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @findJobs.
  ///
  /// In en, this message translates to:
  /// **'Find Jobs'**
  String get findJobs;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String welcomeBack(Object name);

  /// No description provided for @addSkillsToProfile.
  ///
  /// In en, this message translates to:
  /// **'Add skills to your profile to see relevant jobs'**
  String get addSkillsToProfile;

  /// No description provided for @jobsMatchingYourSkills.
  ///
  /// In en, this message translates to:
  /// **'Jobs matching your skills: {skills}'**
  String jobsMatchingYourSkills(Object skills);

  /// No description provided for @noJobsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No jobs available'**
  String get noJobsAvailable;

  /// No description provided for @checkBackLater.
  ///
  /// In en, this message translates to:
  /// **'Check back later for new opportunities'**
  String get checkBackLater;

  /// No description provided for @errorLoadingJobs.
  ///
  /// In en, this message translates to:
  /// **'Error loading jobs: {error}'**
  String errorLoadingJobs(Object error);

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @profileNotFound.
  ///
  /// In en, this message translates to:
  /// **'Profile not found'**
  String get profileNotFound;

  /// No description provided for @errorLoadingProfile.
  ///
  /// In en, this message translates to:
  /// **'Error loading profile: {error}'**
  String errorLoadingProfile(Object error);

  /// No description provided for @moreSkills.
  ///
  /// In en, this message translates to:
  /// **'+{count} more skills'**
  String moreSkills(Object count);

  /// No description provided for @applicants.
  ///
  /// In en, this message translates to:
  /// **'{count} applicants'**
  String applicants(Object count);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @ago.
  ///
  /// In en, this message translates to:
  /// **'{time} ago'**
  String ago(Object time);

  /// No description provided for @myApplications.
  ///
  /// In en, this message translates to:
  /// **'My Applications'**
  String get myApplications;

  /// No description provided for @noApplicationsYet.
  ///
  /// In en, this message translates to:
  /// **'No Applications Yet'**
  String get noApplicationsYet;

  /// No description provided for @startApplyingForJobs.
  ///
  /// In en, this message translates to:
  /// **'Start applying for jobs to see them here'**
  String get startApplyingForJobs;

  /// No description provided for @errorLoadingApplications.
  ///
  /// In en, this message translates to:
  /// **'Error loading applications'**
  String get errorLoadingApplications;

  /// No description provided for @jobTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobTitle;

  /// No description provided for @appliedAs.
  ///
  /// In en, this message translates to:
  /// **'Applied as {name}'**
  String appliedAs(Object name);

  /// No description provided for @coverLetter.
  ///
  /// In en, this message translates to:
  /// **'Cover Letter:'**
  String get coverLetter;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Applied {timeAgo}'**
  String applied(Object timeAgo);

  /// No description provided for @viewJob.
  ///
  /// In en, this message translates to:
  /// **'View Job'**
  String get viewJob;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @reviewed.
  ///
  /// In en, this message translates to:
  /// **'Reviewed'**
  String get reviewed;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @addPhoneNumberAndLocation.
  ///
  /// In en, this message translates to:
  /// **'Add phone number and location'**
  String get addPhoneNumberAndLocation;

  /// No description provided for @addPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Add phone number'**
  String get addPhoneNumber;

  /// No description provided for @addLocation.
  ///
  /// In en, this message translates to:
  /// **'Add location'**
  String get addLocation;

  /// No description provided for @skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skills;

  /// No description provided for @addYourSkills.
  ///
  /// In en, this message translates to:
  /// **'Add your skills to find relevant jobs'**
  String get addYourSkills;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @jobsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Jobs Completed'**
  String get jobsCompleted;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @addYourWorkExperience.
  ///
  /// In en, this message translates to:
  /// **'Add your work experience and achievements'**
  String get addYourWorkExperience;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get memberSince;

  /// No description provided for @accountType.
  ///
  /// In en, this message translates to:
  /// **'Account Type'**
  String get accountType;

  /// No description provided for @hustler.
  ///
  /// In en, this message translates to:
  /// **'Hustler'**
  String get hustler;

  /// No description provided for @supportAndActions.
  ///
  /// In en, this message translates to:
  /// **'Support & Actions'**
  String get supportAndActions;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @setswana.
  ///
  /// In en, this message translates to:
  /// **'Setswana'**
  String get setswana;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @getHelpAndSendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Get help and send feedback'**
  String get getHelpAndSendFeedback;

  /// No description provided for @addBio.
  ///
  /// In en, this message translates to:
  /// **'Add bio'**
  String get addBio;

  /// No description provided for @profileCompletion.
  ///
  /// In en, this message translates to:
  /// **'Profile Completion'**
  String get profileCompletion;

  /// No description provided for @yourProfileIsComplete.
  ///
  /// In en, this message translates to:
  /// **'Your profile is complete! 🎉'**
  String get yourProfileIsComplete;

  /// No description provided for @almostThere.
  ///
  /// In en, this message translates to:
  /// **'Almost there! Just a few more details.'**
  String get almostThere;

  /// No description provided for @goodProgress.
  ///
  /// In en, this message translates to:
  /// **'Good progress! Add more info to stand out.'**
  String get goodProgress;

  /// No description provided for @completeYourProfileToAttractMoreOpportunities.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile to attract more opportunities.'**
  String get completeYourProfileToAttractMoreOpportunities;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfile;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @failedToPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image: {error}'**
  String failedToPickImage(Object error);

  /// No description provided for @failedToPickFiles.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick files: {error}'**
  String failedToPickFiles(Object error);

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @failedToUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile: {error}'**
  String failedToUpdateProfile(Object error);

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @nameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameIsRequired;

  /// No description provided for @bio.
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// No description provided for @tellOthersAboutYourself.
  ///
  /// In en, this message translates to:
  /// **'Tell others about yourself...'**
  String get tellOthersAboutYourself;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @cityState.
  ///
  /// In en, this message translates to:
  /// **'City, State'**
  String get cityState;

  /// No description provided for @professionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Professional Information'**
  String get professionalInformation;

  /// No description provided for @skillsHint.
  ///
  /// In en, this message translates to:
  /// **'Web Development, Mobile Apps, Design, etc.'**
  String get skillsHint;

  /// No description provided for @pleaseAddAtLeastOneSkill.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one skill'**
  String get pleaseAddAtLeastOneSkill;

  /// No description provided for @separateSkillsWithCommas.
  ///
  /// In en, this message translates to:
  /// **'Separate skills with commas'**
  String get separateSkillsWithCommas;

  /// No description provided for @experienceHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your work experience, projects, or achievements...'**
  String get experienceHint;

  /// No description provided for @certifications.
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get certifications;

  /// No description provided for @uploadCertificates.
  ///
  /// In en, this message translates to:
  /// **'Upload your certificates, diplomas, or other qualification documents (PDF, DOC, DOCX)'**
  String get uploadCertificates;

  /// No description provided for @uploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded'**
  String get uploaded;

  /// No description provided for @readyToUpload.
  ///
  /// In en, this message translates to:
  /// **'Ready to upload'**
  String get readyToUpload;

  /// No description provided for @addCertifications.
  ///
  /// In en, this message translates to:
  /// **'Add Certifications'**
  String get addCertifications;

  /// No description provided for @jobDetails.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get jobDetails;

  /// No description provided for @jobNotFound.
  ///
  /// In en, this message translates to:
  /// **'Job not found'**
  String get jobNotFound;

  /// No description provided for @applicationSubmittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Application submitted successfully!'**
  String get applicationSubmittedSuccessfully;

  /// No description provided for @aboutThisJob.
  ///
  /// In en, this message translates to:
  /// **'About this job'**
  String get aboutThisJob;

  /// No description provided for @requiredSkills.
  ///
  /// In en, this message translates to:
  /// **'Required Skills'**
  String get requiredSkills;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @posted.
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get posted;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @applyForThisJob.
  ///
  /// In en, this message translates to:
  /// **'Apply for this job'**
  String get applyForThisJob;

  /// No description provided for @writeACoverLetter.
  ///
  /// In en, this message translates to:
  /// **'Write a cover letter (optional)'**
  String get writeACoverLetter;

  /// No description provided for @alreadyApplied.
  ///
  /// In en, this message translates to:
  /// **'Already Applied'**
  String get alreadyApplied;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  /// No description provided for @myJobs.
  ///
  /// In en, this message translates to:
  /// **'My Jobs'**
  String get myJobs;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcome(Object name);

  /// No description provided for @postedJobs.
  ///
  /// In en, this message translates to:
  /// **'Posted Jobs'**
  String get postedJobs;

  /// No description provided for @noJobsPostedYet.
  ///
  /// In en, this message translates to:
  /// **'No jobs posted yet'**
  String get noJobsPostedYet;

  /// No description provided for @createYourFirstJobPosting.
  ///
  /// In en, this message translates to:
  /// **'Create your first job posting to find talent'**
  String get createYourFirstJobPosting;

  /// No description provided for @postAJob.
  ///
  /// In en, this message translates to:
  /// **'Post a Job'**
  String get postAJob;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @postNewJob.
  ///
  /// In en, this message translates to:
  /// **'Post New Job'**
  String get postNewJob;

  /// No description provided for @postYourFirstJob.
  ///
  /// In en, this message translates to:
  /// **'Post your first job to start finding hustlers'**
  String get postYourFirstJob;

  /// No description provided for @viewApplications.
  ///
  /// In en, this message translates to:
  /// **'View Applications'**
  String get viewApplications;

  /// No description provided for @editJob.
  ///
  /// In en, this message translates to:
  /// **'Edit Job'**
  String get editJob;

  /// No description provided for @closeJob.
  ///
  /// In en, this message translates to:
  /// **'Close Job'**
  String get closeJob;

  /// No description provided for @reopenJob.
  ///
  /// In en, this message translates to:
  /// **'Reopen Job'**
  String get reopenJob;

  /// No description provided for @deleteJob.
  ///
  /// In en, this message translates to:
  /// **'Delete Job'**
  String get deleteJob;

  /// No description provided for @areYouSureYouWantToDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{jobTitle}\"? This action cannot be undone.'**
  String areYouSureYouWantToDelete(Object jobTitle);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @jobDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Job deleted successfully'**
  String get jobDeletedSuccessfully;

  /// No description provided for @errorDeletingJob.
  ///
  /// In en, this message translates to:
  /// **'Error deleting job: {error}'**
  String errorDeletingJob(Object error);

  /// No description provided for @jobApplications.
  ///
  /// In en, this message translates to:
  /// **'Job Applications'**
  String get jobApplications;

  /// No description provided for @createPostingTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a new job posting'**
  String get createPostingTitle;

  /// No description provided for @updatePostingTitle.
  ///
  /// In en, this message translates to:
  /// **'Update your job posting'**
  String get updatePostingTitle;

  /// No description provided for @createPostingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in the details to attract the right talent'**
  String get createPostingSubtitle;

  /// No description provided for @updatePostingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Modify the fields you want to update'**
  String get updatePostingSubtitle;

  /// No description provided for @jobDescription.
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get jobDescription;

  /// No description provided for @compensation.
  ///
  /// In en, this message translates to:
  /// **'Compensation (\$A)'**
  String get compensation;

  /// No description provided for @jobTitleHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Senior Flutter Developer'**
  String get jobTitleHint;

  /// No description provided for @jobDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us about this job...'**
  String get jobDescriptionHint;

  /// No description provided for @compensationHint.
  ///
  /// In en, this message translates to:
  /// **'5000'**
  String get compensationHint;

  /// No description provided for @locationHint.
  ///
  /// In en, this message translates to:
  /// **'Remote, New York, etc.'**
  String get locationHint;

  /// No description provided for @descriptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Describe the role, responsibilities, and requirements'**
  String get descriptionSubtitle;

  /// No description provided for @jobTitleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a job title'**
  String get jobTitleRequired;

  /// No description provided for @jobDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a job description'**
  String get jobDescriptionRequired;

  /// No description provided for @jobDescriptionTooShort.
  ///
  /// In en, this message translates to:
  /// **'Description should be at least 50 characters'**
  String get jobDescriptionTooShort;

  /// No description provided for @skillsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter required skills'**
  String get skillsRequired;

  /// No description provided for @compensationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter compensation'**
  String get compensationRequired;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get invalidAmount;

  /// No description provided for @postJobButton.
  ///
  /// In en, this message translates to:
  /// **'Post Job'**
  String get postJobButton;

  /// No description provided for @saveChangesButton.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChangesButton;

  /// No description provided for @savedMessage.
  ///
  /// In en, this message translates to:
  /// **'Saved!'**
  String get savedMessage;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @addWebsite.
  ///
  /// In en, this message translates to:
  /// **'Add website'**
  String get addWebsite;

  /// No description provided for @aboutCompany.
  ///
  /// In en, this message translates to:
  /// **'About Company'**
  String get aboutCompany;

  /// No description provided for @addAShortDescriptionAboutYourCompany.
  ///
  /// In en, this message translates to:
  /// **'Add a short description about your company'**
  String get addAShortDescriptionAboutYourCompany;

  /// No description provided for @employer.
  ///
  /// In en, this message translates to:
  /// **'Employer'**
  String get employer;

  /// No description provided for @yourCompanyProfileIsComplete.
  ///
  /// In en, this message translates to:
  /// **'Your company profile is complete!'**
  String get yourCompanyProfileIsComplete;

  /// No description provided for @almostThereCompany.
  ///
  /// In en, this message translates to:
  /// **'Almost there! Add the remaining details.'**
  String get almostThereCompany;

  /// No description provided for @goodProgressCompany.
  ///
  /// In en, this message translates to:
  /// **'Good progress! Add more company info.'**
  String get goodProgressCompany;

  /// No description provided for @completeYourCompanyProfileToBuildTrust.
  ///
  /// In en, this message translates to:
  /// **'Complete your company profile to build trust with hustlers.'**
  String get completeYourCompanyProfileToBuildTrust;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// No description provided for @companyNameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Company name is required'**
  String get companyNameIsRequired;

  /// No description provided for @companyDescription.
  ///
  /// In en, this message translates to:
  /// **'Company Description'**
  String get companyDescription;

  /// No description provided for @describeYourCompany.
  ///
  /// In en, this message translates to:
  /// **'Describe your company, mission, and values...'**
  String get describeYourCompany;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'{count} total'**
  String total(Object count);

  /// No description provided for @subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptions;

  /// No description provided for @chooseYourPlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan'**
  String get chooseYourPlan;

  /// No description provided for @unlockFullPotential.
  ///
  /// In en, this message translates to:
  /// **'Unlock your full potential with our premium features.'**
  String get unlockFullPotential;

  /// No description provided for @freePlan.
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get freePlan;

  /// No description provided for @viewFiveJobs.
  ///
  /// In en, this message translates to:
  /// **'View up to 5 latest job postings'**
  String get viewFiveJobs;

  /// No description provided for @postThreeJobs.
  ///
  /// In en, this message translates to:
  /// **'Post up to 3 jobs for free'**
  String get postThreeJobs;

  /// No description provided for @premiumPlan.
  ///
  /// In en, this message translates to:
  /// **'Premium Plan'**
  String get premiumPlan;

  /// No description provided for @unlimitedJobPostings.
  ///
  /// In en, this message translates to:
  /// **'Unlimited job postings'**
  String get unlimitedJobPostings;

  /// No description provided for @unlimitedJobViews.
  ///
  /// In en, this message translates to:
  /// **'Unlimited job views'**
  String get unlimitedJobViews;

  /// No description provided for @prioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get prioritySupport;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @subscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get subscribe;

  /// No description provided for @subscriptionSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Subscription successful!'**
  String get subscriptionSuccessful;

  /// No description provided for @subscriptionStatus.
  ///
  /// In en, this message translates to:
  /// **'Subscription Status'**
  String get subscriptionStatus;

  /// No description provided for @currentSubscription.
  ///
  /// In en, this message translates to:
  /// **'Current Subscription'**
  String get currentSubscription;

  /// No description provided for @subscriptionActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get subscriptionActive;

  /// No description provided for @subscriptionInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get subscriptionInactive;

  /// No description provided for @freeAccount.
  ///
  /// In en, this message translates to:
  /// **'Free Account'**
  String get freeAccount;

  /// No description provided for @manageSubscription.
  ///
  /// In en, this message translates to:
  /// **'Manage Subscription'**
  String get manageSubscription;

  /// No description provided for @upgradeNow.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now'**
  String get upgradeNow;

  /// No description provided for @viewPlans.
  ///
  /// In en, this message translates to:
  /// **'View Plans'**
  String get viewPlans;

  /// No description provided for @subscriptionExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get subscriptionExpires;

  /// No description provided for @subscriptionRenews.
  ///
  /// In en, this message translates to:
  /// **'Next billing'**
  String get subscriptionRenews;

  /// No description provided for @authUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authUserDisabled;

  /// No description provided for @authWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get authWrongPassword;

  /// No description provided for @authEmailInUse.
  ///
  /// In en, this message translates to:
  /// **'Email already in use.'**
  String get authEmailInUse;

  /// No description provided for @authNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get authNetworkError;

  /// No description provided for @authTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get authTooManyRequests;

  /// No description provided for @authOpNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method is not enabled.'**
  String get authOpNotAllowed;

  /// No description provided for @authGeneric.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please try again.'**
  String get authGeneric;

  /// No description provided for @authPasswordResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Password reset failed. Please try again.'**
  String get authPasswordResetFailed;

  /// No description provided for @welcomeScreen1Title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Hustle Link!'**
  String get welcomeScreen1Title;

  /// No description provided for @welcomeScreen1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your ultimate platform for discovering flexible side hustles and connecting with new opportunities. Let\'s get started!'**
  String get welcomeScreen1Subtitle;

  /// No description provided for @welcomeScreen1Button.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get welcomeScreen1Button;

  /// No description provided for @welcomeScreen2Title.
  ///
  /// In en, this message translates to:
  /// **'Unlock Your Potential'**
  String get welcomeScreen2Title;

  /// No description provided for @welcomeScreen2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Go beyond your 9-to-5. Discover opportunities that fuel your passions and accelerate your financial goals.'**
  String get welcomeScreen2Subtitle;

  /// No description provided for @welcomeScreen2Button.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get welcomeScreen2Button;

  /// No description provided for @welcomeScreen3Title.
  ///
  /// In en, this message translates to:
  /// **'Your Next Big Idea Awaits'**
  String get welcomeScreen3Title;

  /// No description provided for @welcomeScreen3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Tired of the traditional job search? Find flexible gigs and projects that fit your life, not the other way around.'**
  String get welcomeScreen3Subtitle;

  /// No description provided for @welcomeScreen3Button.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get welcomeScreen3Button;

  /// No description provided for @welcomeScreen4Title.
  ///
  /// In en, this message translates to:
  /// **'Earn More, Live More'**
  String get welcomeScreen4Title;

  /// No description provided for @welcomeScreen4Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Supplement your income and gain new skills. Transform your spare time into extra cash and exciting experiences.'**
  String get welcomeScreen4Subtitle;

  /// No description provided for @welcomeScreen4Button.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get welcomeScreen4Button;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tn':
      return AppLocalizationsTn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
