import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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
    final authErrorText = useState<String?>(null);
    final isSent = useState(false);

    final authController = ref.read(authControllerProvider.notifier);
    final authControllerMutation = ref.watch(authControllerProvider);

    // Handle auth state changes for password reset
    useEffect(() {
      void handleAuthState() {
        authControllerMutation.map(
          idle: () => null,
          loading: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SmartDialog.showLoading(
                msg: 'Sending password reset email...',
                maskColor: Colors.black54,
              );
            });
            return null;
          },
          error: (error, _) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              SmartDialog.dismiss();
              debugPrint('Password reset error: ${error.toString()}');
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
              isSent.value = true;
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              SmartDialog.showToast('Password reset email sent successfully!');
            });
            return null;
          },
        );
      }

      handleAuthState();
      return null;
    }, [authControllerMutation]);

    Future<void> sendReset() async {
      final email = emailController.text.trim();
      final error = emailValidator(email);
      if (error != null) {
        emailErrorText.value = error;
        return;
      }
      emailErrorText.value = null;
      authErrorText.value = null; // Clear any auth errors

      FocusScope.of(context).unfocus();
      await authController.resetPassword(email);
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
                  // Show auth error container if there's an error
                  if (authErrorText.value != null)
                    ErrorContainer(
                      errorMessage: authErrorText.value!,
                      onDismiss: () => authErrorText.value = null,
                    ),
                  ElevatedButton(
                    onPressed: authControllerMutation.isLoading
                        ? null
                        : sendReset,
                    child: Text(AppStringsAuth.resetPasswordButton),
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
