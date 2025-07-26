import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends HookConsumerWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // liquid controller
    final pageController = usePageController();

    // hooks
    final currentPage = useState(0);

    // listen to the page controller
    useEffect(() {
      pageController.addListener(() {
        final page = pageController.page?.round() ?? 0;
        if (currentPage.value != page) {
          currentPage.value = page;
        }
      });
      return () => pageController.dispose();
    }, [pageController]);

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              Container(
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30.h),
                    // image
                    Image.asset(
                      'assets/images/brand/hustle_link_logo.jpg',
                      height: 30.h,
                      width: 30.h,
                    ),
                    Text(
                      AppStringsWelcome.welcomeScreen1.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      textAlign: TextAlign.center,
                      AppStringsWelcome.welcomeScreen1.subtitle,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Spacer(flex: 8),
                  ],
                ),
              ),
              // Second page
              Container(
                color: Theme.of(context).colorScheme.secondary,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    // image
                    SvgPicture.asset(
                      'assets/images/welcome/career_progress.svg',
                      height: 30.h,
                      width: 30.h,
                    ),
                    SizedBox(height: 20),
                    // title and subtitle
                    Text(
                      AppStringsWelcome.welcomeScreen2.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppStringsWelcome.welcomeScreen2.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              // Third page
              Container(
                color: Theme.of(context).colorScheme.tertiary,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 5.h),
                    // image
                    SvgPicture.asset(
                      'assets/images/welcome/coding_job.svg',
                      height: 30.h,
                      width: 30.h,
                    ),
                    Text(
                      AppStringsWelcome.welcomeScreen3.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      AppStringsWelcome.welcomeScreen3.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onTertiary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              // Fourth page
              Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    // image
                    SvgPicture.asset(
                          'assets/images/welcome/job_hunting.svg',
                          height: 30.h,
                          width: 30.h,
                        )
                        .animate()
                        .slideY(
                          begin: 2,
                          duration: 500.ms,
                          delay: 200.ms,
                          curve: Curves.easeInOut,
                        )
                        .fadeIn(duration: 300.ms), // animate the image to
                    // slide from the bottom,
                    SizedBox(height: 5.h),
                    // title and subtitle
                    Text(
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
                    SizedBox(height: 20),
                    Text(
                      AppStringsWelcome.welcomeScreen4.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        ],
      ),
    );
  }
}

class AnimatedPageProgress extends HookConsumerWidget {
  final int pageCount;
  final int currentPage;

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
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(pageCount, (index) {
          final isActive = index == currentPage;

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
