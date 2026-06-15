import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/usecases/get_my_profile_usecase.dart';
import 'package:ridemates/features/profile/domain/usecases/get_user_listings_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

/// Drives the Profile tab (screen 15): loads the signed-in user (`GET /users/me`)
/// then their listings (`GET /users/{id}/listings`).
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._getMyProfile, this._getUserListings)
    : super(const ProfileState()) {
    on<ProfileStarted>(_onLoad);
    on<ProfileRefreshed>(_onLoad);
  }

  final GetMyProfileUseCase _getMyProfile;
  final GetUserListingsUseCase _getUserListings;

  Future<void> _onLoad(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));
    try {
      final profile = await _getMyProfile();
      // Listings are secondary content — a failure there shouldn't blank out
      // the whole profile, so it degrades to an empty grid.
      var listings = const <ProfileListing>[];
      try {
        listings = await _getUserListings(profile.id);
      } on Object {
        listings = const [];
      }
      emit(
        state.copyWith(
          status: ProfileStatus.success,
          profile: profile,
          listings: listings,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: e.message,
        ),
      );
    } on Object {
      emit(state.copyWith(status: ProfileStatus.failure));
    }
  }
}
