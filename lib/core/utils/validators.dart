/// Pure, context-free form validators. Callers pass already-localized messages
/// (from `context.l10n`) so the functions stay unit-testable and free of any
/// Flutter/l10n dependency.
abstract final class Validators {
  static final RegExp _emailRegExp = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  /// Validates an email address. Returns `null` when valid.
  static String? email(
    String? value, {
    required String requiredMessage,
    required String invalidMessage,
  }) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return requiredMessage;
    if (!_emailRegExp.hasMatch(v)) return invalidMessage;
    return null;
  }

  /// Validates a new password (sign-up rule: 8+ chars incl. a digit).
  static String? newPassword(
    String? value, {
    required String requiredMessage,
    required String weakMessage,
  }) {
    final v = value ?? '';
    if (v.isEmpty) return requiredMessage;
    if (v.length < 8 || !v.contains(RegExp(r'\d'))) return weakMessage;
    return null;
  }

  /// Validates a password is present (login — no strength rules).
  static String? requiredPassword(
    String? value, {
    required String requiredMessage,
  }) {
    if ((value ?? '').isEmpty) return requiredMessage;
    return null;
  }

  /// Validates a generic required text field.
  static String? required(String? value, {required String requiredMessage}) {
    if ((value?.trim() ?? '').isEmpty) return requiredMessage;
    return null;
  }
}
