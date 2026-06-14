import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/features/auth/data/models/auth_tokens_model.dart';
import 'package:ridemates/features/auth/data/models/user_model.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
abstract class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    required UserModel user,
    required AuthTokensModel tokens,
    @Default(false) bool needsProfileSetup,
    @Default(false) bool needsLocation,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}
