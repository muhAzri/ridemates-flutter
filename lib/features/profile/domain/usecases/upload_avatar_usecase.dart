import 'dart:typed_data';

import 'package:ridemates/features/profile/domain/repositories/profile_repository.dart';

class UploadAvatarUseCase {
  const UploadAvatarUseCase(this._repository);

  final ProfileRepository _repository;

  Future<String?> call(Uint8List webpBytes) =>
      _repository.uploadAvatar(webpBytes);
}
