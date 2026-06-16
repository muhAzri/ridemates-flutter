import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/settings/domain/entities/notification_preferences.dart';
import 'package:ridemates/features/settings/domain/usecases/get_notification_preferences_usecase.dart';
import 'package:ridemates/features/settings/domain/usecases/update_notification_preferences_usecase.dart';

part 'notification_preferences_state.dart';

/// Drives the two Settings notification toggles (NT-1 / NT-2).
///
/// [load] fetches the current toggles on open (`GET`). Each toggle applies
/// **optimistically** — the switch moves immediately, the `PATCH` fires in the
/// background, and on failure the change is reverted with a one-shot
/// [NotificationPreferencesState.saveError] the UI can surface.
class NotificationPreferencesCubit
    extends Cubit<NotificationPreferencesState> {
  NotificationPreferencesCubit(this._get, this._update)
    : super(const NotificationPreferencesState());

  final GetNotificationPreferencesUseCase _get;
  final UpdateNotificationPreferencesUseCase _update;

  Future<void> load() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, clearLoadError: true));
    try {
      final prefs = await _get();
      emit(state.copyWith(prefs: prefs, isLoading: false));
    } on ApiException catch (e) {
      emit(state.copyWith(isLoading: false, loadErrorMessage: e.message));
    } on Object {
      emit(state.copyWith(isLoading: false, loadErrorMessage: ''));
    }
  }

  Future<void> setNewMessages({required bool enabled}) =>
      _apply(newMessages: enabled);

  Future<void> setThreadReplies({required bool enabled}) =>
      _apply(threadReplies: enabled);

  Future<void> _apply({bool? newMessages, bool? threadReplies}) async {
    final current = state.prefs;
    if (current == null) return;

    // Optimistic: reflect the new position right away.
    final optimistic = current.copyWith(
      newMessages: newMessages,
      threadReplies: threadReplies,
    );
    emit(state.copyWith(prefs: optimistic));

    try {
      final saved = await _update(
        newMessages: newMessages,
        threadReplies: threadReplies,
      );
      emit(state.copyWith(prefs: saved));
    } on ApiException catch (e) {
      emit(state.copyWith(prefs: current, saveError: SaveError(e.message)));
    } on Object {
      emit(state.copyWith(prefs: current, saveError: const SaveError(null)));
    }
  }
}
