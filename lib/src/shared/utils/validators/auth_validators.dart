// email validator
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Invalid email format';
  }
  return null;
}

// password validator
String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

// confirm password validator
String? confirmPasswordValidator(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return 'Confirm password cannot be empty';
  }
  if (value != password) {
    return 'Passwords do not match';
  }
  return null;
}

// email and password validator for login
String? loginEmailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Invalid email format';
  }
  return null;
}

String? loginPasswordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

// form validator for registration
String? registrationFormValidator(
  String? email,
  String? password,
  String? confirmPassword,
) {
  final emailError = emailValidator(email);
  if (emailError != null) {
    return emailError;
  }

  final passwordError = passwordValidator(password);
  if (passwordError != null) {
    return passwordError;
  }

  final confirmPasswordError = confirmPasswordValidator(
    confirmPassword,
    password,
  );
  if (confirmPasswordError != null) {
    return confirmPasswordError;
  }

  return null;
}
