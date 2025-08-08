import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hustle_link/src/pages/auth/controllers/auth_controller.dart';
import 'package:hustle_link/src/shared/utils/strings/reset_password_strings.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../../shared/routing/app_router.dart';

class PasswordResetPage extends ConsumerWidget {
  const PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    ref.listen(authControllerProvider, (_, state) {
      state.map(
        idle: () => null,
        loading: () => SmartDialog.showLoading(msg: "Sending reset link..."),
        data: (_) {
          SmartDialog.dismiss();
          SmartDialog.showToast("Password reset link sent successfully!");
          context.goNamed(AppRoutes.loginRoute);
          return null;
        },
        error: (error, __) {
          SmartDialog.dismiss();
          SmartDialog.showToast(
            error.toString().replaceFirst('Exception: ', ''),
          );
          return null;
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text(ResetPasswordStrings.title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ResetPasswordStrings.subTitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: ResetPasswordStrings.emailHint,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref
                          .read(authControllerProvider.notifier)
                          .resetPassword(emailController.text.trim());
                    }
                  },
                  child: const Text(ResetPasswordStrings.sendButtonText),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.goNamed(AppRoutes.loginRoute),
                child: const Text(ResetPasswordStrings.backToLogin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
