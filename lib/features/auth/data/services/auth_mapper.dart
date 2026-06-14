import 'package:ridemates/features/auth/data/models/auth_response_model.dart';
import 'package:ridemates/features/auth/data/models/auth_tokens_model.dart';
import 'package:ridemates/features/auth/data/models/user_model.dart';
import 'package:ridemates/features/auth/domain/entities/auth_session.dart';
import 'package:ridemates/features/auth/domain/entities/auth_tokens.dart';
import 'package:ridemates/features/auth/domain/entities/auth_user.dart';

extension AuthTokensModelMapper on AuthTokensModel {
  AuthTokens toEntity() => AuthTokens(
    accessToken: accessToken,
    refreshToken: refreshToken,
    expiresAt: DateTime.now().add(Duration(seconds: expiresIn)),
  );
}

extension UserModelMapper on UserModel {
  AuthUser toEntity() => AuthUser(
    id: id,
    email: email,
    displayName: displayName,
    role: role,
    createdAt: DateTime.tryParse(createdAt ?? '') ?? DateTime.now(),
    bio: bio,
    cyclingType: cyclingType,
    avatarUrl: avatarUrl,
    displayArea: displayArea,
  );
}

extension AuthResponseModelMapper on AuthResponseModel {
  AuthSession toEntity() => AuthSession(
    user: user.toEntity(),
    tokens: tokens.toEntity(),
    needsProfileSetup: needsProfileSetup,
    needsLocation: needsLocation,
  );
}
