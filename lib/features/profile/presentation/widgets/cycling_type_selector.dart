import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Single-select chip group for the rider's [CyclingType].
class CyclingTypeSelector extends StatelessWidget {
  const CyclingTypeSelector({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final CyclingType? selected;
  final ValueChanged<CyclingType> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final type in CyclingType.values)
          ChoiceChip(
            label: Text(_label(l10n, type)),
            selected: type == selected,
            showCheckmark: false,
            onSelected: (_) => onSelected(type),
            backgroundColor: AppColors.surface,
            selectedColor: AppColors.leaf,
            side: BorderSide(
              color: type == selected ? AppColors.leaf : AppColors.borderField,
              width: 1.5,
            ),
            labelStyle: AppTypography.body.copyWith(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: type == selected ? Colors.white : AppColors.ink,
            ),
            shape: const StadiumBorder(),
          ),
      ],
    );
  }

  String _label(AppLocalizations l10n, CyclingType type) => switch (type) {
    CyclingType.road => l10n.cyclingTypeRoad,
    CyclingType.mtb => l10n.cyclingTypeMtb,
    CyclingType.gravel => l10n.cyclingTypeGravel,
    CyclingType.folding => l10n.cyclingTypeFolding,
    CyclingType.casual => l10n.cyclingTypeCasual,
  };
}
