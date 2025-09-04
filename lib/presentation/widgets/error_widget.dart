import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData? icon;

  const CustomErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline_rounded,
              size: 64,
              color: AppColors.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Get.textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _getErrorMessage(message),
              style: Get.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  foregroundColor: AppColors.textPrimary,
                ),
                child: const Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(String originalMessage) {
    if (originalMessage.contains('Failed host lookup') ||
        originalMessage.contains('Network error') ||
        originalMessage.contains('SocketException')) {
      return 'Please check your internet connection and try again.';
    } else if (originalMessage.contains('timeout')) {
      return 'Connection timed out. Please try again.';
    } else if (originalMessage.contains('401') ||
        originalMessage.contains('Unauthorized')) {
      return 'API access denied. Please check API configuration.';
    } else if (originalMessage.contains('404')) {
      return 'Content not found. Please try again later.';
    }
    return originalMessage;
  }
}
