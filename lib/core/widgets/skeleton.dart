import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

/// Wraps a layout of [SkeletonBox]es in a single shimmer so they pulse in sync.
/// Use for content-loading placeholders instead of spinners.
class AppShimmer extends StatelessWidget {
  const AppShimmer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.border,
      highlightColor: AppColors.paper,
      child: child,
    );
  }
}

/// A solid placeholder block — only meaningful inside an [AppShimmer], whose
/// gradient is what actually animates over it.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    this.width,
    this.height = 16,
    this.shape = BoxShape.rectangle,
    this.borderRadius = 8,
    super.key,
  });

  final double? width;
  final double height;
  final BoxShape shape;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: shape,
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(borderRadius),
      ),
    );
  }
}
