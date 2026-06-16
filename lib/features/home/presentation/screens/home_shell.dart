import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/features/chat/presentation/screens/chats_list_screen.dart';
import 'package:ridemates/features/forum/presentation/screens/forum_screen.dart';
import 'package:ridemates/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:ridemates/features/home/presentation/widgets/home_tab.dart';
import 'package:ridemates/features/marketplace/presentation/screens/browse_screen.dart';
import 'package:ridemates/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:ridemates/features/profile/presentation/screens/profile_screen.dart';
import 'package:ridemates/l10n/l10n.dart';

/// The post-auth home shell. Hosts the four primary destinations — Browse
/// (Market), Forum, Chats and Profile — behind a persistent bottom nav with a
/// raised create button. Tab state is preserved across switches via
/// [IndexedStack].
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  HomeTab _current = HomeTab.market;

  @override
  void initState() {
    super.initState();
    // Warm the shared profile store once on entering the app — Profile,
    // Settings et al. then read it without each firing `/me`.
    unawaited(context.read<CurrentUserCubit>().ensureLoaded());
  }

  static const _tabs = <HomeTab>[
    HomeTab.market,
    HomeTab.forum,
    HomeTab.chats,
    HomeTab.profile,
  ];

  static const _pages = <Widget>[
    BrowseScreen(),
    ForumScreen(),
    ChatsListScreen(),
    ProfileScreen(),
  ];

  void _onCreate() {
    // Context-aware create action. The dedicated create flows (new listing /
    // new thread) aren't built yet, so surface intent for now.
    final l10n = context.l10n;
    final what = switch (_current) {
      HomeTab.forum => l10n.createThreadAction,
      _ => l10n.createListingAction,
    };
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.comingSoonAction(what))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: IndexedStack(
        index: _tabs.indexOf(_current),
        children: _pages,
      ),
      bottomNavigationBar: HomeBottomNav(
        current: _current,
        chatsHasBadge: true,
        onSelected: (tab) => setState(() => _current = tab),
        onCreate: _onCreate,
      ),
    );
  }
}
