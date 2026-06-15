import 'package:ridemates/features/location/domain/entities/saved_location.dart';
import 'package:ridemates/features/location/domain/repositories/location_repository.dart';

class SetMyLocationUseCase {
  const SetMyLocationUseCase(this._repository);

  final LocationRepository _repository;

  Future<SavedLocation> call({
    required double lat,
    required double lng,
    String? displayArea,
    String? areaLevel,
  }) => _repository.setMyLocation(
    lat: lat,
    lng: lng,
    displayArea: displayArea,
    areaLevel: areaLevel,
  );
}
