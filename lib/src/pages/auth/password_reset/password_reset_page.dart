import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

class PasswordResetPage extends HookConsumerWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final emailController = useTextEditingController();
    final emailErrorText = useState<String?>(null);
    final isLoading = useState(false);
    final isSent = useState(false);

    final authController = ref.read(authControllerProvider.notifier);
    void sendReset() async {
      final email = emailController.text.trim();
      final error = emailValidator(email);
      if (error != null) {
        emailErrorText.value = error;
        return;
      }
      emailErrorText.value = null;
      isLoading.value = true;
      try {
        await authController.resetPassword(email);
        isSent.value = true;
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent!')),
        );
      } catch (e) {
        emailErrorText.value = e.toString();
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // Page 1: Enter email
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStringsAuth.resetPassword,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    AppStringsAuth.resetPasswordSubtitle,
                    style: TextStyle(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: AppStringsAuth.emailLabel,
                      border: const OutlineInputBorder(),
                      errorText: emailErrorText.value,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  ElevatedButton(
                    onPressed: isLoading.value ? null : sendReset,
                    child: isLoading.value
                        ? const CircularProgressIndicator.adaptive()
                        : Text(AppStringsAuth.resetPasswordButton),
                  ),
                ],
              ),
            ),
            // Page 2: Confirmation/other actions
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 60),
                  SizedBox(height: 2.h),
                  Text(
                    'Check your email for a password reset link.',
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  ElevatedButton(
                    onPressed: () {
                      // Use go_router to navigate to login page
                      context.goNamed(AppRoutes.loginRoute);
                    },
                    child: const Text('Back to Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
