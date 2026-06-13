/// Per-flavor configuration. Each `main_*.dart` entrypoint should set
/// [AppConfig.instance] before calling `bootstrap`.
class AppConfig {
  const AppConfig({required this.flavor, required this.apiBaseUrl});

  const AppConfig.development()
    : flavor = AppFlavor.development,
      apiBaseUrl = 'https://api.ridemates.app/api/v1';

  const AppConfig.staging()
    : flavor = AppFlavor.staging,
      apiBaseUrl = 'https://api.staging.ridemates.app/api/v1';

  const AppConfig.production()
    : flavor = AppFlavor.production,
      apiBaseUrl = 'https://api.ridemates.app/api/v1';

  /// The active configuration. Defaults to development.
  static AppConfig instance = const AppConfig.development();

  final AppFlavor flavor;
  final String apiBaseUrl;
}

enum AppFlavor { development, staging, production }
