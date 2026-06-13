import 'package:flutter/widgets.dart';

/// Elevation tokens. The design uses soft, brand-tinted shadows rather than
/// flat Material elevations.
abstract final class AppShadows {
  /// Cards, logo tiles: `0 12px 28px -10px rgba(15,64,50,.55)`.
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x8C0F4032), // pine @ 55%
      blurRadius: 28,
      spreadRadius: -10,
      offset: Offset(0, 12),
    ),
  ];

  /// Primary buttons: `0 10px 20px -8px rgba(21,160,91,.5)`.
  static const List<BoxShadow> button = [
    BoxShadow(
      color: Color(0x8015A05B), // leaf @ 50%
      blurRadius: 20,
      spreadRadius: -8,
      offset: Offset(0, 10),
    ),
  ];

  /// Floating panels / phone frames: `0 30px 60px -24px rgba(15,64,50,.5)`.
  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Color(0x800F4032), // pine @ 50%
      blurRadius: 60,
      spreadRadius: -24,
      offset: Offset(0, 30),
    ),
  ];
}
