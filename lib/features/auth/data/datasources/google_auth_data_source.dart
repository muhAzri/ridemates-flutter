import 'package:google_sign_in/google_sign_in.dart';

/// Runs the Google sign-in flow and returns the Google ID token (it does not
/// call the RideMates backend).
class GoogleAuthDataSource {
  GoogleAuthDataSource({GoogleSignIn? googleSignIn})
    : _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final GoogleSignIn _googleSignIn;
  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    // On Android the server client id is read automatically from
    // google-services.json (default_web_client_id) once the Google provider is
    // enabled in Firebase and the app's SHA-1 is registered.
    await _googleSignIn.initialize();
    _initialized = true;
  }

  /// Returns the Google ID token (audience = the configured server client id),
  /// or null if the user cancels.
  Future<String?> getIdToken() async {
    await _ensureInitialized();
    try {
      final account = await _googleSignIn.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        throw StateError(
          'No Google ID token returned. Set GOOGLE_SERVER_CLIENT_ID '
          '(the OAuth web client id) in env.json.',
        );
      }
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }
}
