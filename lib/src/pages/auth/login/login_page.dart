import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// Removed unused flutter_smart_dialog import after refactor
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:hustle_link/src/shared/utils/auth_error_mapper.dart';
import 'package:hustle_link/src/shared/utils/user_friendly_exception.dart';
import 'package:hustle_link/src/shared/analytics/auth_error_logger.dart';

/// A screen for users to log in to their account.
///
/// This page provides fields for email and password, a login button, and links
/// for password recovery and registration. It's built with a responsive layout
/// and uses Riverpod for state management.
class LoginPage extends HookConsumerWidget {
  /// Creates an instance of [LoginPage].
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Controllers for the form fields.
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // State for managing form validation errors.
    final emailError = useState<String?>(null);
    final passwordError = useState<String?>(null);
    final authError = useState<String?>(null);

    // Listen to the authentication state to handle loading, errors, and success.
    ref.listen<AsyncValue<void>>(authControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (_) {
          authError.value = null;
          context.goNamed(AppRoutes.homeRoute);
        },
        error: (e, _) {
          if (e is UserFriendlyException) {
            final key = e.code ?? e.message;
            authError.value = localizeAuthError(context, key);
            _logAuthError(ref, key);
          } else {
            final key = mapAuthErrorKey(e);
            authError.value = localizeAuthError(context, key);
            _logAuthError(ref, key);
          }
        },
      );
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context),
                    SizedBox(height: 5.h),
                    Text(
                      l10n.loginTitle,
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      l10n.loginSubtitle,
                      style: textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    _buildLoginForm(
                      context: context,
                      ref: ref,
                      emailController: emailController,
                      passwordController: passwordController,
                      emailError: emailError,
                      passwordError: passwordError,
                      authError: authError,
                      isLoading: isLoading,
                    ),
                    SizedBox(height: 2.h),
                    _buildFooter(context, ref),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withAlpha(120),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Builds the header section with the app logo.
  Widget _buildHeader(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/auth/login.svg',
      height: 20.h,
      placeholderBuilder: (context) => SizedBox(height: 20.h),
    );
  }

  /// Builds the login form with email, password, and submission button.
  Widget _buildLoginForm({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required ValueNotifier<String?> emailError,
    required ValueNotifier<String?> passwordError,
    required ValueNotifier<String?> authError,
    required bool isLoading,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          enabled: !isLoading,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).emailLabel,
            errorText: emailError.value,
          ),
          onChanged: (_) => emailError.value = null,
        ),
        SizedBox(height: 2.h),
        TextField(
          controller: passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          enabled: !isLoading,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).passwordLabel,
            errorText: passwordError.value,
          ),
          onChanged: (_) => passwordError.value = null,
        ),
        SizedBox(height: 1.h),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => context.pushNamed(AppRoutes.resetPasswordRoute),
            child: Text(AppLocalizations.of(context).forgotPassword),
          ),
        ),
        if (authError.value != null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: ErrorContainer(
              errorMessage: authError.value!,
              onDismiss: () => authError.value = null,
            ),
          ),
        SizedBox(height: 2.h),
        ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  // Clear previous errors
                  authError.value = null;

                  // Validate fields
                  final email = emailController.text;
                  final password = passwordController.text;
                  final emailValidationError = emailValidator(email);
                  final passwordValidationError = loginPasswordValidator(
                    password,
                  );

                  if (emailValidationError != null ||
                      passwordValidationError != null) {
                    emailError.value = emailValidationError;
                    passwordError.value = passwordValidationError;
                    return;
                  }

                  FocusScope.of(context).unfocus();
                  ref
                      .read(authControllerProvider.notifier)
                      .signIn(email, password);
                },
          child: Text(
            AppLocalizations.of(context).signIn,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the footer section with the link to the registration page.
  Widget _buildFooter(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.noAccount),
        TextButton(
          onPressed: () {
            // Direct navigation (removed obsolete allowNavToRegisterProvider usage).
            context.goNamed(AppRoutes.registerRoute);
          },
          child: Text(l10n.createAccount),
        ),
      ],
    );
  }
}

void _logAuthError(WidgetRef ref, String code) {
  ref.read(authErrorAnalyticsLoggerProvider).log(code);
}
