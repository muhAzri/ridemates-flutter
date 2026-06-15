import 'package:ridemates/features/location/domain/entities/resolved_area.dart';
import 'package:ridemates/features/location/domain/repositories/location_repository.dart';

class ResolveAreaUseCase {
  const ResolveAreaUseCase(this._repository);

  final LocationRepository _repository;

  Future<ResolvedArea?> call({required double lat, required double lng}) =>
      _repository.resolveArea(lat: lat, lng: lng);
}
