import 'package:ridemates/features/profile/domain/entities/listing_status.dart';

/// A listing as shown on the profile's Listings grid (screen 15). A trimmed
/// projection of the contract §17.2 ListingCard — only what the grid renders.
///
/// Carries an area label + price only; no coordinates (LP-2).
class ProfileListing {
  const ProfileListing({
    required this.id,
    required this.title,
    required this.priceIdr,
    required this.status,
    this.photoUrl,
    this.displayArea,
  });

  final String id;
  final String title;

  /// Whole rupiah (no minor unit); formatted for display client-side.
  final int priceIdr;
  final ListingStatus status;

  /// First photo URL, or null → render the placeholder.
  final String? photoUrl;
  final String? displayArea;
}
