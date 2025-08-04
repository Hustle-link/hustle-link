import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // use text controllers for email and password
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // use auth controller
    final authController = ref.read(authControllerProvider.notifier);
    final authControllerMutation = ref.watch(authControllerProvider);

    // focus nodes
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    // error texts
    final emailErrorText = useState<String?>(null);
    final passwordErrorText = useState<String?>(null);
    final authErrorText = useState<String?>(null);

    // Handle auth state changes
    useEffect(() {
      void handleAuthState() {
        authControllerMutation.map(
          idle: () => null,
          loading: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SmartDialog.showLoading(
                msg: AppStringsAuth.loadingMessage,
                maskColor: Colors.black54,
              );
            });
            return null;
          },
          error: (error, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SmartDialog.dismiss();
              debugPrint('Login error on login page: ${error.toString()}');
              // Clean up the error message by removing "Exception: " prefix
              final cleanError = error.toString().replaceAll('Exception: ', '');
              authErrorText.value = cleanError;
            });
            return null;
          },
          data: (_) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SmartDialog.dismiss();
              authErrorText.value = null; // Clear any errors
              context.goNamed(AppRoutes.homeRoute);
            });
            return null;
          },
        );
      }

      handleAuthState();
      return null;
    }, [authControllerMutation]);

    return Scaffold(
      // automatically implyleading padding if navigating from another page
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        // title: Text(AppStringsAuth.loginTitle),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 4.w,
          right: 4.w,
          // top: 2.h,
          // bottom: MediaQuery.of(context).viewInsets.bottom + 16, // <-- Add this
        ),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5.h),
              // image
              SvgPicture.asset('assets/images/auth/register.svg', height: 20.h),
              //todo:remove this
              TextButton(
                onPressed: () async {
                  await ref
                      .read(welcomePageSharedPreferencesProvider.notifier)
                      .setFirstTimeOpenApp(true);
                },
                child: Text('Debug: Welcome Page'),
              ),
              SizedBox(height: 5.h),
              // title and input fields
              Text(
                AppStringsAuth.loginTitle,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              Text(
                AppStringsAuth.loginSubtitle,

                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(context).textTheme.bodySmall?.backgroundColor,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 4.h),
              // email and password fields
              TextField(
                controller: emailController,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: AppStringsAuth.emailLabel,
                  border: OutlineInputBorder(),
                  errorText: emailErrorText.value,
                ),
                onTapOutside: (event) {
                  // validate email
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
                onEditingComplete: () {
                  // validate email when user finishes editing
                  final emailError = emailValidator(emailController.text);
                  if (emailError != null) {
                    emailErrorText.value = emailError;
                  } else {
                    emailErrorText.value = null; // clear error if valid
                  }
                  // move to password field
                  passwordFocusNode.requestFocus();
                },
              ),
              SizedBox(height: 3.h),
              TextField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: AppStringsAuth.passwordLabel,
                  border: OutlineInputBorder(),
                  errorText: passwordErrorText.value,
                ),
                obscureText: true,
                onTapOutside: (event) {
                  // validate password
                  if (passwordFocusNode.hasFocus) {
                    final passwordError = loginPasswordValidator(
                      passwordController.text,
                    );
                    if (passwordError != null) {
                      passwordErrorText.value = passwordError;
                    } else {
                      passwordErrorText.value = null;
                    }
                  }
                  passwordFocusNode.unfocus();
                },
                onEditingComplete: () {
                  // validate password when user finishes editing
                  final passwordError = loginPasswordValidator(
                    passwordController.text,
                  );
                  if (passwordError != null) {
                    passwordErrorText.value = passwordError;
                  } else {
                    passwordErrorText.value = null;
                  }
                  // unfocus when done
                  passwordFocusNode.unfocus();
                },
              ),
              SizedBox(height: 0.2.h),
              // forgot password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // navigate to forgot password page
                    context.pushNamed(AppRoutes.resetPasswordRoute);
                  },
                  child: Text(
                    AppStringsAuth.forgotPassword,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              // Show auth error container if there's an error
              if (authErrorText.value != null)
                ErrorContainer(
                  errorMessage: authErrorText.value!,
                  onDismiss: () => authErrorText.value = null,
                ),
              ElevatedButton(
                onPressed: authControllerMutation.isLoading
                    ? null
                    : () async {
                        // Clear any existing error messages
                        emailErrorText.value = null;
                        passwordErrorText.value = null;
                        authErrorText.value = null;

                        // Validate email
                        final emailError = emailValidator(emailController.text);
                        if (emailError != null) {
                          emailErrorText.value = emailError;
                          return;
                        }

                        // Validate password
                        final passwordError = loginPasswordValidator(
                          passwordController.text,
                        );
                        if (passwordError != null) {
                          passwordErrorText.value = passwordError;
                          return;
                        }

                        // Dismiss keyboard
                        FocusScope.of(context).unfocus();

                        // call signIn method from auth controller
                        await authController.signIn(
                          emailController.text.trim(),
                          passwordController.text,
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
                  AppStringsAuth.loginButton,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              // register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStringsAuth.noAccount,
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  SizedBox(width: 1.w),
                  TextButton(
                    onPressed: () {
                      // set allow navigation to register page
                      ref
                          .read(allowNavToRegisterProvider.notifier)
                          .allowNavigation();
                      // close the keyboard
                      FocusScope.of(context).unfocus();
                      // navigate to register page
                      context.goNamed(AppRoutes.registerRoute);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      AppStringsAuth.createAccount,
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
