part of 'current_user_cubit.dart';

/// State of the shared, persisted signed-in-user store.
///
/// [user] is hydrated from disk on cold start (so screens render the
/// last-known profile instantly), then refreshed once per session. [isLoading]
/// and [errorMessage] are transient and never persisted.
class CurrentUserState extends Equatable {
  const CurrentUserState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  /// The signed-in user's `/me` snapshot, or null before the first load.
  final UserProfile? user;

  /// A `/me` fetch is in flight.
  final bool isLoading;

  /// Message from the last failed fetch (kept alongside any stale [user]).
  final String? errorMessage;

  CurrentUserState copyWith({
    UserProfile? user,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) => CurrentUserState(
    user: user ?? this.user,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
  );

  @override
  List<Object?> get props => [user, isLoading, errorMessage];
}
