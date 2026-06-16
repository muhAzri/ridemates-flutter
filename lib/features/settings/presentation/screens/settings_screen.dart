import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_routes.dart';
import 'package:ridemates/core/storage/token_storage.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:ridemates/features/settings/presentation/cubit/notification_preferences_cubit.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 18 — **Settings**. A grouped list of account, privacy, notification
/// and support controls, plus a sign-out action.
///
/// Account/privacy values come from the shared, persisted [CurrentUserCubit]
/// (`/me`); the notification toggles are backed by [NotificationPreferencesCubit]
/// (`GET/PATCH /me/notification-preferences`, optimistic). "Location & area"
/// opens the set-location screen. The remaining detail rows route to dedicated
/// screens not yet built.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  /// Row divider tint — a touch warmer than [AppColors.borderSubtle].
  static const _divider = Color(0xFFF2EEE4);

  /// Fresh per screen open; fetches the toggles immediately.
  late final NotificationPreferencesCubit _notif =
      getIt<NotificationPreferencesCubit>()..load();

  /// The real app version (e.g. `v1.0.0`) from the platform package metadata,
  /// never hard-coded. Null when unavailable (e.g. in tests) — the badge is
  /// then omitted.
  String? get _versionLabel => getIt.isRegistered<PackageInfo>()
      ? 'v${getIt<PackageInfo>().version}'
      : null;

  @override
  void dispose() {
    unawaited(_notif.close());
    super.dispose();
  }

  Future<void> _logout() async {
    await context.read<CurrentUserCubit>().signOut();
    await getIt<TokenStorage>().clearTokens();
    if (mounted) context.go(AppRoutes.login);
  }

  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }

  /// Opens the set-location screen. It returns here (pop) and refreshes the
  /// shared profile so the area below updates — see SetLocationScreen.
  void _openSetLocation() {
    unawaited(context.push(AppRoutes.setLocation));
  }

  void _onSaveError(BuildContext context, SaveError error) {
    final message = (error.message?.isNotEmpty ?? false)
        ? error.message!
        : context.l10n.genericErrorMessage;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final notSet = l10n.settingsValueNotSet;
    final user = context.select<CurrentUserCubit, UserProfile?>(
      (c) => c.state.user,
    );

    return BlocProvider<NotificationPreferencesCubit>.value(
      value: _notif,
      child: BlocListener<NotificationPreferencesCubit,
          NotificationPreferencesState>(
        listenWhen: (p, c) => c.saveError != null && p.saveError != c.saveError,
        listener: (context, state) => _onSaveError(context, state.saveError!),
        child: Scaffold(
          backgroundColor: AppColors.paper,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(title: l10n.settingsTitle, onBack: _back),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(18, 2, 18, 24),
                    children: [
                      // ── Account ──────────────────────────────────────────
                      _SectionLabel(l10n.settingsSectionAccount),
                      _Group(
                        children: [
                          _NavRow(
                            icon: Icons.mail_outline_rounded,
                            label: l10n.settingsEmailLabel,
                            value: user?.email ?? notSet,
                          ),
                          _NavRow(
                            icon: Icons.lock_outline_rounded,
                            label: l10n.settingsChangePassword,
                          ),
                        ],
                      ),
                      // ── Privacy & Safety ─────────────────────────────────
                      _SectionLabel(l10n.settingsSectionPrivacy),
                      _Group(
                        children: [
                          _NavRow(
                            icon: Icons.place_outlined,
                            label: l10n.settingsLocationArea,
                            value: user?.displayArea ?? notSet,
                            onTap: _openSetLocation,
                          ),
                          _NavRow(
                            icon: Icons.block_rounded,
                            label: l10n.settingsBlockedUsers,
                          ),
                        ],
                      ),
                      // ── Notifications ────────────────────────────────────
                      _SectionLabel(l10n.settingsSectionNotifications),
                      const _NotificationsGroup(),
                      // ── Support ──────────────────────────────────────────
                      _SectionLabel(l10n.settingsSectionSupport),
                      _Group(
                        children: [
                          _NavRow(
                            icon: Icons.sms_outlined,
                            iconColor: AppColors.clay,
                            label: l10n.settingsSendFeedback,
                          ),
                          _NavRow(
                            icon: Icons.auto_awesome_outlined,
                            iconColor: AppColors.clay,
                            label: l10n.settingsWhatsNew,
                            trailing: switch (_versionLabel) {
                              final v? => _VersionBadge(v),
                              null => null,
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      _LogoutRow(label: l10n.settingsLogOut, onTap: _logout),
                    ],
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

/// The two notification toggles, driven by [NotificationPreferencesCubit].
/// Until the `GET` resolves the switches show the opted-in default and ignore
/// taps; once loaded each tap applies optimistically.
class _NotificationsGroup extends StatelessWidget {
  const _NotificationsGroup();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<NotificationPreferencesCubit,
        NotificationPreferencesState>(
      builder: (context, state) {
        final cubit = context.read<NotificationPreferencesCubit>();
        final prefs = state.prefs;
        final ready = state.hasLoaded;
        return _Group(
          children: [
            _ToggleRow(
              label: l10n.settingsNotifNewMessages,
              value: prefs?.newMessages ?? true,
              onChanged: ready
                  ? (v) => cubit.setNewMessages(enabled: v)
                  : null,
            ),
            _ToggleRow(
              label: l10n.settingsNotifReplies,
              value: prefs?.threadReplies ?? true,
              onChanged: ready
                  ? (v) => cubit.setThreadReplies(enabled: v)
                  : null,
            ),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 20, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: AppTypography.body.copyWith(
              fontSize: 20,
              height: 1,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      child: Text(
        text.toUpperCase(),
        style: AppTypography.body.copyWith(
          fontSize: 11,
          height: 1,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.77,
          color: AppColors.inkFaint,
        ),
      ),
    );
  }
}

/// A white rounded card grouping a set of rows, with hairline dividers between
/// them. Mirrors the design's grouped-list cards (radius 14, subtle border).
class _Group extends StatelessWidget {
  const _Group({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        rows.add(
          const Divider(
            height: 1,
            thickness: 1,
            color: _SettingsScreenState._divider,
          ),
        );
      }
      rows.add(children[i]);
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: rows),
    );
  }
}

/// A tappable settings row: leading icon, label, optional trailing value or
/// widget, and a chevron affordance.
class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.icon,
    required this.label,
    this.value,
    this.trailing,
    this.iconColor = AppColors.leaf,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? value;
  final Widget? trailing;
  final Color iconColor;

  /// Tap destination. Null rows are visual placeholders whose detail screen
  /// isn't built yet — still tappable (ripple) but inert.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTypography.body.copyWith(
                  fontSize: 13.5,
                  height: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  value!,
                  style: AppTypography.body.copyWith(
                    fontSize: 12,
                    height: 1,
                    color: AppColors.inkFaint,
                  ),
                ),
              ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: trailing,
              ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: Color(0xFFC6CFC9),
            ),
          ],
        ),
      ),
    );
  }
}

/// A settings row whose trailing control is an on/off toggle (no leading icon,
/// matching the Notifications group in the design).
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;

  /// Null while preferences are still loading — the row is then inert.
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final onChanged = this.onChanged;
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: AppTypography.body.copyWith(
                  fontSize: 13.5,
                  height: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _Toggle(value: value),
          ],
        ),
      ),
    );
  }
}

/// The brand pill toggle (42×25, leaf when on, white knob) from the design
/// system — built by hand so it matches the mock exactly.
class _Toggle extends StatelessWidget {
  const _Toggle({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOut,
      width: 42,
      height: 25,
      decoration: BoxDecoration(
        color: value ? AppColors.leaf : const Color(0xFFD6D2C7),
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            width: 19,
            height: 19,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class _VersionBadge extends StatelessWidget {
  const _VersionBadge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: const BoxDecoration(
        color: AppColors.mint,
        borderRadius: AppRadii.pillRadius,
      ),
      child: Text(
        label,
        style: AppTypography.body.copyWith(
          fontSize: 10.5,
          height: 1,
          fontWeight: FontWeight.w700,
          color: AppColors.onMint,
        ),
      ),
    );
  }
}

class _LogoutRow extends StatelessWidget {
  const _LogoutRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.field),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Center(
          child: Text(
            label,
            style: AppTypography.body.copyWith(
              fontSize: 13.5,
              height: 1,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
        ),
      ),
    );
  }
}
