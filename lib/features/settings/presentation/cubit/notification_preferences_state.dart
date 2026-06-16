part of 'notification_preferences_cubit.dart';

/// A one-shot save failure, emitted so the UI can show a single message and
/// then move on. [message] is null for a generic (non-API) failure.
class SaveError extends Equatable {
  const SaveError(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class NotificationPreferencesState extends Equatable {
  const NotificationPreferencesState({
    this.prefs,
    this.isLoading = false,
    this.loadErrorMessage,
    this.saveError,
  });

  /// The toggles, or null until [NotificationPreferencesCubit.load] resolves.
  final NotificationPreferences? prefs;

  /// A `GET` is in flight.
  final bool isLoading;

  /// Message from a failed `GET` (empty string = generic failure).
  final String? loadErrorMessage;

  /// Transient: set only on the emit that follows a failed `PATCH`. Cleared on
  /// every subsequent emit so it fires the UI listener exactly once.
  final SaveError? saveError;

  bool get hasLoaded => prefs != null;

  NotificationPreferencesState copyWith({
    NotificationPreferences? prefs,
    bool? isLoading,
    String? loadErrorMessage,
    bool clearLoadError = false,
    SaveError? saveError,
  }) => NotificationPreferencesState(
    prefs: prefs ?? this.prefs,
    isLoading: isLoading ?? this.isLoading,
    loadErrorMessage: clearLoadError
        ? null
        : (loadErrorMessage ?? this.loadErrorMessage),
    // Transient — not preserved across copies.
    saveError: saveError,
  );

  @override
  List<Object?> get props => [prefs, isLoading, loadErrorMessage, saveError];
}
