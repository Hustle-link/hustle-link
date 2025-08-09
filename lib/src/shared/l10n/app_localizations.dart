import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_st.dart';

abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('st')
  ];

  String get loginTitle;
  String get loginSubtitle;
  String get emailLabel;
  String get passwordLabel;
  String get forgotPassword;
  String get signIn;
  String get noAccount;
  String get createAccount;
  String get registerTitle;
  String get registerSubtitle;
  String get confirmPasswordLabel;
  String get registerButton;
  String get resetPassword;
  String get resetPasswordSubtitle;
  String get resetPasswordButton;
  String get alreadyHaveAccount;
  String get signOut;
  String get signOutConfirmation;
  String get signOutSuccess;
  String get signOutError;
  String get registrationSuccess;
  String get registrationError;
  String get loginError;
  String get emailRequired;
  String get passwordRequired;
  String get confirmPasswordRequired;
  String get passwordsDoNotMatch;
  String get invalidEmail;
  String get weakPassword;
  String get userNotFound;
  String get createNewAccount;
  String get loadingMessage;
  String get registrationLoadingMessage;
  String get passwordResetTitle;
  String get passwordResetSubTitle;
  String get emailHint;
  String get sendButtonText;
  String get backToLogin;
  String get checkYourEmail;
  String passwordResetLinkSent(String email);
  String get resendLink;
  String resendAvailableIn(String seconds);
  String get didNotGetEmail;
  String get completeYourProfile;
  String get whatsYourName;
  String get fullName;
  String get enterYourFullName;
  String get whatBringsYouToHustleLink;
  String get chooseYourRole;
  String get imAHustler;
  String get lookingForFreelanceWork;
  String get imAnEmployer;
  String get lookingToHireTalent;
  String get getStarted;
  String get tryAgain;
  String get findJobs;
  String welcomeBack(String name);
  String get addSkillsToProfile;
  String jobsMatchingYourSkills(String skills);
  String get noJobsAvailable;
  String get checkBackLater;
  String errorLoadingJobs(String error);
  String get retry;
  String get profileNotFound;
  String errorLoadingProfile(String error);
  String moreSkills(String count);
  String applicants(String count);
  String get justNow;
  String ago(String time);
  String get myApplications;
  String get noApplicationsYet;
  String get startApplyingForJobs;
  String get errorLoadingApplications;
  String get jobTitle;
  String appliedAs(String name);
  String get coverLetter;
  String applied(String timeAgo);
  String get viewJob;
  String get pending;
  String get reviewed;
  String get accepted;
  String get rejected;
  String get profile;
  String get editProfile;
  String get logout;
  String get contactInformation;
  String get phone;
  String get location;
  String get addPhoneNumberAndLocation;
  String get addPhoneNumber;
  String get addLocation;
  String get skills;
  String get addYourSkills;
  String get statistics;
  String get jobsCompleted;
  String get rating;
  String get experience;
  String get addYourWorkExperience;
  String get account;
  String get memberSince;
  String get accountType;
  String get hustler;
  String get supportAndActions;
  String get language;
  String get english;
  String get setswana;
  String get contactSupport;
  String get getHelpAndSendFeedback;
  String get addBio;
  String get profileCompletion;
  String get yourProfileIsComplete;
  String get almostThere;
  String get goodProgress;
  String get completeYourProfileToAttractMoreOpportunities;
  String get completeProfile;
  String get save;
  String failedToPickImage(String error);
  String failedToPickFiles(String error);
  String get profileUpdatedSuccessfully;
  String failedToUpdateProfile(String error);
  String get changePhoto;
  String get addPhoto;
  String get basicInformation;
  String get nameIsRequired;
  String get bio;
  String get tellOthersAboutYourself;
  String get phoneNumber;
  String get cityState;
  String get professionalInformation;
  String get skillsHint;
  String get pleaseAddAtLeastOneSkill;
  String get separateSkillsWithCommas;
  String get experienceHint;
  String get certifications;
  String get uploadCertificates;
  String get uploaded;
  String get readyToUpload;
  String get addCertifications;
  String get jobDetails;
  String get jobNotFound;
  String get applicationSubmittedSuccessfully;
  String get aboutThisJob;
  String get requiredSkills;
  String get details;
  String get posted;
  String get deadline;
  String get applyForThisJob;
  String get writeACoverLetter;
  String get alreadyApplied;
  String get applyNow;
  String get myJobs;
  String welcome(String name);
  String get postedJobs;
  String get noJobsPostedYet;
  String get createYourFirstJobPosting;
  String get postAJob;
  String get active;
  String get closed;
  String get draft;
  String get postNewJob;
  String get postYourFirstJob;
  String get viewApplications;
  String get editJob;
  String get closeJob;
  String get reopenJob;
  String get deleteJob;
  String areYouSureYouWantToDelete(String jobTitle);
  String get cancel;
  String get delete;
  String get jobDeletedSuccessfully;
  String errorDeletingJob(String error);
  String get jobApplications;
  String get createPostingTitle;
  String get updatePostingTitle;
  String get createPostingSubtitle;
  String get updatePostingSubtitle;
  String get jobDescription;
  String get compensation;
  String get jobTitleHint;
  String get jobDescriptionHint;
  String get compensationHint;
  String get locationHint;
  String get descriptionSubtitle;
  String get jobTitleRequired;
  String get jobDescriptionRequired;
  String get jobDescriptionTooShort;
  String get skillsRequired;
  String get compensationRequired;
  String get invalidAmount;
  String get postJobButton;
  String get saveChangesButton;
  String get savedMessage;
  String get website;
  String get addWebsite;
  String get aboutCompany;
  String get addAShortDescriptionAboutYourCompany;
  String get employer;
  String get yourCompanyProfileIsComplete;
  String get almostThereCompany;
  String get goodProgressCompany;
  String get completeYourCompanyProfileToBuildTrust;
  String get personalInformation;
  String get companyName;
  String get companyNameIsRequired;
  String get companyDescription;
  String get describeYourCompany;
  String total(String count);
  String get subscriptions;
  String get chooseYourPlan;
  String get unlockFullPotential;
  String get freePlan;
  String get viewFiveJobs;
  String get postThreeJobs;
  String get premiumPlan;
  String get unlimitedJobPostings;
  String get unlimitedJobViews;
  String get prioritySupport;
  String get currentPlan;
  String get subscribe;
  String get subscriptionSuccessful;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return <String>['en', 'st'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'st': return AppLocalizationsSt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub.'
  );
}
