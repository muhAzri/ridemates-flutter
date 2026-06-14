import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';

/// A horizontal divider with a centred label, e.g. "or".
class OrDivider extends StatelessWidget {
  const OrDivider({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderField)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(label, style: AppTypography.caption),
        ),
        const Expanded(child: Divider(color: AppColors.borderField)),
      ],
    );
  }
}
