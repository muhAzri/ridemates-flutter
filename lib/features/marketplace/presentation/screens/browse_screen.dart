import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/marketplace/presentation/widgets/listing_card.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 05 — **Browse, nearby first.** The Market tab: an area-scoped
/// marketplace feed sorted by proximity. Header (area selector + alerts),
/// search + filter, category chips, a "Nearest to you / within radius" band,
/// then the listing grid.
///
/// Listings expose only an area label + approximate distance, honouring the
/// location-privacy invariant (FSD LP-1).
class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<String> _categories(AppLocalizations l10n) => [
    l10n.categoryAll,
    l10n.categoryBikes,
    l10n.categoryParts,
    l10n.categoryWheels,
    l10n.categoryApparel,
  ];

  static const _listings = <ListingSummary>[
    ListingSummary(
      title: 'Shimano 105 R7000',
      price: 'Rp 2.450.000',
      area: 'Cilandak',
      distanceKm: 1.4,
      imageLabel: 'groupset',
      wishlisted: true,
    ),
    ListingSummary(
      title: 'Trek Marlin 7 (2022)',
      price: 'Rp 6.900.000',
      area: 'Kebayoran',
      distanceKm: 2.1,
      imageLabel: 'bike',
    ),
    ListingSummary(
      title: 'Carbon Wheelset 700c',
      price: 'Rp 4.200.000',
      area: 'Setiabudi',
      distanceKm: 3.8,
      imageLabel: 'wheels',
    ),
    ListingSummary(
      title: 'Garmin Edge 530',
      price: 'Rp 1.800.000',
      area: 'Pasar Minggu',
      distanceKm: 5.2,
      imageLabel: 'computer',
    ),
  ];

  int _selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _header(),
          _searchRow(),
          _categoryChips(),
          _nearbyBand(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              itemCount: _listings.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 0.78,
                  ),
              itemBuilder: (context, i) => ListingCard(listing: _listings[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.browseEyebrow,
                  style: AppTypography.body.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.inkFaint,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: AppColors.leaf,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Kebayoran Baru',
                      style: AppTypography.body.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        height: 1,
                        letterSpacing: -0.16,
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                  ],
                ),
              ],
            ),
          ),
          _IconBox(
            icon: Icons.notifications_none_rounded,
            hasBadge: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _searchRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: SearchFieldButton(hint: context.l10n.searchGearHint),
          ),
          const SizedBox(width: 10),
          Material(
            color: AppColors.pine,
            borderRadius: AppRadii.fieldRadius,
            child: InkWell(
              onTap: () {},
              borderRadius: AppRadii.fieldRadius,
              child: const SizedBox(
                width: 44,
                height: 42,
                child: Icon(Icons.tune_rounded, size: 19, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryChips() {
    final categories = _categories(context.l10n);
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) => BrandChip(
          label: categories[i],
          selected: i == _selectedCategory,
          onTap: () => setState(() => _selectedCategory = i),
        ),
      ),
    );
  }

  Widget _nearbyBand() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.l10n.nearestToYou,
            style: AppTypography.body.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: const BoxDecoration(
              color: AppColors.mint,
              borderRadius: AppRadii.pillRadius,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.withinKm(25),
                  style: AppTypography.body.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    color: AppColors.onMint,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 14,
                  color: AppColors.onMint,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.icon, this.hasBadge = false, this.onTap});

  final IconData icon;
  final bool hasBadge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadii.fieldRadius,
        side: BorderSide(color: AppColors.borderSubtle),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.fieldRadius,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, size: 20, color: AppColors.ink),
              if (hasBadge)
                Positioned(
                  top: 9,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.clay,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surface, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
