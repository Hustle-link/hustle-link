import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// A reusable error container widget to display error messages
class ErrorContainer extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;

  const ErrorContainer({
    super.key,
    required this.errorMessage,
    this.onRetry,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.error,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Theme.of(context).colorScheme.error,
                size: 20.sp,
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  'Error',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
              if (onDismiss != null)
                IconButton(
                  onPressed: onDismiss,
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.error,
                    size: 18.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            errorMessage,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: 1.5.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onRetry,
                child: Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A success container widget to display success messages
class SuccessContainer extends StatelessWidget {
  final String message;
  final VoidCallback? onDismiss;

  const SuccessContainer({super.key, required this.message, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, color: Colors.green, size: 20.sp),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 14.sp, color: Colors.green.shade700),
            ),
          ),
          if (onDismiss != null)
            IconButton(
              onPressed: onDismiss,
              icon: Icon(Icons.close, color: Colors.green, size: 18.sp),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
