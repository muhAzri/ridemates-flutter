import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_routes.dart';
import 'package:ridemates/core/storage/token_storage.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Post-auth landing placeholder. Replace with the real Browse feed (screen 05)
/// once it's built.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await getIt<TokenStorage>().clearTokens();
    if (context.mounted) context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: l10n.logoutButton,
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppLogo(size: 96),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.homeComingSoonMessage,
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(color: AppColors.inkMuted),
            ),
          ],
        ),
      ),
    );
  }
}
