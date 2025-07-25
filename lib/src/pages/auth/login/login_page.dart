import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

    // focus nodes
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    // listen to controller state
    ref.listen<AsyncValue>(authControllerProvider, (previous, state) {
      if (state.isLoading && !state.hasError) {
        // show loading indicator
        showDialog(
          context: context,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
        return;
      } else if (state.hasError) {
        // show error message
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${state.error}')));
      }
    });

    return Scaffold(
      // automatically implyleading padding if navigating from another page
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // title: Text(AppStringsAuth.loginTitle),
        automaticallyImplyLeading: true,
      ),
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
              SizedBox(height: 10.h),
              // image
              SvgPicture.asset('assets/images/auth/register.svg', height: 20.h),
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
                decoration: InputDecoration(
                  labelText: AppStringsAuth.emailLabel,
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 3.h),
              TextField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: AppStringsAuth.passwordLabel,
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 0.2.h),
              // forgot password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // navigate to forgot password page
                    context.pushNamed(
                      // AppRoutes.resetPassword,
                      //TODO: Implement reset password page
                      'reset-password',
                    );
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
              ElevatedButton(
                onPressed: () async {
                  // call signIn method from auth controller
                  await authController.signIn(
                    emailController.text,
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
                    AppStringsAuth.alreadyHaveAccount,
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
