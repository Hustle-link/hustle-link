import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

// TODO(refactor): Consider breaking down each page of the PageView into its own widget file for better organization.

/// The welcome/onboarding page of the application.
///
/// This page uses a [PageView] to guide the user through a series of
/// introductory screens. It tracks the current page to update UI elements
/// like button text and colors dynamically.
class WelcomePage extends HookConsumerWidget {
  /// Creates a [WelcomePage].
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controller for the PageView.
    final pageController = usePageController();

    // A state hook to keep track of the current page index.
    final currentPage = useState(0);

    // An effect hook to listen for page changes and update the state.
    useEffect(() {
      void listener() {
        final page = pageController.page?.round() ?? 0;
        if (currentPage.value != page) {
          currentPage.value = page;
        }
      }

      pageController.addListener(listener);
      // The listener is automatically removed when the widget is disposed.
      return () => pageController.removeListener(listener);
    }, [pageController]);

    /// Determines the text for the "next" button based on the current page.
    String? nextButtonText() {
      switch (currentPage.value) {
        case 0:
          return AppStringsWelcome.welcomeScreen1.buttonText;
        case 1:
          return AppStringsWelcome.welcomeScreen2.buttonText;
        case 2:
          return AppStringsWelcome.welcomeScreen3.buttonText;
        case 3:
          return AppStringsWelcome.welcomeScreen4.buttonText;
        default:
          return GeneralStrings.welcome;
      }
    }

    /// Determines the color for icons based on the current page's background.
    Color iconColor() {
      switch (currentPage.value) {
        case 0:
          return Colors.white;
        case 1:
          return Theme.of(context).colorScheme.onSecondary;
        case 2:
          return Theme.of(context).colorScheme.onTertiary;
        case 3:
          return Theme.of(context).colorScheme.onSecondaryContainer;
        default:
          return Colors.white;
      }
    }

    /// Determines the color for button text based on the current page's background.
    Color buttonColor() {
      switch (currentPage.value) {
        case 0:
          return Colors.white;
        case 1:
          return Theme.of(context).colorScheme.onSecondary;
        case 2:
          return Theme.of(context).colorScheme.onTertiary;
        case 3:
          return Theme.of(context).colorScheme.onSecondaryContainer;
        default:
          return Colors.white;
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              // First welcome screen.
              Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30.h),
                    // image
                    AnimatedSlideWidget(
                      child: Image.asset(
                        'assets/images/brand/hustle_link_logo.jpg',
                        height: 30.h,
                        width: 30.h,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // title and subtitle
                    AnimatedSlideWidget(
                      fadeDelay: Duration(milliseconds: 200),
                      slideBeginOffset: Offset(0, 0.5),
                      slideDelay: Duration(milliseconds: 100),
                      child: Text(
                        AppStringsWelcome.welcomeScreen1.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedSlideWidget(
                      fadeDelay: Duration(milliseconds: 300),
                      slideBeginOffset: Offset(0, 0.7),
                      slideDelay: Duration(milliseconds: 200),
                      child: Text(
                        textAlign: TextAlign.center,
                        AppStringsWelcome.welcomeScreen1.subtitle,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const Spacer(flex: 8),
                  ],
                ),
              ),
              // Second welcome screen.
              Container(
                color: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    // image
                    AnimatedSlideWidget(
                      child: SvgPicture.asset(
                        'assets/images/welcome/career_progress.svg',
                        height: 30.h,
                        width: 30.h,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // title and subtitle
                    AnimatedSlideWidget(
                      fadeDelay: const Duration(milliseconds: 200),
                      slideBeginOffset: const Offset(0, 0.5),
                      slideDelay: const Duration(milliseconds: 100),
                      child: Text(
                        AppStringsWelcome.welcomeScreen2.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedSlideWidget(
                      fadeDelay: const Duration(milliseconds: 300),
                      slideBeginOffset: const Offset(0, 0.7),
                      slideDelay: const Duration(milliseconds: 200),
                      child: Text(
                        AppStringsWelcome.welcomeScreen2.subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Third welcome screen.
              Container(
                color: Theme.of(context).colorScheme.tertiary,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 5.h),
                    // image
                    AnimatedSlideWidget(
                      child: SvgPicture.asset(
                        'assets/images/welcome/coding_job.svg',
                        height: 30.h,
                        width: 30.h,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // title and subtitle
                    AnimatedSlideWidget(
                      fadeDelay: const Duration(milliseconds: 200),
                      slideBeginOffset: const Offset(0, 0.5),
                      slideDelay: const Duration(milliseconds: 100),
                      child: Text(
                        AppStringsWelcome.welcomeScreen3.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedSlideWidget(
                      fadeDelay: const Duration(milliseconds: 300),
                      slideBeginOffset: const Offset(0, 0.7),
                      slideDelay: const Duration(milliseconds: 200),
                      child: Text(
                        AppStringsWelcome.welcomeScreen3.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onTertiary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Fourth welcome screen.
              Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    // image
                    AnimatedSlideWidget(
                      child: SvgPicture.asset(
                        'assets/images/welcome/job_hunting.svg',
                        height: 30.h,
                        width: 30.h,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    // title and subtitle
                    AnimatedSlideWidget(
                      fadeDelay: const Duration(milliseconds: 200),
                      slideBeginOffset: const Offset(0, 0.5),
                      slideDelay: const Duration(milliseconds: 100),
                      child: Text(
                        AppStringsWelcome.welcomeScreen4.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimatedSlideWidget(
                      fadeDelay: const Duration(milliseconds: 300),
                      slideBeginOffset: const Offset(0, 0.7),
                      slideDelay: const Duration(milliseconds: 200),
                      child: Text(
                        AppStringsWelcome.welcomeScreen4.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // A custom animated page indicator.
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedPageProgress(
                pageCount: 4,
                currentPage: currentPage.value,
              ),
            ),
          ),
          // Action buttons (Skip and Next).
          Positioned(
            bottom: 20,
            right: 20,
            left: 20,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Skip button jumps to the last page.
                TextButton.icon(
                  onPressed: () {
                    pageController.jumpToPage(3); // Jump to last page
                  },
                  icon: Icon(Icons.arrow_forward, color: iconColor()),
                  iconAlignment: IconAlignment.end,
                  label: Text(
                    // TODO(ux): Consider hiding the skip button on the last page.
                    GeneralStrings.skip,
                    style: TextStyle(color: buttonColor()),
                  ),
                ),
                const Spacer(),
                // Next button proceeds to the next page or navigates away.
                TextButton(
                  onPressed: () {
                    if (currentPage.value < 3) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // On the last page, mark onboarding as complete and navigate.
                      // TODO(navigation): Ensure this navigation is robust and handles all user states.
                      ref
                          .read(welcomePageSharedPreferencesProvider.notifier)
                          .setFirstTimeOpenApp(false);
                      context.pushNamed(AppRoutes.loginRoute);
                    }
                  },
                  child: Text(
                    nextButtonText() ?? GeneralStrings.next,
                    style: TextStyle(color: buttonColor()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget that displays an animated page progress indicator.
///
/// It shows a series of dots, with the current page's dot being wider and
/// more prominent.
class AnimatedPageProgress extends HookConsumerWidget {
  /// The total number of pages.
  final int pageCount;

  /// The index of the current page.
  final int currentPage;

  /// Creates an [AnimatedPageProgress].
  const AnimatedPageProgress({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4), // translucent background
        borderRadius: BorderRadius.circular(30), // pill shape
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(pageCount, (index) {
          final isActive = index == currentPage;

          // Each dot is an AnimatedContainer that changes size and color.
          return AnimatedContainer(
                duration: 300.ms,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.white
                      : Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
              )
              .animate(target: isActive ? 1 : 0)
              .scaleXY(begin: 0.8, end: 1.2, duration: 300.ms)
              .fadeIn(duration: 300.ms);
        }),
      ),
    );
  }
}
