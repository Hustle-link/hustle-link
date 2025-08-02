import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends HookConsumerWidget {
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

    // focus nodes
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final confirmPasswordFocusNode = useFocusNode();

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
              SizedBox(height: 2.h),
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
                  errorText: emailErrorText.value, // will be set dynamically
                ),
              ),
              SizedBox(height: 1.h),
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
                  }
                },
                decoration: InputDecoration(
                  labelText: AppStringsAuth.passwordLabel,
                  errorText: passwordErrorText.value, // will be set dynamically
                ),
                obscureText: true,
              ),
              SizedBox(height: 1.h),
              TextField(
                controller: confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                focusNode: confirmPasswordFocusNode,
                decoration: const InputDecoration(
                  labelText: AppStringsAuth.confirmPasswordLabel,
                ),
                obscureText: true,
              ),
              SizedBox(height: 3.h),
              // show error message if passwords do not match
              // show only if the form is not empty
              if (confirmPasswordController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  confirmPasswordValidator(
                        confirmPasswordController.text.trim(),
                        passwordController.text.trim(),
                      ) !=
                      null)
                Text(
                  AppStringsAuth.passwordsDoNotMatch,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              // if (confirmPasswordValidator(
              //       passwordController.text.trim(),
              //       confirmPasswordController.text.trim(),
              //     ) !=
              //     null)
              //   Text(
              //     AppStringsAuth.passwordsDoNotMatch,
              //     style: TextStyle(color: Theme.of(context).colorScheme.error),
              //   ),
              // register button
              // make button to be disabled if email or password is empty
              ElevatedButton(
                onPressed:
                    emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty
                    ? null
                    : () async {
                        try {
                          // call register legacy method from auth controller (without role)
                          await authController.registerLegacy(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );

                          // Navigate to role selection page on successful registration
                          if (context.mounted) {
                            context.go(AppRoutes.roleSelection);
                          }
                        } catch (e) {
                          // Error handling is done by the auth controller
                          debugPrint('Registration failed: $e');
                        }

                        // clear the text fields after registration attempt
                        emailController.clear();
                        passwordController.clear();
                        confirmPasswordController.clear();
                      },
                child: authControllerMutation.map(
                  idle: () {
                    return const Text(AppStringsAuth.registerButton);
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                  error: (error, _) {
                    return Text('Error: $error');
                  },
                  data: (data) {
                    return const Text(AppStringsAuth.registerButton);
                  },
                ),
              ),
              SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  // set allow navigation to login page
                  ref
                      .read(allowNavToRegisterProvider.notifier)
                      .disallowNavigation();
                  // navigate to login page
                  context.goNamed(AppRoutes.loginRoute);
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
