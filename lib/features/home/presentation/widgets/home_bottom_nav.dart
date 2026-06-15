import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/features/home/presentation/widgets/home_tab.dart';
import 'package:ridemates/l10n/l10n.dart';

/// The home shell's bottom navigation — four tabs around a raised leaf "+"
/// create button. The active tab is tinted [AppColors.leaf]; inactive items
/// are [AppColors.inkFaint]. Mirrors the design's bottom tab bar across the
/// Browse / Forum / Chats / Profile screens.
class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({
    required this.current,
    required this.onSelected,
    required this.onCreate,
    this.chatsHasBadge = false,
    super.key,
  });

  final HomeTab current;
  final ValueChanged<HomeTab> onSelected;

  /// Tapped the raised center "+" — a context-aware create action.
  final VoidCallback onCreate;

  /// Shows the unread dot over the Chats tab.
  final bool chatsHasBadge;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      padding: EdgeInsets.only(top: 9, bottom: bottomInset),
      child: SizedBox(
        height: 57,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Row(
              children: [
                _NavItem(
                  icon: Icons.storefront_outlined,
                  label: l10n.navMarket,
                  selected: current == HomeTab.market,
                  onTap: () => onSelected(HomeTab.market),
                ),
                _NavItem(
                  icon: Icons.forum_outlined,
                  label: l10n.navForum,
                  selected: current == HomeTab.forum,
                  onTap: () => onSelected(HomeTab.forum),
                ),
                const Expanded(child: SizedBox()),
                _NavItem(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: l10n.navChats,
                  selected: current == HomeTab.chats,
                  showBadge: chatsHasBadge,
                  onTap: () => onSelected(HomeTab.chats),
                ),
                _NavItem(
                  icon: Icons.person_outline_rounded,
                  label: l10n.navProfile,
                  selected: current == HomeTab.profile,
                  onTap: () => onSelected(HomeTab.profile),
                ),
              ],
            ),
            Positioned(
              top: -16,
              child: _CreateButton(onTap: onCreate),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.showBadge = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool showBadge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.leaf : AppColors.inkFaint;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 22, color: color),
                if (showBadge)
                  Positioned(
                    top: -3,
                    right: -3,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.clay,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surface,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.body.copyWith(
                fontSize: 9.5,
                height: 1,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.leaf,
      borderRadius: AppRadii.tileRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.tileRadius,
        child: Ink(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: AppColors.leaf,
            borderRadius: AppRadii.tileRadius,
            boxShadow: AppShadows.button,
          ),
          child: const Icon(Icons.add_rounded, size: 26, color: Colors.white),
        ),
      ),
    );
  }
}
