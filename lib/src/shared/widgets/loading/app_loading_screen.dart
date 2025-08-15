import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// A loading screen with app branding and loading indicator
class AppLoadingScreen extends StatelessWidget {
  final String? message;

  const AppLoadingScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo or icon
            Icon(
              Icons.work,
              size: 80.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 3.h),
            Text(
              'Hustle Link',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 5.h),
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              message ?? 'Loading...',
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlpha((0.7 * 255).toInt()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
