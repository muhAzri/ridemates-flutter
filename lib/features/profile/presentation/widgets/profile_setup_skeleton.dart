import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';

/// Shimmer placeholder shown while the profile loads — mirrors the real form's
/// shape (avatar, fields, chips, bio) for a smooth transition.
class ProfileSetupSkeleton extends StatelessWidget {
  const ProfileSetupSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShimmer(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.xs,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: SkeletonBox(width: 92, height: 92, shape: BoxShape.circle),
            ),
            SizedBox(height: AppSpacing.xl),
            SkeletonBox(width: 90, height: 12),
            SizedBox(height: AppSpacing.xs),
            SkeletonBox(height: 48, borderRadius: AppRadii.field),
            SizedBox(height: AppSpacing.md),
            SkeletonBox(width: 120, height: 12),
            SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                SkeletonBox(width: 70, height: 32, borderRadius: AppRadii.pill),
                SkeletonBox(width: 64, height: 32, borderRadius: AppRadii.pill),
                SkeletonBox(width: 80, height: 32, borderRadius: AppRadii.pill),
                SkeletonBox(width: 72, height: 32, borderRadius: AppRadii.pill),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            SkeletonBox(width: 80, height: 12),
            SizedBox(height: AppSpacing.xs),
            SkeletonBox(height: 80, borderRadius: AppRadii.field),
          ],
        ),
      ),
    );
  }
}
