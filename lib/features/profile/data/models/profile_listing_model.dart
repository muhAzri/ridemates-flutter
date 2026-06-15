import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_listing_model.freezed.dart';
part 'profile_listing_model.g.dart';

/// Wire model for a ListingCard item (contract §17.2) as returned by
/// `GET /users/{userId}/listings`.
@freezed
abstract class ProfileListingModel with _$ProfileListingModel {
  const factory ProfileListingModel({
    required String id,
    required String title,
    required int priceIdr,
    String? status,
    String? displayArea,
    @Default(<ListingPhotoModel>[]) List<ListingPhotoModel> photos,
  }) = _ProfileListingModel;

  factory ProfileListingModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileListingModelFromJson(json);
}

@freezed
abstract class ListingPhotoModel with _$ListingPhotoModel {
  const factory ListingPhotoModel({required String url}) = _ListingPhotoModel;

  factory ListingPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$ListingPhotoModelFromJson(json);
}
