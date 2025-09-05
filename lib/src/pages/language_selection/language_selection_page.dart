import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/pages/language_selection/language_model.dart';
import 'package:hustle_link/src/pages/language_selection/widgets/language_card.dart';
import 'package:hustle_link/src/shared/routing/app_router.dart';
import 'package:hustle_link/src/shared/services/locale_service.dart';
import 'package:sizer/sizer.dart';

class LanguageSelectionPage extends ConsumerStatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  ConsumerState<LanguageSelectionPage> createState() =>
      _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends ConsumerState<LanguageSelectionPage> {
  final List<Language> _languages = [
    const Language(name: 'English', code: 'en'),
    const Language(name: 'Setswana', code: 'tn'),
    const Language(name: 'Sesotho', code: 'st'),
  ];

  Language? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    final currentLocale = ref.read(localeNotifierProvider);
    _selectedLanguage = _languages.firstWhere(
      (lang) => lang.code == currentLocale.languageCode,
      orElse: () => _languages.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              Text(
                'Choose Your Language',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    return LanguageCard(
                      language: language,
                      isSelected: _selectedLanguage?.code == language.code,
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language;
                        });
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _selectedLanguage == null
                    ? null
                    : () async {
                        if (_selectedLanguage != null) {
                          await ref
                              .read(localeNotifierProvider.notifier)
                              .setLocale(Locale(_selectedLanguage!.code));
                          await ref
                              .read(
                                languageSelectionSharedPreferencesProvider
                                    .notifier,
                              )
                              .setLanguageSelected(true);
                          if (mounted) {
                            context.go(AppRoutes.welcome);
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Continue'),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
