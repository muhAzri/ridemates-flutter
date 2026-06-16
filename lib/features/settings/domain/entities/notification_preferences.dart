import 'package:equatable/equatable.dart';

/// The signed-in user's notification toggles (contract §14 / R6,
/// `GET/PATCH /me/notification-preferences`).
///
/// Two switches on screen 18 Settings: [newMessages] (NT-1) and
/// [threadReplies] (NT-2). They gate in-app notification delivery in the MVP.
class NotificationPreferences extends Equatable {
  const NotificationPreferences({
    required this.newMessages,
    required this.threadReplies,
  });

  /// Notify on a new direct message (NT-1).
  final bool newMessages;

  /// Notify on a reply to one of my threads (NT-2).
  final bool threadReplies;

  NotificationPreferences copyWith({bool? newMessages, bool? threadReplies}) =>
      NotificationPreferences(
        newMessages: newMessages ?? this.newMessages,
        threadReplies: threadReplies ?? this.threadReplies,
      );

  @override
  List<Object?> get props => [newMessages, threadReplies];
}
