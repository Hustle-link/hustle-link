import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

/// A widget that provides the user interface for the registration screen.
///
/// This widget includes text fields for email, password, and password confirmation,
/// a registration button, and a link to the login page. It uses hooks for managing
/// state and controllers.
/// TODO(validation): Implement more robust real-time validation feedback for the input fields.
class RegisterPage extends HookConsumerWidget {
  /// Creates a new instance of [RegisterPage].
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // use text controllers for email and password
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    // use auth controller
    final authController = ref.read(authControllerProvider.notifier);
    final authControllerMutation = ref.watch(authControllerProvider);

    // error texts
    final emailErrorText = useState<String?>(null);
    final passwordErrorText = useState<String?>(null);
    final confirmPasswordErrorText = useState<String?>(null);
    final authErrorText = useState<String?>(null);

    // focus nodes
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final confirmPasswordFocusNode = useFocusNode();

    // Handle auth state changes using ref.listen instead of useEffect
    // This listener manages the state of the registration process, showing
    // loading indicators, handling errors, and navigating on success.
    ref.listen(authControllerProvider, (prev, next) {
      next.map(
        idle: () => null,
        loading: () {
          SmartDialog.showLoading(
            msg: AppStringsAuth.registrationLoadingMessage,
            maskColor: Colors.black54,
          );
          return null;
        },
        error: (error, _) {
          SmartDialog.dismiss();
          debugPrint(
            'Registration error on register page: ${error.toString()}',
          );
          final cleanError = error.toString().replaceAll('Exception: ', '');
          authErrorText.value = cleanError;
          return null;
        },
        data: (_) {
          SmartDialog.dismiss();
          authErrorText.value = null; // Clear any errors
          context.go(AppRoutes.roleSelection);
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          return null;
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        // title: const Text('Register'),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 4.w,
          right: 4.w,
          top: 2.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16, // <-- Add this
        ),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 4.h),
              SvgPicture.asset('assets/images/auth/register.svg', height: 20.h),
              SizedBox(height: 2.h),
              const Text(
                AppStringsAuth.registerTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              // subtitle
              const Text(
                AppStringsAuth.registerSubtitle,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 4.h),
              // input fields
              TextField(
                controller: emailController,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                // validation for email
                onTapOutside: (event) {
                  if (emailFocusNode.hasFocus) {
                    // validate email format
                    final emailError = emailValidator(emailController.text);
                    if (emailError != null) {
                      emailErrorText.value = emailError;
                    } else {
                      emailErrorText.value = null; // clear error if valid
                    }
                  }
                  // unfocus the text field
                  emailFocusNode.unfocus();
                },
                onChanged: (value) {
                  if (emailFocusNode.hasFocus) {
                    // validate email format
                    final emailError = emailValidator(value);
                    if (emailError != null) {
                      emailErrorText.value = emailError;
                    } else {
                      emailErrorText.value = null; // clear error if valid
                    }
                  }
                },
                decoration: InputDecoration(
                  labelText: AppStringsAuth.emailLabel,
                  border: const OutlineInputBorder(),
                  errorText: emailErrorText.value, // will be set dynamically
                ),
              ),
              SizedBox(height: 3.h),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                focusNode: passwordFocusNode,
                textInputAction: TextInputAction.next,
                // validation for password
                onTapOutside: (event) {
                  if (passwordFocusNode.hasFocus) {
                    // validate password
                    final passwordError = passwordValidator(
                      passwordController.text,
                    );
                    if (passwordError != null) {
                      passwordErrorText.value = passwordError;
                    } else {
                      passwordErrorText.value = null; // clear error if valid
                    }

                    // Also validate confirm password if it has content
                    if (confirmPasswordController.text.isNotEmpty) {
                      final confirmError = confirmPasswordValidator(
                        confirmPasswordController.text,
                        passwordController.text,
                      );
                      if (confirmError != null) {
                        confirmPasswordErrorText.value = confirmError;
                      } else {
                        confirmPasswordErrorText.value = null;
                      }
                    }
                  }
                  // unfocus the text field
                  passwordFocusNode.unfocus();
                },
                onChanged: (value) {
                  if (passwordFocusNode.hasFocus) {
                    // validate password
                    final passwordError = passwordValidator(value);
                    if (passwordError != null) {
                      passwordErrorText.value = passwordError;
                    } else {
                      passwordErrorText.value = null; // clear error if valid
                    }

                    // Also validate confirm password if it has content
                    if (confirmPasswordController.text.isNotEmpty) {
                      final confirmError = confirmPasswordValidator(
                        confirmPasswordController.text,
                        value,
                      );
                      if (confirmError != null) {
                        confirmPasswordErrorText.value = confirmError;
                      } else {
                        confirmPasswordErrorText.value = null;
                      }
                    }
                  }
                },
                decoration: InputDecoration(
                  labelText: AppStringsAuth.passwordLabel,
                  border: const OutlineInputBorder(),
                  errorText: passwordErrorText.value, // will be set dynamically
                ),
                obscureText: true,
              ),
              SizedBox(height: 3.h),
              TextField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                focusNode: confirmPasswordFocusNode,
                textInputAction: TextInputAction.done,
                // validation for confirm password
                onTapOutside: (event) {
                  if (confirmPasswordFocusNode.hasFocus) {
                    // validate confirm password
                    final confirmError = confirmPasswordValidator(
                      confirmPasswordController.text,
                      passwordController.text,
                    );
                    if (confirmError != null) {
                      confirmPasswordErrorText.value = confirmError;
                    } else {
                      confirmPasswordErrorText.value =
                          null; // clear error if valid
                    }
                  }
                  // unfocus the text field
                  confirmPasswordFocusNode.unfocus();
                },
                onChanged: (value) {
                  if (confirmPasswordFocusNode.hasFocus) {
                    // validate confirm password
                    final confirmError = confirmPasswordValidator(
                      value,
                      passwordController.text,
                    );
                    if (confirmError != null) {
                      confirmPasswordErrorText.value = confirmError;
                    } else {
                      confirmPasswordErrorText.value =
                          null; // clear error if valid
                    }
                  }
                },
                decoration: InputDecoration(
                  labelText: AppStringsAuth.confirmPasswordLabel,
                  border: const OutlineInputBorder(),
                  errorText:
                      confirmPasswordErrorText.value, // will be set dynamically
                ),
                obscureText: true,
              ),
              SizedBox(height: 3.h),
              // Show auth error container if there's an error
              if (authErrorText.value != null)
                ErrorContainer(
                  errorMessage: authErrorText.value!,
                  onDismiss: () => authErrorText.value = null,
                ),
              // register button
              // make button to be disabled if email or password is empty or has validation errors
              ElevatedButton(
                onPressed:
                    emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty ||
                        emailErrorText.value != null ||
                        passwordErrorText.value != null ||
                        confirmPasswordErrorText.value != null ||
                        authControllerMutation.isLoading
                    ? null
                    : () async {
                        // Clear any existing error messages
                        emailErrorText.value = null;
                        passwordErrorText.value = null;
                        confirmPasswordErrorText.value = null;
                        authErrorText.value = null;

                        // Validate all fields before submission
                        final emailError = emailValidator(
                          emailController.text.trim(),
                        );
                        final passwordError = passwordValidator(
                          passwordController.text,
                        );
                        final confirmError = confirmPasswordValidator(
                          confirmPasswordController.text,
                          passwordController.text,
                        );

                        // Check for validation errors
                        if (emailError != null) {
                          emailErrorText.value = emailError;
                          return;
                        }
                        if (passwordError != null) {
                          passwordErrorText.value = passwordError;
                          return;
                        }
                        if (confirmError != null) {
                          confirmPasswordErrorText.value = confirmError;
                          return;
                        }

                        // Dismiss keyboard
                        FocusScope.of(context).unfocus();

                        // call register legacy method from auth controller (without role)
                        await authController.registerLegacy(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
                child: Text(
                  AppStringsAuth.registerButton,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              SizedBox(height: 2.h),

              // Login link styled consistently with login page
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStringsAuth.alreadyHaveAccount,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  SizedBox(width: 1.w),
                  TextButton(
                    onPressed: () {
                      // set allow navigation to login page
                      ref
                          .read(allowNavToRegisterProvider.notifier)
                          .disallowNavigation();
                      // navigate to login page
                      context.goNamed(AppRoutes.loginRoute);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      AppStringsAuth.loginButton,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
