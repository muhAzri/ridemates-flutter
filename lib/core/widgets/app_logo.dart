import 'package:flutter/material.dart';
import 'package:ridemates/core/constants/app_assets.dart';

/// Brand logo mark (white bike on leaf), rendered from the bundled asset.
///
/// The asset is already a leaf-filled square, so we just clip it to the brand
/// corner radius — no colours hard-coded here.
class AppLogo extends StatelessWidget {
  const AppLogo({this.size = 64, this.borderRadius, super.key});

  final double size;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? size * 0.3),
      child: Image.asset(
        AppAssets.logo,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
