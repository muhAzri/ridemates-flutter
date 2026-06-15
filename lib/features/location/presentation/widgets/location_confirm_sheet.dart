import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Bottom sheet for screen 04: shows the resolved area, the area-only privacy
/// reassurance (LP-2/LP-4), and the confirm action. Coordinates are never
/// shown — only the area label.
class LocationConfirmSheet extends StatelessWidget {
  const LocationConfirmSheet({
    required this.displayArea,
    required this.isResolving,
    required this.isSubmitting,
    required this.onConfirm,
    super.key,
  });

  /// The resolved area label, or null while it is still being resolved/unknown.
  final String? displayArea;
  final bool isResolving;
  final bool isSubmitting;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadii.card),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40194032),
            blurRadius: 30,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.mint,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: const Icon(
                      Icons.place_outlined,
                      size: 20,
                      color: AppColors.leaf,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.setLocationAreaLabel.toUpperCase(),
                          style: AppTypography.label,
                        ),
                        const SizedBox(height: 2),
                        _AreaName(
                          displayArea: displayArea,
                          isResolving: isResolving,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.paper,
                  borderRadius: AppRadii.tileRadius,
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 17,
                        color: AppColors.leaf,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          l10n.setLocationPrivacyNote,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.inkMuted,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: l10n.setLocationConfirmButton,
                isLoading: isSubmitting,
                onPressed: isSubmitting ? null : onConfirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AreaName extends StatelessWidget {
  const _AreaName({required this.displayArea, required this.isResolving});

  final String? displayArea;
  final bool isResolving;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (displayArea == null && isResolving) {
      return Text(
        l10n.setLocationResolvingArea,
        style: AppTypography.heading.copyWith(color: AppColors.inkFaint),
      );
    }
    return Text(
      displayArea ?? l10n.setLocationUnknownArea,
      style: AppTypography.heading,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
