// Strings for the Post Job page
class PostJobStrings {
  // Titles
  static const String postJobTitle = 'Post a Job';
  static const String editJobTitle = 'Edit Job';
  static const String createPostingTitle = 'Create a new job posting';
  static const String updatePostingTitle = 'Update your job posting';

  // Subtitles
  static const String createPostingSubtitle =
      'Fill in the details to attract the right talent';
  static const String updatePostingSubtitle =
      'Modify the fields you want to update';

  // Form Fields
  static const String jobTitle = 'Job Title';
  static const String jobDescription = 'Job Description';
  static const String requiredSkills = 'Required Skills';
  static const String compensation = 'Compensation (\$A)';
  static const String location = 'Location (Optional)';

  // Form Hints
  static const String jobTitleHint = 'e.g. Senior Flutter Developer';
  static const String jobDescriptionHint = 'Tell us about this job...';
  static const String skillsHint = 'Flutter, Dart, Firebase, REST APIs';
  static const String compensationHint = '5000';
  static const String locationHint = 'Remote, New York, etc.';
  static const String skillsSubtitle =
      'Enter skills separated by commas (e.g. Flutter, Dart, Firebase)';
  static const String descriptionSubtitle =
      'Describe the role, responsibilities, and requirements';

  // Validation Messages
  static const String jobTitleRequired = 'Please enter a job title';
  static const String jobDescriptionRequired = 'Please enter a job description';
  static const String jobDescriptionTooShort =
      'Description should be at least 50 characters';
  static const String skillsRequired = 'Please enter required skills';
  static const String compensationRequired = 'Please enter compensation';
  static const String invalidAmount = 'Enter a valid amount';

  // Buttons
  static const String postJobButton = 'Post Job';
  static const String saveChangesButton = 'Save Changes';

  // Messages
  static const String profileNotFound = 'Profile not found';
  static const String savedMessage = 'Saved!';
  static const String errorLoadingProfile = 'Error loading profile: ';
}
