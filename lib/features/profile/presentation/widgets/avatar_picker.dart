import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';

/// Circular avatar with a camera badge. Shows [imageUrl] when present (e.g.
/// auto-populated from Google sign-in), otherwise a placeholder. Tapping opens
/// an image picker (wired later).
class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    required this.semanticLabel,
    this.imageUrl,
    this.isLoading = false,
    this.onTap,
    super.key,
  });

  final String semanticLabel;
  final String? imageUrl;
  final bool isLoading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: SizedBox(
          width: 92,
          height: 92,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.borderSubtle,
                  border: Border.all(color: AppColors.borderField),
                ),
                child: ClipOval(
                  child: isLoading
                      ? const AppShimmer(
                          child: SkeletonBox(width: 92, height: 92),
                        )
                      : _avatar(),
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

  Widget _avatar() {
    final url = imageUrl;
    if (url == null || url.isEmpty) return _placeholder();
    return Image.network(
      url,
      width: 92,
      height: 92,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => _placeholder(),
    );
  }

  Widget _placeholder() => const SizedBox(
    width: 92,
    height: 92,
    child: Icon(Icons.person_outline, size: 40, color: AppColors.inkFaint),
  );
}
