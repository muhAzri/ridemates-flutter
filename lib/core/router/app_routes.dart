/// Centralised route names/paths so navigation stays type-safe-ish and
/// refactorable from one place. Kept separate from the router build so the many
/// widgets that only navigate can import the paths without pulling in GoRouter.
abstract final class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const createAccount = '/create-account';
  static const profileSetup = '/profile-setup';
  static const setLocation = '/set-location';
  static const home = '/home';
}
