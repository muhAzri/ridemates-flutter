import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';

/// The listing-context tag tone shown on a conversation (which listing the
/// chat is about). Mirrors the marketplace tag colours.
enum ChatTagTone { leaf, clay }

/// Presentation model for a row in the Chats list.
///
/// In RideMates a conversation is always anchored to a context — usually a
/// marketplace [listingTag] — because chats are started from a listing or a
/// forum profile, never cold (FSD MS-3).
class ChatPreview {
  const ChatPreview({
    required this.name,
    required this.message,
    required this.time,
    this.listingTag,
    this.listingTone = ChatTagTone.leaf,
    this.unreadCount = 0,
    this.online = false,
  });

  final String name;
  final String message;

  /// Relative timestamp, e.g. "2m", "1h", "Yesterday".
  final String time;
  final String? listingTag;
  final ChatTagTone listingTone;
  final int unreadCount;
  final bool online;

  bool get isUnread => unreadCount > 0;
}

/// A single conversation row. Unread chats are emphasised as a bordered white
/// card with a leaf unread badge; read chats sit flat on the paper background.
class ChatListTile extends StatelessWidget {
  const ChatListTile({required this.chat, this.onTap, super.key});

  final ChatPreview chat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: chat.isUnread ? AppColors.surface : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.tileRadius,
        side: chat.isUnread
            ? const BorderSide(color: AppColors.borderSubtle)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.tileRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
          child: Row(
            children: [
              _avatar(),
              const SizedBox(width: 12),
              Expanded(child: _body()),
              if (chat.unreadCount > 0) ...[
                const SizedBox(width: 8),
                _unreadBadge(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatar() {
    return SizedBox(
      width: 46,
      height: 46,
      child: Stack(
        children: [
          const HatchPlaceholder(
            height: 46,
            borderRadius: BorderRadius.all(Radius.circular(23)),
          ),
          if (chat.online)
            Positioned(
              bottom: 1,
              right: 1,
              child: Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  color: AppColors.leaf,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _body() {
    final timeColor = chat.isUnread ? AppColors.leaf : AppColors.inkFaint;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                chat.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.body.copyWith(
                  fontSize: 14,
                  height: 1,
                  fontWeight:
                      chat.isUnread ? FontWeight.w800 : FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              chat.time,
              style: AppTypography.body.copyWith(
                fontSize: 11,
                height: 1,
                fontWeight: chat.isUnread ? FontWeight.w700 : FontWeight.w600,
                color: timeColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            if (chat.listingTag != null) ...[
              _listingTag(),
              const SizedBox(width: 6),
            ],
            Expanded(
              child: Text(
                chat.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.body.copyWith(
                  fontSize: 12.5,
                  height: 1,
                  fontWeight: chat.isUnread ? FontWeight.w600 : FontWeight.w500,
                  color: chat.isUnread ? AppColors.ink : AppColors.inkMuted,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _listingTag() {
    final tag = chat.listingTag!;
    return chat.listingTone == ChatTagTone.clay
        ? BrandTag.clay(tag)
        : BrandTag.leaf(tag);
  }

  Widget _unreadBadge() {
    return Container(
      width: 21,
      height: 21,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.leaf,
        shape: BoxShape.circle,
      ),
      child: Text(
        '${chat.unreadCount}',
        style: AppTypography.body.copyWith(
          fontSize: 11,
          height: 1,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
