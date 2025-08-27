import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hustle_link/src/src.dart';

/// First-run language selection screen
class LanguageSelectionPage extends HookConsumerWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.language)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              'Select your language',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _LanguageTile(
              title: l10n.english,
              locale: const Locale('en'),
              selected: currentLocale.languageCode == 'en',
            ),
            const SizedBox(height: 12),
            _LanguageTile(
              title: 'Sesotho',
              // Note: localizations for 'st' exist in l10n, keep option hidden if needed.
              locale: const Locale('st'),
              selected: currentLocale.languageCode == 'st',
            ),
            const SizedBox(height: 12),
            _LanguageTile(
              title: l10n.setswana,
              locale: const Locale('tn'),
              selected: currentLocale.languageCode == 'tn',
            ),
            const Spacer(),
            FilledButton(
              onPressed: () async {
                // Mark language selected so we don’t show this page again
                await ref
                    .read(languageSelectionSharedPreferencesProvider.notifier)
                    .setLanguageSelected(true);
                // If it's first-time open, navigate to welcome; else go home
                final firstTime = ref.read(
                  welcomePageSharedPreferencesProvider,
                );
                if (firstTime.firstTimeOpenApp == true) {
                  if (context.mounted) {
                    context.go(AppRoutes.welcome);
                  }
                } else {
                  if (context.mounted) {
                    context.go(AppRoutes.home);
                  }
                }
              },
              child: Text(l10n.getStarted),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends HookConsumerWidget {
  final String title;
  final Locale locale;
  final bool selected;

  const _LanguageTile({
    required this.title,
    required this.locale,
    required this.selected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeNotifier = ref.read(localeNotifierProvider.notifier);

    return ListTile(
      tileColor: selected
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      title: Text(title),
      trailing: selected ? const Icon(Icons.check_circle) : null,
      onTap: () async {
        await localeNotifier.setLocale(locale);
      },
    );
  }
}
