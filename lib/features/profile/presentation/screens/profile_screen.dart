import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_routes.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/utils/currency.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/profile/domain/entities/cycling_type.dart';
import 'package:ridemates/features/profile/domain/entities/listing_status.dart';
import 'package:ridemates/features/profile/domain/entities/profile_listing.dart';
import 'package:ridemates/features/profile/domain/entities/user_profile.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile/profile_bloc.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 15 — **Profile** (the Profile tab). The signed-in member's own
/// profile, backed by [ProfileBloc] (`GET /users/me` + `GET /users/{id}/listings`).
/// Pine header (avatar / ride type / area), a stats strip (Listings · Threads),
/// a Listings/Threads switcher, then the user's own listings grid.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(const ProfileEvent.started()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => switch (state.status) {
          ProfileStatus.loading => const _LoadingView(),
          ProfileStatus.failure => _ErrorView(
            message: state.errorMessage,
            onRetry: () =>
                context.read<ProfileBloc>().add(const ProfileEvent.refreshed()),
          ),
          ProfileStatus.success => _LoadedView(
            profile: state.profile!,
            listings: state.listings,
            tab: _tab,
            onTab: (i) => setState(() => _tab = i),
          ),
        },
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({
    required this.profile,
    required this.listings,
    required this.tab,
    required this.onTab,
  });

  final UserProfile profile;
  final List<ProfileListing> listings;
  final int tab;
  final ValueChanged<int> onTab;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PineHeader(profile: profile),
        _statsStrip(l10n),
        _tabSwitcher(l10n),
        Expanded(child: _tabContent(l10n)),
      ],
    );
  }

  Widget _statsStrip(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: _Stat(
              value: '${profile.listingCount}',
              label: l10n.listingsLabel,
            ),
          ),
          const SizedBox(height: 32, child: VerticalDivider(width: 1)),
          Expanded(
            child: _Stat(
              value: '${profile.threadCount}',
              label: l10n.threadsLabel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabSwitcher(AppLocalizations l10n) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          _TabLabel(
            label: l10n.listingsLabel,
            selected: tab == 0,
            onTap: () => onTab(0),
          ),
          const SizedBox(width: 24),
          _TabLabel(
            label: l10n.threadsLabel,
            selected: tab == 1,
            onTap: () => onTab(1),
          ),
        ],
      ),
    );
  }

  Widget _tabContent(AppLocalizations l10n) {
    if (tab == 1) {
      return _EmptyHint(text: l10n.profileThreadsEmpty);
    }
    if (listings.isEmpty) {
      return _EmptyHint(text: l10n.profileListingsEmpty);
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 16),
      itemCount: listings.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 13,
        crossAxisSpacing: 13,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, i) => _OwnListingCard(listing: listings[i]),
    );
  }
}

class _PineHeader extends StatelessWidget {
  const _PineHeader({required this.profile});

  final UserProfile profile;

  void _openSettings(BuildContext context) {
    unawaited(context.push(AppRoutes.settings));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final rideLabel = _cyclingLabel(l10n, profile.cyclingType);
    return ColoredBox(
      color: AppColors.pine,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(
                        Icons.bookmark_border_rounded,
                        color: AppColors.onPineMuted,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _openSettings(context),
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: AppColors.onPineMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                child: Row(
                  children: [
                    _Avatar(url: profile.avatarUrl),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.body.copyWith(
                              fontSize: 19,
                              height: 1,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              if (rideLabel != null) ...[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Color(0x26FFFFFF),
                                    borderRadius: AppRadii.pillRadius,
                                  ),
                                  child: Text(
                                    rideLabel,
                                    style: AppTypography.body.copyWith(
                                      fontSize: 11,
                                      height: 1,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFFCDEBDB),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                              ],
                              if (profile.displayArea != null)
                                Flexible(
                                  child: Text(
                                    profile.displayArea!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.body.copyWith(
                                      fontSize: 11.5,
                                      height: 1,
                                      color: AppColors.onPineMuted,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _cyclingLabel(AppLocalizations l10n, CyclingType? type) =>
      switch (type) {
        CyclingType.road => l10n.cyclingTypeRoad,
        CyclingType.mtb => l10n.cyclingTypeMtb,
        CyclingType.gravel => l10n.cyclingTypeGravel,
        CyclingType.folding => l10n.cyclingTypeFolding,
        CyclingType.casual => l10n.cyclingTypeCasual,
        null => null,
      };
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    const size = 72.0;
    const border = Border.fromBorderSide(
      BorderSide(color: Color(0x40FFFFFF), width: 3),
    );
    if (url == null) {
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1D5443),
          border: border,
        ),
        child: const Icon(
          Icons.person_rounded,
          color: AppColors.onPineMuted,
          size: 34,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle, border: border),
      child: ClipOval(
        child: Image.network(
          url!,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const ColoredBox(
            color: Color(0xFF1D5443),
            child: Icon(
              Icons.person_rounded,
              color: AppColors.onPineMuted,
              size: 34,
            ),
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.body.copyWith(
            fontSize: 18,
            height: 1,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.body.copyWith(
            fontSize: 11,
            height: 1,
            fontWeight: FontWeight.w600,
            color: AppColors.inkFaint,
          ),
        ),
      ],
    );
  }
}

class _TabLabel extends StatelessWidget {
  const _TabLabel({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 11),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? AppColors.leaf : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: AppTypography.body.copyWith(
            fontSize: 13.5,
            height: 1,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
            color: selected ? AppColors.pine : AppColors.inkFaint,
          ),
        ),
      ),
    );
  }
}

class _OwnListingCard extends StatelessWidget {
  const _OwnListingCard({required this.listing});

  final ProfileListing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sold = listing.status == ListingStatus.sold;
    return Material(
      color: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide(color: AppColors.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              _ListingPhoto(url: listing.photoUrl),
              if (sold)
                Positioned.fill(
                  child: ColoredBox(
                    color: const Color(0x73152018),
                    child: Center(
                      child: _badge(l10n.statusSold, AppColors.ink),
                    ),
                  ),
                )
              else
                Positioned(
                  top: 8,
                  left: 8,
                  child: _badge(l10n.statusActive, AppColors.leaf),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatIdr(listing.priceIdr),
                  style: AppTypography.body.copyWith(
                    fontSize: 13,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    color: sold ? AppColors.inkFaint : AppColors.pine,
                    decoration: sold
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  listing.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadii.pillRadius,
      ),
      child: Text(
        text,
        style: AppTypography.body.copyWith(
          fontSize: 9.5,
          height: 1,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ListingPhoto extends StatelessWidget {
  const _ListingPhoto({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null) return const HatchPlaceholder(height: 84);
    return Image.network(
      url!,
      height: 84,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => const HatchPlaceholder(height: 84),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTypography.body.copyWith(color: AppColors.inkMuted),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ColoredBox(
          color: AppColors.pine,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(22, 44, 22, 24),
              child: AppShimmer(
                child: Row(
                  children: [
                    SkeletonBox(width: 72, height: 72, shape: BoxShape.circle),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonBox(width: 140, height: 18),
                          SizedBox(height: 10),
                          SkeletonBox(width: 100, height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: AppShimmer(
            child: GridView.count(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 16),
              crossAxisCount: 2,
              mainAxisSpacing: 13,
              crossAxisSpacing: 13,
              childAspectRatio: 0.82,
              children: List.generate(
                4,
                (_) => const SkeletonBox(
                  height: double.infinity,
                  borderRadius: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry, this.message});

  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.cloud_off_rounded,
                size: 44,
                color: AppColors.inkFaint,
              ),
              const SizedBox(height: 16),
              Text(
                message ?? l10n.genericErrorMessage,
                textAlign: TextAlign.center,
                style: AppTypography.body.copyWith(color: AppColors.inkMuted),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: onRetry,
                child: Text(l10n.retryButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
