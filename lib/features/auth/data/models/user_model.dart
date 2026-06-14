import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String displayName,
    String? bio,
    String? cyclingType,
    String? avatarUrl,
    String? contactPreference,
    String? displayArea,
    String? areaLevel,
    double? ratingAverage,
    @Default(0) int listingCount,
    @Default(0) int threadCount,
    @Default('user') String role,
    String? createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
