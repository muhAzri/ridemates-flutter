import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_response_model.freezed.dart';
part 'location_response_model.g.dart';

/// Response of `PUT /users/me/location` (contract §5). Never contains
/// coordinates — only the cached area label + when it was last set (LP-1).
@freezed
abstract class LocationResponseModel with _$LocationResponseModel {
  const factory LocationResponseModel({
    String? displayArea,
    String? areaLevel,
    DateTime? updatedAt,
  }) = _LocationResponseModel;

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseModelFromJson(json);
}
