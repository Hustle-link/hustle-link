import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hustle_link/src/pages/auth/controllers/auth_controller.dart';
import 'package:hustle_link/src/shared/utils/strings/reset_password_strings.dart';
import 'package:sizer/sizer.dart';
import '../../../shared/routing/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordResetPage extends HookConsumerWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controllers & state via hooks
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();

    final isLoading = useState(false);
    final errorText = useState<String?>(null);
    final sent = useState(false);
    final resendIn = useState(0);
    final timerRef = useRef<Timer?>(null);
    final successIconCtrl = useAnimationController(duration: 400.ms);

    // Helper to normalize error messages from controller
    String friendlyError(Object err) {
      if (err is UserFriendlyException) return err.message;
      if (err is FirebaseAuthException) {
        return err.message ?? 'Authentication error';
      }
      final s = err.toString();
      return s.startsWith('Exception: ')
          ? s.substring('Exception: '.length)
          : s;
    }

    // Listen to auth controller updates
    ref.listen(authControllerProvider, (prev, state) {
      state.when(
        loading: () {
          isLoading.value = true;
          errorText.value = null;
          return null;
        },
        data: (_) {
          isLoading.value = false;
          sent.value = true;
          errorText.value = null;
          resendIn.value = 30; // start cooldown
          return null;
        },
        error: (error, __) {
          isLoading.value = false;
          debugPrint('Password reset error: ${friendlyError(error)}');
          errorText.value = friendlyError(error);
          return null;
        },
      );
    });

    // Cooldown timer lifecycle
    useEffect(() {
      if (sent.value && resendIn.value > 0 && timerRef.value == null) {
        timerRef.value = Timer.periodic(const Duration(seconds: 1), (t) {
          if (resendIn.value <= 1) {
            resendIn.value = 0;
            t.cancel();
            timerRef.value = null;
          } else {
            resendIn.value = resendIn.value - 1;
          }
        });
      }
      return () {
        timerRef.value?.cancel();
        timerRef.value = null;
      };
      // Trigger when sent/resendIn changes
    }, [sent.value, resendIn.value]);

    // Kick success icon animation when sent becomes true
    useEffect(() {
      if (sent.value) {
        successIconCtrl.forward(from: 0);
      } else {
        successIconCtrl.reset();
      }
      return null;
    }, [sent.value]);

    // Rebuild when email text changes, then compute validity
    useListenable(emailController);
    final isEmailValid = RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    ).hasMatch(emailController.text.trim());

    Future<void> onSubmit() async {
      if (formKey.currentState?.validate() != true) return;
      await ref
          .read(authControllerProvider.notifier)
          .resetPassword(emailController.text.trim());
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(ResetPasswordStrings.title),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child:
              AnimatedSwitcher(
                    duration: 400.ms,
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    child: sent.value
                        ? _SuccessView(
                            email: emailController.text.trim(),
                            resendIn: resendIn.value,
                            onBackToLogin: () =>
                                context.goNamed(AppRoutes.loginRoute),
                            onResend: resendIn.value == 0
                                ? () async {
                                    await ref
                                        .read(authControllerProvider.notifier)
                                        .resetPassword(
                                          emailController.text.trim(),
                                        );
                                  }
                                : null,
                            iconController: successIconCtrl,
                          )
                        : _FormView(
                            formKey: formKey,
                            emailController: emailController,
                            isLoading: isLoading.value,
                            errorText: errorText.value,
                            isEmailValid: isEmailValid,
                            onSubmit: onSubmit,
                            onBackToLogin: isLoading.value
                                ? null
                                : () => context.goNamed(AppRoutes.loginRoute),
                          ),
                  )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .moveY(begin: 12, end: 0, curve: Curves.easeOutCubic),
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool isLoading;
  final String? errorText;
  final bool isEmailValid;
  final Future<void> Function() onSubmit;
  final VoidCallback? onBackToLogin;

  const _FormView({
    required this.formKey,
    required this.emailController,
    required this.isLoading,
    required this.errorText,
    required this.isEmailValid,
    required this.onSubmit,
    required this.onBackToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: const ValueKey('form'),
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            'assets/images/auth/login.svg',
            height: 22.h,
          ).animate().fadeIn(duration: 500.ms).moveY(begin: 16, end: 0),
          SizedBox(height: 3.h),
          Text(
            ResetPasswordStrings.subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 400.ms, delay: 100.ms),
          SizedBox(height: 3.h),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: ResetPasswordStrings.emailHint,
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    helperText:
                        'We\'ll send a link if an account exists for this email.',
                  ),
                  validator: (value) {
                    final v = (value ?? '').trim();
                    if (v.isEmpty) return 'Please enter your email';
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                if (errorText != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.error.withOpacity(0.08),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            errorText!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 250.ms).moveY(begin: 6, end: 0),
                SizedBox(height: 2.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: isLoading || !isEmailValid ? null : onSubmit,
                    icon: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send_outlined),
                    label: const Text(ResetPasswordStrings.sendButtonText),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                TextButton(
                  onPressed: onBackToLogin,
                  child: const Text(ResetPasswordStrings.backToLogin),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final String email;
  final int resendIn;
  final VoidCallback onBackToLogin;
  final VoidCallback? onResend;
  final AnimationController iconController;

  const _SuccessView({
    required this.email,
    required this.resendIn,
    required this.onBackToLogin,
    required this.onResend,
    required this.iconController,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: const ValueKey('success'),
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 2.h),
          Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mark_email_read_outlined,
                  size: 48,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              )
              .animate(controller: iconController)
              .scale(duration: 400.ms, curve: Curves.easeOutBack),
          SizedBox(height: 2.h),
          Text(
            'Check your email',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'We\'ve sent a password reset link to:\n$email',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onBackToLogin,
              child: const Text('Back to Login'),
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: onResend,
                icon: const Icon(Icons.refresh),
                label: Text(
                  resendIn == 0
                      ? 'Resend link'
                      : 'Resend available in $resendIn s',
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'Didn\'t get the email? Check your spam folder or try again.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
