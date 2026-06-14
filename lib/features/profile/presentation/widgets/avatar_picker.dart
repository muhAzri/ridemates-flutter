import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';

/// Circular avatar placeholder with a camera badge. Tapping should open an
/// image picker (wired later); for now it's a presentational affordance.
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({required this.semanticLabel, this.onTap, super.key});

  final String semanticLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 92,
          height: 92,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.borderSubtle,
                  border: Border.all(color: AppColors.borderField),
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 40,
                  color: AppColors.inkFaint,
                ),
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.leaf,
                    border: Border.all(color: AppColors.paper, width: 3),
                  ),
                  child: const Icon(
                    Icons.photo_camera_outlined,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
