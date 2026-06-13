import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridemates/core/theme/app_colors.dart';

/// Typography tokens (design system "Typography").
///
/// One friendly geometric family — **Plus Jakarta Sans** — across the product,
/// with **JetBrains Mono** reserved for meta/numeric labels. CSS `em`
/// letter-spacing is converted to absolute logical pixels (`em × fontSize`).
abstract final class AppTypography {
  static TextStyle _sans({
    required double size,
    required FontWeight weight,
    double letterSpacing = 0,
    double? height,
    Color color = AppColors.ink,
  }) => GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: weight,
    letterSpacing: letterSpacing,
    height: height,
    color: color,
  );

  /// Screen titles — 28 · 800.
  static TextStyle get display =>
      _sans(size: 28, weight: FontWeight.w800, letterSpacing: -0.56);

  /// Cards & sections — 20 · 700.
  static TextStyle get heading =>
      _sans(size: 20, weight: FontWeight.w700, letterSpacing: -0.2);

  /// Sub-headers / app-bar titles — 16 · 700.
  static TextStyle get title => _sans(size: 16, weight: FontWeight.w700);

  /// Default body — 15 · 500.
  static TextStyle get body =>
      _sans(size: 15, weight: FontWeight.w500, height: 1.45);

  /// Smaller body / helper copy — 13.5 · 500.
  static TextStyle get bodySmall =>
      _sans(size: 13.5, weight: FontWeight.w500, height: 1.5);

  /// Uppercase tag/meta label — 12 · 600, +0.08em tracking.
  /// Apply `.toUpperCase()` to the text at the call site.
  static TextStyle get label => _sans(
    size: 12,
    weight: FontWeight.w600,
    letterSpacing: 0.96,
    color: AppColors.inkMuted,
  );

  /// Caption / fine print — 11.5 · 500.
  static TextStyle get caption =>
      _sans(size: 11.5, weight: FontWeight.w500, color: AppColors.inkFaint);

  /// Monospace meta (codes, counts, timestamps) — JetBrains Mono 12.
  static TextStyle get mono => GoogleFonts.jetBrainsMono(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.inkFaint,
  );

  /// Maps the tokens above onto a Material [TextTheme] so framework widgets
  /// (and `Theme.of(context).textTheme`) inherit the brand type scale.
  static TextTheme get textTheme => TextTheme(
    displayLarge: display,
    displayMedium: display.copyWith(fontSize: 24),
    headlineSmall: heading,
    titleLarge: heading,
    titleMedium: title,
    titleSmall: _sans(size: 14, weight: FontWeight.w700),
    bodyLarge: body,
    bodyMedium: body.copyWith(fontSize: 14),
    bodySmall: bodySmall,
    labelLarge: _sans(size: 14, weight: FontWeight.w700),
    labelMedium: label,
    labelSmall: caption,
  );
}
