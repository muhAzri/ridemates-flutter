import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';

/// A tappable search-field placeholder shown in the home-tab headers (Browse,
/// Forum, Chats). It's a button, not a live input — tapping opens the dedicated
/// search experience for that tab.
class SearchFieldButton extends StatelessWidget {
  const SearchFieldButton({required this.hint, this.onTap, super.key});

  final String hint;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadii.fieldRadius,
        side: BorderSide(color: AppColors.borderSubtle),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.fieldRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                size: 17,
                color: AppColors.inkFaint,
              ),
              const SizedBox(width: 10),
              Text(
                hint,
                style: AppTypography.body.copyWith(
                  fontSize: 13.5,
                  color: AppColors.inkFaint,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
