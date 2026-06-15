import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_routes.dart';
import 'package:ridemates/core/storage/token_storage.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 15 — **Profile** (the Profile tab). The signed-in member's own
/// profile: a pine header with avatar / ride type / area, a stats strip
/// (Listings · Threads · Rating), a Listings/Threads switcher, then a grid of
/// the user's own listings with Active / Sold states.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _listings = <_OwnListing>[
    _OwnListing(title: 'Shimano 105', price: 'Rp 2.450.000'),
    _OwnListing(title: 'Bib shorts — L', price: 'Rp 850.000', sold: true),
  ];

  int _tab = 0;

  Future<void> _logout() async {
    await getIt<TokenStorage>().clearTokens();
    if (mounted) context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _PineHeader(onLogout: _logout),
        _statsStrip(),
        _tabSwitcher(),
        Expanded(child: _tabContent()),
      ],
    );
  }

  Widget _statsStrip() {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      child: Row(
        children: [
          Expanded(child: _Stat(value: '8', label: l10n.listingsLabel)),
          _divider(),
          Expanded(child: _Stat(value: '23', label: l10n.threadsLabel)),
        ],
      ),
    );
  }

  Widget _divider() =>
      const SizedBox(height: 32, child: VerticalDivider(width: 1));

  Widget _tabSwitcher() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        children: [
          _TabLabel(
            label: context.l10n.listingsLabel,
            selected: _tab == 0,
            onTap: () => setState(() => _tab = 0),
          ),
          const SizedBox(width: 24),
          _TabLabel(
            label: context.l10n.threadsLabel,
            selected: _tab == 1,
            onTap: () => setState(() => _tab = 1),
          ),
        ],
      ),
    );
  }

  Widget _tabContent() {
    if (_tab == 1) {
      return Center(
        child: Text(
          context.l10n.profileThreadsEmpty,
          style: AppTypography.body.copyWith(color: AppColors.inkMuted),
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 16),
      itemCount: _listings.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 13,
        crossAxisSpacing: 13,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, i) => _OwnListingCard(listing: _listings[i]),
    );
  }
}

class _PineHeader extends StatelessWidget {
  const _PineHeader({required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
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
                      onPressed: onLogout,
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
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF1D5443),
                        border: Border.all(
                          color: const Color(0x40FFFFFF),
                          width: 3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adi Pratama',
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
                                  'Road',
                                  style: AppTypography.body.copyWith(
                                    fontSize: 11,
                                    height: 1,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFCDEBDB),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Kebayoran Baru',
                                style: AppTypography.body.copyWith(
                                  fontSize: 11.5,
                                  height: 1,
                                  color: AppColors.onPineMuted,
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

class _OwnListing {
  const _OwnListing({
    required this.title,
    required this.price,
    this.sold = false,
  });

  final String title;
  final String price;
  final bool sold;
}

class _OwnListingCard extends StatelessWidget {
  const _OwnListingCard({required this.listing});

  final _OwnListing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
              const HatchPlaceholder(height: 84),
              if (listing.sold)
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
                  listing.price,
                  style: AppTypography.body.copyWith(
                    fontSize: 13,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    color: listing.sold ? AppColors.inkFaint : AppColors.pine,
                    decoration: listing.sold
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
