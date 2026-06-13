import 'package:flutter/widgets.dart';

/// Corner-radius tokens from the design system.
abstract final class AppRadii {
  /// Chips / pills — fully rounded.
  static const double pill = 999;

  /// Cards & sheets.
  static const double card = 22;

  /// Buttons & input fields.
  static const double field = 13;

  /// Inner tiles / nested cards.
  static const double tile = 16;

  /// Small icon containers.
  static const double icon = 15;

  static const BorderRadius pillRadius = BorderRadius.all(
    Radius.circular(pill),
  );
  static const BorderRadius cardRadius = BorderRadius.all(
    Radius.circular(card),
  );
  static const BorderRadius fieldRadius = BorderRadius.all(
    Radius.circular(field),
  );
  static const BorderRadius tileRadius = BorderRadius.all(
    Radius.circular(tile),
  );
}
