/// Centralised asset paths — the single source of truth for bundled asset
/// locations. Reference these constants (e.g. `Image.asset(AppAssets.logo)`)
/// instead of hard-coding strings, so a moved/renamed asset is a one-line fix.
abstract final class AppAssets {
  /// Root folder for image assets (declared in `pubspec.yaml`).
  static const String _images = 'assets/images';

  /// RideMates brand mark — white bike on leaf, square (1024², lossless WebP).
  static const String logo = '$_images/ridemates-logo.webp';

  /// Official Google "G" logo (standard colour), per Google's sign-in branding
  /// guidelines. Must not be recoloured or altered.
  static const String googleLogo = '$_images/google_g_logo.svg';
}
