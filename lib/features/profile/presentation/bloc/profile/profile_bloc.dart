import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/usecases/get_user_listings_usecase.dart';
import 'package:ridemates/features/profile/presentation/cubit/current_user_cubit.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

/// Drives the Profile tab (screen 15). The signed-in user comes from the shared
/// [CurrentUserCubit] (one persisted `/me` source for the whole app — no
/// duplicate request); this bloc only adds the user's listings
/// (`GET /users/{id}/listings`).
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._currentUser, this._getUserListings)
    : super(const ProfileState()) {
    on<ProfileStarted>(_onLoad);
    on<ProfileRefreshed>(_onLoad);
  }

  final CurrentUserCubit _currentUser;
  final GetUserListingsUseCase _getUserListings;

  Future<void> _onLoad(ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading, errorMessage: null));

    // Started reuses the shared (possibly already-loaded) profile; refresh
    // forces a fresh fetch.
    if (event is ProfileRefreshed) {
      await _currentUser.refresh();
    } else {
      await _currentUser.ensureLoaded();
    }

    final profile = _currentUser.state.user;
    if (profile == null) {
      emit(
        state.copyWith(
          status: ProfileStatus.failure,
          errorMessage: _currentUser.state.errorMessage,
        ),
      );
      return;
    }

    // Listings are secondary content — a failure there shouldn't blank out the
    // whole profile, so it degrades to an empty grid.
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
  }
}
