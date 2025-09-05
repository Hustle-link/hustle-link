// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'Welcome Back!';

  @override
  String get loginSubtitle => 'Sign in to continue your hustle.';

  @override
  String get emailLabel => 'Email Address';

  @override
  String get passwordLabel => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get createAccount => 'Create Account';

  @override
  String get registerTitle => 'Join Hustle Link Today!';

  @override
  String get registerSubtitle =>
      'Create your free account and start connecting with amazing side hustles today!.';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get registerButton => 'Register';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordSubtitle =>
      'Enter your email to receive a password reset link.';

  @override
  String get resetPasswordButton => 'Send Reset Link';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signOutConfirmation => 'Are you sure you want to sign out?';

  @override
  String get signOutSuccess => 'You have successfully signed out.';

  @override
  String get signOutError => 'Sign out failed. Please try again.';

  @override
  String get registrationSuccess =>
      'Registration successful! Please log in to continue.';

  @override
  String get registrationError => 'Registration failed. Please try again.';

  @override
  String get loginError =>
      'Login failed. Please check your credentials and try again.';

  @override
  String get emailRequired => 'Email is required.';

  @override
  String get passwordRequired => 'Password is required.';

  @override
  String get confirmPasswordRequired => 'Please confirm your password.';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String get invalidEmail => 'Please enter a valid email address.';

  @override
  String get weakPassword => 'Password must be at least 6 characters long.';

  @override
  String get userNotFound => 'No user found with this email.';

  @override
  String get createNewAccount => 'Create a new account';

  @override
  String get loadingMessage => 'Logging in, please wait...';

  @override
  String get registrationLoadingMessage => 'Registering, please wait...';

  @override
  String get passwordResetTitle => 'Password Reset';

  @override
  String get passwordResetSubTitle =>
      'Enter your email address below to receive a password reset link.';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get sendButtonText => 'Send Reset Link';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get checkYourEmail => 'Check your email';

  @override
  String passwordResetLinkSent(Object email) {
    return 'We\'ve sent a password reset link to:\n$email';
  }

  @override
  String get resendLink => 'Resend link';

  @override
  String resendAvailableIn(Object seconds) {
    return 'Resend available in ${seconds}s';
  }

  @override
  String get didNotGetEmail =>
      'Didn\'t get the email? Check your spam folder or try again.';

  @override
  String get completeYourProfile => 'Complete Your Profile';

  @override
  String get whatsYourName => 'What\'s your name?';

  @override
  String get fullName => 'Full Name';

  @override
  String get enterYourFullName => 'Enter your full name';

  @override
  String get whatBringsYouToHustleLink => 'What brings you to Hustle Link?';

  @override
  String get chooseYourRole => 'Choose your role to get started';

  @override
  String get imAHustler => 'I\'m a Hustler';

  @override
  String get lookingForFreelanceWork => 'Looking for freelance work and gigs';

  @override
  String get imAnEmployer => 'I\'m an Employer';

  @override
  String get lookingToHireTalent => 'Looking to hire talented freelancers';

  @override
  String get getStarted => 'Get Started';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get findJobs => 'Find Jobs';

  @override
  String welcomeBack(Object name) {
    return 'Welcome back, $name!';
  }

  @override
  String get addSkillsToProfile =>
      'Add skills to your profile to see relevant jobs';

  @override
  String jobsMatchingYourSkills(Object skills) {
    return 'Jobs matching your skills: $skills';
  }

  @override
  String get noJobsAvailable => 'No jobs available';

  @override
  String get checkBackLater => 'Check back later for new opportunities';

  @override
  String errorLoadingJobs(Object error) {
    return 'Error loading jobs: $error';
  }

  @override
  String get retry => 'Retry';

  @override
  String get profileNotFound => 'Profile not found';

  @override
  String errorLoadingProfile(Object error) {
    return 'Error loading profile: $error';
  }

  @override
  String moreSkills(Object count) {
    return '+$count more skills';
  }

  @override
  String applicants(Object count) {
    return '$count applicants';
  }

  @override
  String get justNow => 'Just now';

  @override
  String ago(Object time) {
    return '$time ago';
  }

  @override
  String get myApplications => 'My Applications';

  @override
  String get noApplicationsYet => 'No Applications Yet';

  @override
  String get startApplyingForJobs => 'Start applying for jobs to see them here';

  @override
  String get errorLoadingApplications => 'Error loading applications';

  @override
  String get jobTitle => 'Job Title';

  @override
  String appliedAs(Object name) {
    return 'Applied as $name';
  }

  @override
  String get coverLetter => 'Cover Letter:';

  @override
  String applied(Object timeAgo) {
    return 'Applied $timeAgo';
  }

  @override
  String get viewJob => 'View Job';

  @override
  String get pending => 'Pending';

  @override
  String get reviewed => 'Reviewed';

  @override
  String get accepted => 'Accepted';

  @override
  String get rejected => 'Rejected';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get logout => 'Logout';

  @override
  String get contactInformation => 'Contact Information';

  @override
  String get phone => 'Phone';

  @override
  String get location => 'Location';

  @override
  String get addPhoneNumberAndLocation => 'Add phone number and location';

  @override
  String get addPhoneNumber => 'Add phone number';

  @override
  String get addLocation => 'Add location';

  @override
  String get skills => 'Skills';

  @override
  String get addYourSkills => 'Add your skills to find relevant jobs';

  @override
  String get statistics => 'Statistics';

  @override
  String get jobsCompleted => 'Jobs Completed';

  @override
  String get rating => 'Rating';

  @override
  String get experience => 'Experience';

  @override
  String get addYourWorkExperience =>
      'Add your work experience and achievements';

  @override
  String get account => 'Account';

  @override
  String get memberSince => 'Member Since';

  @override
  String get accountType => 'Account Type';

  @override
  String get hustler => 'Hustler';

  @override
  String get supportAndActions => 'Support & Actions';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get setswana => 'Setswana';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get getHelpAndSendFeedback => 'Get help and send feedback';

  @override
  String get addBio => 'Add bio';

  @override
  String get profileCompletion => 'Profile Completion';

  @override
  String get yourProfileIsComplete => 'Your profile is complete! 🎉';

  @override
  String get almostThere => 'Almost there! Just a few more details.';

  @override
  String get goodProgress => 'Good progress! Add more info to stand out.';

  @override
  String get completeYourProfileToAttractMoreOpportunities =>
      'Complete your profile to attract more opportunities.';

  @override
  String get completeProfile => 'Complete Profile';

  @override
  String get save => 'Save';

  @override
  String failedToPickImage(Object error) {
    return 'Failed to pick image: $error';
  }

  @override
  String failedToPickFiles(Object error) {
    return 'Failed to pick files: $error';
  }

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully!';

  @override
  String failedToUpdateProfile(Object error) {
    return 'Failed to update profile: $error';
  }

  @override
  String get changePhoto => 'Change Photo';

  @override
  String get addPhoto => 'Add Photo';

  @override
  String get basicInformation => 'Basic Information';

  @override
  String get nameIsRequired => 'Name is required';

  @override
  String get bio => 'Bio';

  @override
  String get tellOthersAboutYourself => 'Tell others about yourself...';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get cityState => 'City, State';

  @override
  String get professionalInformation => 'Professional Information';

  @override
  String get skillsHint => 'Web Development, Mobile Apps, Design, etc.';

  @override
  String get pleaseAddAtLeastOneSkill => 'Please add at least one skill';

  @override
  String get separateSkillsWithCommas => 'Separate skills with commas';

  @override
  String get experienceHint =>
      'Describe your work experience, projects, or achievements...';

  @override
  String get certifications => 'Certifications';

  @override
  String get uploadCertificates =>
      'Upload your certificates, diplomas, or other qualification documents (PDF, DOC, DOCX)';

  @override
  String get uploaded => 'Uploaded';

  @override
  String get readyToUpload => 'Ready to upload';

  @override
  String get addCertifications => 'Add Certifications';

  @override
  String get jobDetails => 'Job Details';

  @override
  String get jobNotFound => 'Job not found';

  @override
  String get applicationSubmittedSuccessfully =>
      'Application submitted successfully!';

  @override
  String get aboutThisJob => 'About this job';

  @override
  String get requiredSkills => 'Required Skills';

  @override
  String get details => 'Details';

  @override
  String get posted => 'Posted';

  @override
  String get deadline => 'Deadline';

  @override
  String get applyForThisJob => 'Apply for this job';

  @override
  String get writeACoverLetter => 'Write a cover letter (optional)';

  @override
  String get alreadyApplied => 'Already Applied';

  @override
  String get applyNow => 'Apply Now';

  @override
  String get myJobs => 'My Jobs';

  @override
  String welcome(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get postedJobs => 'Posted Jobs';

  @override
  String get noJobsPostedYet => 'No jobs posted yet';

  @override
  String get createYourFirstJobPosting =>
      'Create your first job posting to find talent';

  @override
  String get postAJob => 'Post a Job';

  @override
  String get active => 'Active';

  @override
  String get closed => 'Closed';

  @override
  String get draft => 'Draft';

  @override
  String get postNewJob => 'Post New Job';

  @override
  String get postYourFirstJob =>
      'Post your first job to start finding hustlers';

  @override
  String get viewApplications => 'View Applications';

  @override
  String get editJob => 'Edit Job';

  @override
  String get closeJob => 'Close Job';

  @override
  String get reopenJob => 'Reopen Job';

  @override
  String get deleteJob => 'Delete Job';

  @override
  String areYouSureYouWantToDelete(Object jobTitle) {
    return 'Are you sure you want to delete \"$jobTitle\"? This action cannot be undone.';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get jobDeletedSuccessfully => 'Job deleted successfully';

  @override
  String errorDeletingJob(Object error) {
    return 'Error deleting job: $error';
  }

  @override
  String get jobApplications => 'Job Applications';

  @override
  String get createPostingTitle => 'Create a new job posting';

  @override
  String get updatePostingTitle => 'Update your job posting';

  @override
  String get createPostingSubtitle =>
      'Fill in the details to attract the right talent';

  @override
  String get updatePostingSubtitle => 'Modify the fields you want to update';

  @override
  String get jobDescription => 'Job Description';

  @override
  String get compensation => 'Compensation (\$A)';

  @override
  String get jobTitleHint => 'e.g. Senior Flutter Developer';

  @override
  String get jobDescriptionHint => 'Tell us about this job...';

  @override
  String get compensationHint => '5000';

  @override
  String get locationHint => 'Remote, New York, etc.';

  @override
  String get descriptionSubtitle =>
      'Describe the role, responsibilities, and requirements';

  @override
  String get jobTitleRequired => 'Please enter a job title';

  @override
  String get jobDescriptionRequired => 'Please enter a job description';

  @override
  String get jobDescriptionTooShort =>
      'Description should be at least 50 characters';

  @override
  String get skillsRequired => 'Please enter required skills';

  @override
  String get compensationRequired => 'Please enter compensation';

  @override
  String get invalidAmount => 'Enter a valid amount';

  @override
  String get postJobButton => 'Post Job';

  @override
  String get saveChangesButton => 'Save Changes';

  @override
  String get savedMessage => 'Saved!';

  @override
  String get website => 'Website';

  @override
  String get addWebsite => 'Add website';

  @override
  String get aboutCompany => 'About Company';

  @override
  String get addAShortDescriptionAboutYourCompany =>
      'Add a short description about your company';

  @override
  String get employer => 'Employer';

  @override
  String get yourCompanyProfileIsComplete =>
      'Your company profile is complete!';

  @override
  String get almostThereCompany => 'Almost there! Add the remaining details.';

  @override
  String get goodProgressCompany => 'Good progress! Add more company info.';

  @override
  String get completeYourCompanyProfileToBuildTrust =>
      'Complete your company profile to build trust with hustlers.';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get companyName => 'Company Name';

  @override
  String get companyNameIsRequired => 'Company name is required';

  @override
  String get companyDescription => 'Company Description';

  @override
  String get describeYourCompany =>
      'Describe your company, mission, and values...';

  @override
  String total(Object count) {
    return '$count total';
  }

  @override
  String get subscriptions => 'Subscriptions';

  @override
  String get chooseYourPlan => 'Choose Your Plan';

  @override
  String get unlockFullPotential =>
      'Unlock your full potential with our premium features.';

  @override
  String get freePlan => 'Free Plan';

  @override
  String get viewFiveJobs => 'View up to 5 latest job postings';

  @override
  String get postThreeJobs => 'Post up to 3 jobs for free';

  @override
  String get premiumPlan => 'Premium Plan';

  @override
  String get unlimitedJobPostings => 'Unlimited job postings';

  @override
  String get unlimitedJobViews => 'Unlimited job views';

  @override
  String get prioritySupport => 'Priority support';

  @override
  String get currentPlan => 'Current Plan';

  @override
  String get subscribe => 'Subscribe';

  @override
  String get subscriptionSuccessful => 'Subscription successful!';

  @override
  String get authUserDisabled => 'This account has been disabled.';

  @override
  String get authWrongPassword => 'Incorrect password.';

  @override
  String get authEmailInUse => 'Email already in use.';

  @override
  String get authNetworkError => 'Network error. Please check your connection.';

  @override
  String get authTooManyRequests =>
      'Too many attempts. Please try again later.';

  @override
  String get authOpNotAllowed => 'This sign-in method is not enabled.';

  @override
  String get authGeneric => 'Authentication failed. Please try again.';

  @override
  String get authPasswordResetFailed =>
      'Password reset failed. Please try again.';
}
