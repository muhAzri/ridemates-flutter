import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';

/// Lightweight presentation model for a marketplace listing tile.
///
/// Per the location-privacy invariant (FSD LP-1), a listing only ever carries
/// an *area label* (kecamatan) plus an approximate [distanceKm] — never precise
/// coordinates.
class ListingSummary {
  const ListingSummary({
    required this.title,
    required this.price,
    required this.area,
    required this.distanceKm,
    this.imageLabel,
    this.wishlisted = false,
  });

  final String title;

  /// Pre-formatted price string (e.g. "Rp 2.450.000").
  final String price;

  /// Approximate-area label, e.g. "Cilandak".
  final String area;
  final double distanceKm;
  final String? imageLabel;
  final bool wishlisted;
}

/// A single listing in the Browse grid — hatched photo with a wishlist heart,
/// price, title, and area · distance meta.
class ListingCard extends StatelessWidget {
  const ListingCard({
    required this.listing,
    this.onTap,
    this.onWishlistTap,
    super.key,
  });

  final ListingSummary listing;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadii.tileRadius,
        side: BorderSide(color: AppColors.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                HatchPlaceholder(label: listing.imageLabel, height: 92),
                Positioned(
                  top: 8,
                  right: 8,
                  child: _WishlistButton(
                    active: listing.wishlisted,
                    onTap: onWishlistTap,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 9, 10, 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.price,
                    style: AppTypography.body.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      height: 1,
                      color: AppColors.pine,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    listing.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${listing.area} · '
                    '${listing.distanceKm.toStringAsFixed(1)} km',
                    style: AppTypography.caption.copyWith(fontSize: 10.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistButton extends StatelessWidget {
  const _WishlistButton({required this.active, this.onTap});

  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          color: Color(0xEBFFFFFF),
          shape: BoxShape.circle,
        ),
        child: Icon(
          active ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: 13,
          color: active ? AppColors.clay : AppColors.ink,
        ),
      ),
    );
  }
}
