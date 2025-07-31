import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnimatedSlideWidget extends HookConsumerWidget {
  const AnimatedSlideWidget({
    super.key,
    this.slideBeginOffset = const Offset(0, -0.5),
    this.slideEndOffset = const Offset(0, 0),
    this.fadeDuration = const Duration(milliseconds: 800),
    this.fadeDelay,
    this.slideDuration = const Duration(milliseconds: 800),
    this.slideDelay,
    this.curve = Curves.easeOutCubic,
    required this.child,
  });
  final Offset slideBeginOffset;
  final Offset slideEndOffset;
  final Duration fadeDuration;
  final Duration? fadeDelay;
  final Duration slideDuration;
  final Duration? slideDelay;
  final Curve curve;
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Animate(
      effects: [
        FadeEffect(
          duration: fadeDuration,
          delay: fadeDelay,
          // curve: curve,
        ),
        SlideEffect(
          begin: slideBeginOffset,
          end: slideEndOffset,
          duration: slideDuration,
          curve: curve,
          delay: slideDelay,
        ),
      ],
      child: child,
    );
  }
}
