import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';

/// Footer prompt + inline action link, e.g. "New to RideMates? Sign up".
class AuthFooter extends StatelessWidget {
  const AuthFooter({
    required this.prompt,
    required this.actionLabel,
    required this.onPressed,
    super.key,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          prompt,
          style: AppTypography.bodySmall.copyWith(color: AppColors.inkMuted),
        ),
        const SizedBox(width: AppSpacing.xxs),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            actionLabel,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.leaf,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
