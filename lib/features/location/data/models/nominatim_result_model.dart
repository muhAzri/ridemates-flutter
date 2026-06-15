/// Minimal projection of an OSM Nominatim reverse-geocode response.
///
/// Nominatim returns an `address` object whose keys vary by place; for the
/// Indonesian market the kecamatan-level name usually lands in `suburb`,
/// `city_district` or `village`. We resolve the best available label and treat
/// everything as optional (the geocoder is best-effort — contract R14).
class NominatimResultModel {
  const NominatimResultModel({this.displayArea, this.areaLevel});

  factory NominatimResultModel.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    if (address is! Map<String, dynamic>) {
      return const NominatimResultModel();
    }

    // Preference order from finest (kecamatan-ish) to coarser fallbacks.
    const candidates = <String>[
      'suburb',
      'city_district',
      'village',
      'town',
      'municipality',
      'subdistrict',
      'county',
      'city',
    ];
    for (final key in candidates) {
      final value = address[key];
      if (value is String && value.isNotEmpty) {
        return NominatimResultModel(displayArea: value, areaLevel: 'kecamatan');
      }
    }
    return const NominatimResultModel();
  }

  final String? displayArea;
  final String? areaLevel;
}
