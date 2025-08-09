import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

/// A screen for new users to create an account.
class RegisterPage extends HookConsumerWidget {
  /// Creates an instance of [RegisterPage].
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              SizedBox(height: 4.h),
              Text(
                l10n.registerTitle,
                style: textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1.h),
              Text(
                l10n.registerSubtitle,
                style: textTheme.titleMedium
                    ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
              ),
              SizedBox(height: 4.h),
              _RegisterForm(),
              SizedBox(height: 2.h),
              _buildFooter(context, ref, l10n),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the header section with the registration illustration.
  Widget _buildHeader(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/auth/register.svg',
      height: 20.h,
      placeholderBuilder: (context) => SizedBox(height: 20.h),
    );
  }

  /// Builds the footer section with a link to the login page.
  Widget _buildFooter(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.alreadyHaveAccount),
        TextButton(
          onPressed: () {
            ref.read(allowNavToRegisterProvider.notifier).disallowNavigation();
            context.goNamed(AppRoutes.loginRoute);
          },
          child: Text(l10n.signIn),
        ),
      ],
    );
  }
}

/// A form widget for user registration.
class _RegisterForm extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final emailError = useState<String?>(null);
    final passwordError = useState<String?>(null);
    final confirmPasswordError = useState<String?>(null);
    final authError = useState<String?>(null);

    final authState = ref.watch(authControllerProvider);

    ref.listen<Mutation<void, Map<String, String>>>(authControllerProvider, (prev, next) {
      next.map(
        idle: () => SmartDialog.dismiss(),
        loading: () => SmartDialog.showLoading(msg: l10n.registrationLoadingMessage),
        error: (e, _) {
          SmartDialog.dismiss();
          authError.value = e.toString().replaceFirst('Exception: ', '');
        },
        data: (_) {
          SmartDialog.dismiss();
          context.goNamed(AppRoutes.roleSelection);
        },
      );
    });

    void validate() {
      final email = emailController.text;
      final password = passwordController.text;
      final confirmPassword = confirmPasswordController.text;

      emailError.value = emailValidator(email);
      passwordError.value = passwordValidator(password);
      confirmPasswordError.value = confirmPasswordValidator(confirmPassword, password);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: l10n.emailLabel,
            errorText: emailError.value,
          ),
          onChanged: (_) => validate(),
        ),
        SizedBox(height: 2.h),
        TextField(
          controller: passwordController,
          obscureText: true,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: l10n.passwordLabel,
            errorText: passwordError.value,
          ),
          onChanged: (_) => validate(),
        ),
        SizedBox(height: 2.h),
        TextField(
          controller: confirmPasswordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: l10n.confirmPasswordLabel,
            errorText: confirmPasswordError.value,
          ),
          onChanged: (_) => validate(),
        ),
        if (authError.value != null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: ErrorContainer(
              errorMessage: authError.value!,
              onDismiss: () => authError.value = null,
            ),
          ),
        SizedBox(height: 4.h),
        ElevatedButton(
          onPressed: authState.isLoading
              ? null
              : () {
                  validate();
                  if (emailError.value == null &&
                      passwordError.value == null &&
                      confirmPasswordError.value == null) {
                    FocusScope.of(context).unfocus();
                    ref.read(authControllerProvider.notifier).registerLegacy(
                          emailController.text,
                          passwordController.text,
                        );
                  }
                },
          child: Text(
            l10n.registerButton,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
