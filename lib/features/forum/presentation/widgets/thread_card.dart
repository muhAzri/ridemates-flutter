import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';

/// The colour family for a thread's topic tag.
enum ThreadTopic { rides, tech, gear }

/// Presentation model for a forum thread row.
class ThreadSummary {
  const ThreadSummary({
    required this.topic,
    required this.topicLabel,
    required this.author,
    required this.age,
    required this.title,
    required this.upvotes,
    required this.comments,
  });

  final ThreadTopic topic;
  final String topicLabel;
  final String author;

  /// Relative age, e.g. "2h", "1d".
  final String age;
  final String title;
  final int upvotes;
  final int comments;
}

/// A forum thread card — topic tag + author · age, the title, then upvote and
/// comment counts.
class ThreadCard extends StatelessWidget {
  const ThreadCard({required this.thread, this.onTap, super.key});

  final ThreadSummary thread;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadii.tileRadius,
        side: BorderSide(color: AppColors.borderSubtle),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.tileRadius,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _topicTag(),
                  const SizedBox(width: 8),
                  Text(
                    '${thread.author} · ${thread.age}',
                    style: AppTypography.caption.copyWith(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                thread.title,
                style: AppTypography.body.copyWith(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 9),
              Row(
                children: [
                  _metric(
                    Icons.arrow_upward_rounded,
                    thread.upvotes,
                    AppColors.leaf,
                  ),
                  const SizedBox(width: 16),
                  _metric(
                    Icons.chat_bubble_outline_rounded,
                    thread.comments,
                    AppColors.inkFaint,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topicTag() {
    switch (thread.topic) {
      case ThreadTopic.rides:
        return BrandTag.leaf(thread.topicLabel);
      case ThreadTopic.gear:
        return BrandTag.clay(thread.topicLabel);
      case ThreadTopic.tech:
        return BrandTag(
          label: thread.topicLabel,
          background: const Color(0xFFEEF0FE),
          foreground: const Color(0xFF4B57B0),
        );
    }
  }

  Widget _metric(IconData icon, int value, Color iconColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: iconColor),
        const SizedBox(width: 5),
        Text(
          '$value',
          style: AppTypography.body.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1,
            color: AppColors.inkMuted,
          ),
        ),
      ],
    );
  }
}
