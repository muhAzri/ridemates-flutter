import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';

/// Top bar for the profile setup flow: back button, centred title and a step
/// indicator (e.g. "1 / 2").
class ProfileSetupHeader extends StatelessWidget {
  const ProfileSetupHeader({
    required this.title,
    required this.stepLabel,
    this.onBack,
    super.key,
  });

  final String title;
  final String stepLabel;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: AppColors.ink,
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.title,
            ),
          ),
          Text(stepLabel, style: AppTypography.mono),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
    );
  }
}
