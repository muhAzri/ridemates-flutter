import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/forum/presentation/widgets/thread_card.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 09 — **Forum threads.** The Forum tab: a "Community" header, search,
/// topic filter chips (Latest / Rides / Tech / Gear), then a scrollable list of
/// thread cards.
class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  int _selectedFilter = 0;

  /// Topic taxonomy labels are localized; thread bodies are sample content.
  String _topicLabel(AppLocalizations l10n, ThreadTopic topic) =>
      switch (topic) {
        ThreadTopic.rides => l10n.topicRides,
        ThreadTopic.tech => l10n.topicTech,
        ThreadTopic.gear => l10n.topicGear,
      };

  List<String> _filters(AppLocalizations l10n) => [
    l10n.filterLatest,
    l10n.topicRides,
    l10n.topicTech,
    l10n.topicGear,
  ];

  List<ThreadSummary> _threads(AppLocalizations l10n) => [
    ThreadSummary(
      topic: ThreadTopic.rides,
      topicLabel: _topicLabel(l10n, ThreadTopic.rides),
      author: 'Maya',
      age: '2h',
      title: 'Sunday Puncak ride — anyone joining? '
          'Rolling out 5am from Jaksel.',
      upvotes: 34,
      comments: 18,
    ),
    ThreadSummary(
      topic: ThreadTopic.tech,
      topicLabel: _topicLabel(l10n, ThreadTopic.tech),
      author: 'Rian',
      age: '5h',
      title: 'Tubeless setup keeps burping on rough roads — '
          'what pressure are you running?',
      upvotes: 21,
      comments: 27,
    ),
    ThreadSummary(
      topic: ThreadTopic.gear,
      topicLabel: _topicLabel(l10n, ThreadTopic.gear),
      author: 'Dewi',
      age: '1d',
      title: 'Best entry-level gravel bike under 15jt? '
          'First proper bike, mostly city + light trails.',
      upvotes: 52,
      comments: 41,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final filters = _filters(l10n);
    final threads = _threads(l10n);
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.forumTitle,
                  style: AppTypography.display.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 12),
                SearchFieldButton(hint: l10n.searchDiscussionsHint),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) => BrandChip(
                label: filters[i],
                selected: i == _selectedFilter,
                onTap: () => setState(() => _selectedFilter = i),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              itemCount: threads.length,
              separatorBuilder: (_, _) => const SizedBox(height: 11),
              itemBuilder: (context, i) => ThreadCard(thread: threads[i]),
            ),
          ),
        ],
      ),
    );
  }
}
