/// The authenticated user's own (self) projection (contract §17.1).
class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    required this.displayName,
    required this.role,
    required this.createdAt,
    this.bio,
    this.cyclingType,
    this.avatarUrl,
    this.displayArea,
  });

  final String id;
  final String email;
  final String displayName;
  final String role;
  final DateTime createdAt;
  final String? bio;
  final String? cyclingType;
  final String? avatarUrl;
  final String? displayArea;
}
