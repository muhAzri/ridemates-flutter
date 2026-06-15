import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/chat/presentation/widgets/chat_list_tile.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 11 — **Chats list.** The Chats tab: a "Chats" header with an Edit
/// (manage) action, search, buyer/seller filter chips, then the conversation
/// list. Each row carries its listing context; unread rows are emphasised.
class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  static const _chats = <ChatPreview>[
    ChatPreview(
      name: 'Budi Santoso',
      message: 'Saturday morning works 👍',
      time: '2m',
      listingTag: 'Shimano 105',
      unreadCount: 2,
      online: true,
    ),
    ChatPreview(
      name: 'Maya Putri',
      message: 'Is the carbon set still up?',
      time: '1h',
      listingTag: 'Wheelset',
      listingTone: ChatTagTone.clay,
    ),
    ChatPreview(
      name: 'Rian Hidayat',
      message: 'You: Thanks, see you at Blok M!',
      time: 'Yesterday',
    ),
    ChatPreview(
      name: 'Dewi Lestari',
      message: 'Deal, terima kasih 🙏',
      time: '2d',
      listingTag: 'Garmin 530',
    ),
    ChatPreview(
      name: 'Agus Wijaya',
      message: 'You: Masih nego? 😄',
      time: '5d',
    ),
  ];

  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final unread = _chats.where((c) => c.isUnread).length;
    final filters = [
      l10n.filterAll,
      l10n.filterUnread,
      l10n.filterBuying,
      l10n.filterSelling,
    ];

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.chatsTitle,
                    style: AppTypography.display.copyWith(fontSize: 22),
                  ),
                ),
                _editButton(l10n),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: SearchFieldButton(hint: l10n.searchChatsHint),
          ),
          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 7),
              itemBuilder: (context, i) => BrandChip(
                label: filters[i],
                selected: i == _selectedFilter,
                count: i == 1 && unread > 0 ? unread : null,
                onTap: () => setState(() => _selectedFilter = i),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              itemCount: _chats.length,
              separatorBuilder: (context, i) =>
                  SizedBox(height: _chats[i].isUnread ? 8 : 4),
              itemBuilder: (context, i) => ChatListTile(chat: _chats[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editButton(AppLocalizations l10n) {
    return Material(
      color: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadii.fieldRadius,
        side: BorderSide(color: AppColors.borderSubtle),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: AppRadii.fieldRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SizedBox(
            height: 38,
            child: Row(
              children: [
                const Icon(Icons.edit_outlined, size: 15, color: AppColors.ink),
                const SizedBox(width: 6),
                Text(
                  l10n.editButton,
                  style: AppTypography.body.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
