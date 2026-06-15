import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';

/// A fully-rounded filter / category pill used across the home tabs
/// (Browse categories, Forum topics, Chats filters).
///
/// Mirrors the design-system chip: selected chips fill with [AppColors.pine]
/// and white text; unselected chips are a white surface with a hairline border.
/// An optional trailing [count] renders a small leaf badge (e.g. "Unread · 3").
class BrandChip extends StatelessWidget {
  const BrandChip({
    required this.label,
    this.selected = false,
    this.count,
    this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final int? count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.pine : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.pillRadius,
        side: selected
            ? BorderSide.none
            : const BorderSide(color: AppColors.borderField),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.pillRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTypography.body.copyWith(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  color: selected ? Colors.white : AppColors.ink,
                ),
              ),
              if (count != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: const BoxDecoration(
                    color: AppColors.leaf,
                    borderRadius: AppRadii.pillRadius,
                  ),
                  child: Text(
                    '$count',
                    style: AppTypography.body.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      height: 1.6,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// A small status/category tag (e.g. "Rides", "For Sale", "Shimano 105").
/// Coloured variants are provided by the named constructors.
class BrandTag extends StatelessWidget {
  const BrandTag({
    required this.label,
    required this.background,
    required this.foreground,
    super.key,
  });

  /// Mint / leaf tag — the default green tone.
  const BrandTag.leaf(String label, {Key? key})
    : this(
        label: label,
        background: AppColors.mint,
        foreground: AppColors.onMint,
        key: key,
      );

  /// Clay tag — warm accent (e.g. "Gear", "Wheelset").
  const BrandTag.clay(String label, {Key? key})
    : this(
        label: label,
        background: AppColors.clayTint,
        foreground: AppColors.onClayTint,
        key: key,
      );

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadii.pillRadius,
      ),
      child: Text(
        label,
        style: AppTypography.body.copyWith(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          height: 1,
          color: foreground,
        ),
      ),
    );
  }
}
