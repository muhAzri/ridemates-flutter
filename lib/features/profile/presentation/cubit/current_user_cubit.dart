import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/domain/usecases/get_my_profile_usecase.dart';

part 'current_user_state.dart';

/// The app-wide source of truth for the signed-in user's profile (`GET
/// /users/me`, contract §17.1 self projection).
///
/// It is a [HydratedCubit] so the last-known profile survives restarts (hive_ce
/// backed) — handy because this data changes rarely, so screens like Settings
/// and Profile render instantly from the cached copy. [ensureLoaded] fetches
/// `/me` **at most once per session**, so the many screens that read this store
/// never trigger duplicate requests; [refresh] forces a re-fetch (pull-to-
/// refresh). A failed fetch keeps any stale user rather than blanking it.
class CurrentUserCubit extends HydratedCubit<CurrentUserState> {
  CurrentUserCubit(this._getMyProfile) : super(const CurrentUserState());

  final GetMyProfileUseCase _getMyProfile;

  /// Whether a successful load has completed this session.
  bool _loaded = false;

  /// The in-flight fetch. Concurrent callers await **this same** future instead
  /// of racing ahead and reading a not-yet-loaded user — the bug that surfaced
  /// as a spurious Profile error right after re-login (no hydrated copy to mask
  /// it).
  Future<void>? _inFlight;

  /// Loads `/me` once per session. Concurrent callers join the in-flight
  /// request; once loaded it is a no-op, so the many screens that read this
  /// store can call it freely without firing redundant requests.
  Future<void> ensureLoaded() {
    if (_loaded) return Future<void>.value();
    return _inFlight ??= _run();
  }

  /// Forces a fresh `/me` fetch (e.g. pull-to-refresh). Joins an in-flight load
  /// if one is already running.
  Future<void> refresh() => _inFlight ??= _run();

  /// Clears the cached user and wipes the persisted copy — call on sign-out so
  /// the next account never sees the previous user's profile.
  Future<void> signOut() async {
    _loaded = false;
    _inFlight = null;
    emit(const CurrentUserState());
    await clear();
  }

  Future<void> _run() async {
    try {
      await _fetch();
      // Only treat it as loaded once we actually have a user, so a failed load
      // is retried on the next ensureLoaded rather than latched forever.
      _loaded = state.user != null;
    } finally {
      _inFlight = null;
    }
  }

  Future<void> _fetch() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final user = await _getMyProfile();
      emit(CurrentUserState(user: user));
    } on ApiException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
    } on Object {
      emit(state.copyWith(isLoading: false));
    }
  }

  // ── Persistence ──────────────────────────────────────────────────────────
  // Only [user] is persisted; transient flags are not. Serialised by hand so
  // this presentation store stays independent of the data-layer model.

  @override
  CurrentUserState? fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    if (user is! Map<String, dynamic>) return const CurrentUserState();
    return CurrentUserState(user: _userFromJson(user));
  }

  @override
  Map<String, dynamic>? toJson(CurrentUserState state) {
    final user = state.user;
    if (user == null) return null;
    return {'user': _userToJson(user)};
  }

  Map<String, dynamic> _userToJson(UserProfile u) => {
    'id': u.id,
    'displayName': u.displayName,
    'email': u.email,
    'bio': u.bio,
    'cyclingType': u.cyclingType?.apiValue,
    'avatarUrl': u.avatarUrl,
    'displayArea': u.displayArea,
    'listingCount': u.listingCount,
    'threadCount': u.threadCount,
  };

  UserProfile _userFromJson(Map<String, dynamic> j) => UserProfile(
    id: j['id'] as String,
    displayName: j['displayName'] as String,
    email: j['email'] as String?,
    bio: j['bio'] as String?,
    cyclingType: CyclingType.fromApiValue(j['cyclingType'] as String?),
    avatarUrl: j['avatarUrl'] as String?,
    displayArea: j['displayArea'] as String?,
    listingCount: (j['listingCount'] as num?)?.toInt() ?? 0,
    threadCount: (j['threadCount'] as num?)?.toInt() ?? 0,
  );
}
