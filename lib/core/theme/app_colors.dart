import 'package:flutter/painting.dart';

/// RideMates brand colour tokens — the single source of truth for colour across
/// the app (design system "Color Palette"). Reference these tokens; never
/// hard-code hex values in features.
abstract final class AppColors {
  // ── Brand ────────────────────────────────────────────────────────────────
  /// Pine — brand, headers, nav.
  static const Color pine = Color(0xFF0F4032);

  /// Leaf — primary action.
  static const Color leaf = Color(0xFF15A05B);

  /// Clay — warm accent · alerts.
  static const Color clay = Color(0xFFDD8A5C);

  /// Mint — tint · selected.
  static const Color mint = Color(0xFFE6F4EC);

  /// Paper — app background (screen surface).
  static const Color paper = Color(0xFFFAF7F1);

  /// Ink — primary text.
  static const Color ink = Color(0xFF15201B);

  // ── Text & neutrals ──────────────────────────────────────────────────────
  /// Secondary / muted text.
  static const Color inkMuted = Color(0xFF66756C);

  /// Tertiary text, placeholders, meta.
  static const Color inkFaint = Color(0xFF97A39B);

  /// Card / sheet surface.
  static const Color surface = Color(0xFFFFFFFF);

  /// Outer page background (a shade deeper than [paper]).
  static const Color background = Color(0xFFECE7DD);

  // ── Borders ──────────────────────────────────────────────────────────────
  /// Card border.
  static const Color border = Color(0xFFE8E3D8);

  /// Input / field border.
  static const Color borderField = Color(0xFFEAE5DB);

  /// Subtle inner border / divider on paper.
  static const Color borderSubtle = Color(0xFFEFEAE0);

  /// Secondary button border (tinted toward leaf).
  static const Color borderSecondary = Color(0xFFD7E7DD);

  // ── On-dark (pine surfaces) ──────────────────────────────────────────────
  /// Deepest pine — phone bezel / pressed pine.
  static const Color pineDark = Color(0xFF0B3026);

  /// Bright leaf accent on dark.
  static const Color leafBright = Color(0xFF5FD79B);

  /// Primary text on a pine surface.
  static const Color onPine = Color(0xFFEAF3EE);

  /// Muted text on a pine surface.
  static const Color onPineMuted = Color(0xFFB9D4C7);

  // ── Semantic tints (chips / badges) ──────────────────────────────────────
  /// Mint border for selected / green chips.
  static const Color mintBorder = Color(0xFFD2E7DA);

  /// Green text on a [mint] chip.
  static const Color onMint = Color(0xFF0F7A45);

  /// Clay tint background (e.g. "For Sale" chip).
  static const Color clayTint = Color(0xFFF6E7DB);

  /// Clay text on a [clayTint] chip.
  static const Color onClayTint = Color(0xFFB5662F);

  // ── Status ───────────────────────────────────────────────────────────────
  /// Error / destructive (warm, on-brand red derived from clay family).
  static const Color error = Color(0xFFC2542B);

  /// Success — same family as the primary action.
  static const Color success = Color(0xFF15A05B);
}
