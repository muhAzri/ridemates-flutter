import 'package:ridemates/features/location/data/datasources/location_remote_data_source.dart';
import 'package:ridemates/features/location/data/datasources/nominatim_data_source.dart';
import 'package:ridemates/features/location/data/services/location_mapper.dart';
import 'package:ridemates/features/location/domain/entities/resolved_area.dart';
import 'package:ridemates/features/location/domain/entities/saved_location.dart';
import 'package:ridemates/features/location/domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl(this._remote, this._nominatim);

  final LocationRemoteDataSource _remote;
  final NominatimDataSource _nominatim;

  @override
  Future<ResolvedArea?> resolveArea({
    required double lat,
    required double lng,
  }) async {
    final result = await _nominatim.reverse(lat: lat, lng: lng);
    return result?.toEntity();
  }

  @override
  Future<SavedLocation> setMyLocation({
    required double lat,
    required double lng,
    String? displayArea,
    String? areaLevel,
  }) async {
    final model = await _remote.setLocation(
      lat: lat,
      lng: lng,
      displayArea: displayArea,
      areaLevel: areaLevel,
    );
    return model.toEntity();
  }
}
