import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hustle_link/src/pages/auth/controllers/auth_controller.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import '../../../shared/routing/app_router.dart';
// Removed direct FirebaseAuth import (handled via auth service mapping)
import 'package:hustle_link/src/shared/utils/auth_error_mapper.dart';
import 'package:hustle_link/src/shared/utils/user_friendly_exception.dart';
import 'package:hustle_link/src/shared/analytics/auth_error_logger.dart';

class PasswordResetPage extends HookConsumerWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();

    final isLoading = useState(false);
    final errorText = useState<String?>(null);
    final sent = useState(false);
    final resendIn = useState(0);
    final timerRef = useRef<Timer?>(null);
    final successIconCtrl = useAnimationController(duration: 400.ms);

    // Watch the auth controller state to show loading indicator
    final authState = ref.watch(authControllerProvider);

    // Update loading state when auth state changes
    useEffect(() {
      isLoading.value = authState.isLoading;
      return null;
    }, [authState.isLoading]);

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
      return () => timerRef.value?.cancel();
    }, [sent.value, resendIn.value]);

    useEffect(() {
      if (sent.value) {
        successIconCtrl.forward(from: 0);
      } else {
        successIconCtrl.reset();
      }
      return null;
    }, [sent.value]);

    useListenable(emailController);
    final isEmailValid = RegExp(
      r'^[^@]+@[^@]+\.[^@]+',
    ).hasMatch(emailController.text.trim());

    Future<void> onSubmit() async {
      if (formKey.currentState?.validate() != true) return;

      await ref
          .read(authControllerProvider.notifier)
          .resetPassword(
            emailController.text.trim(),
            onSuccess: (_) async {
              // Show success state
              sent.value = true;
              errorText.value = null;
              resendIn.value = 30;

              // Show success snackbar
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.passwordResetLinkSent(
                              emailController.text.trim(),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 4),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            onError: (error) async {
              // Handle errors with user-friendly messages
              String friendlyMessage;
              String code;

              if (error is UserFriendlyException) {
                code = error.code ?? error.message;
                friendlyMessage = localizeAuthError(context, code);
              } else if (error != null) {
                code = mapAuthErrorKey(error);
                friendlyMessage = localizeAuthError(context, code);
              } else {
                code = 'unknown_error';
                friendlyMessage = l10n.unexpectedError;
              }

              errorText.value = friendlyMessage;
              _logAuthError(ref, code);

              // Show error snackbar
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.white),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            friendlyMessage,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Theme.of(context).colorScheme.error,
                    duration: const Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.passwordResetTitle),
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
                                          onSuccess: (_) async {
                                            resendIn.value = 30;
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.refresh,
                                                        color: Colors.white,
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                        child: Text(
                                                          l10n.passwordResetLinkSentAgain,
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  backgroundColor: Colors.green,
                                                  duration: const Duration(
                                                    seconds: 3,
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                          },
                                          onError: (error) async {
                                            String friendlyMessage =
                                                error is UserFriendlyException
                                                ? localizeAuthError(
                                                    context,
                                                    error.code ?? error.message,
                                                  )
                                                : l10n.failedToResend;

                                            if (context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.error_outline,
                                                        color: Colors.white,
                                                      ),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                        child: Text(
                                                          friendlyMessage,
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  backgroundColor: Theme.of(
                                                    context,
                                                  ).colorScheme.error,
                                                  duration: const Duration(
                                                    seconds: 4,
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                            }
                                          },
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

void _logAuthError(WidgetRef ref, String code) {
  ref.read(authErrorAnalyticsLoggerProvider).log(code);
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
    final l10n = AppLocalizations.of(context);
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
            l10n.passwordResetSubTitle,
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
                  decoration: InputDecoration(
                    labelText: l10n.emailHint,
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: const OutlineInputBorder(),
                    helperText: l10n.didNotGetEmail,
                  ),
                  validator: (value) {
                    final v = (value ?? '').trim();
                    if (v.isEmpty) return l10n.emailRequired;
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                      return l10n.invalidEmail;
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
                      ).colorScheme.error.withValues(alpha: 0.08),
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
                    label: Text(l10n.sendButtonText),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                TextButton(
                  onPressed: onBackToLogin,
                  child: Text(l10n.backToLogin),
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
    final l10n = AppLocalizations.of(context);
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
            l10n.checkYourEmail,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            l10n.passwordResetLinkSent(email),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onBackToLogin,
              child: Text(l10n.backToLogin),
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
                      ? l10n.resendLink
                      : l10n.resendAvailableIn(resendIn.toString()),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            l10n.didNotGetEmail,
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
