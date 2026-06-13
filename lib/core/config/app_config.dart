/// App-wide configuration.
///
/// Runtime values (e.g. the API base URL) are injected at build/run time via
/// `--dart-define-from-file=env.json` and read here with
/// [String.fromEnvironment]. Each `main_*.dart` entrypoint sets [instance] with
/// its flavor before `bootstrap` runs.
class AppConfig {
  const AppConfig({required this.flavor, required this.apiBaseUrl});

  /// Builds the config for [flavor], pulling runtime values from the
  /// environment (env.json, via `--dart-define-from-file`).
  factory AppConfig.fromEnvironment(AppFlavor flavor) =>
      AppConfig(flavor: flavor, apiBaseUrl: _apiBaseUrl);

  /// API base URL, supplied by `env.json` (`API_BASE_URL`). Falls back to the
  /// deployed Vercel backend so tests/tooling without the define still work.
  static const String _apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://ride-mates-nu.vercel.app/api/v1',
  );

  /// The active configuration. Overridden by each `main_*.dart` entrypoint.
  static AppConfig instance = AppConfig.fromEnvironment(AppFlavor.development);

  final AppFlavor flavor;
  final String apiBaseUrl;
}

enum AppFlavor { development, staging, production }
