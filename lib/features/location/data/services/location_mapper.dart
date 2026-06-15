import 'package:ridemates/features/location/data/models/location_response_model.dart';
import 'package:ridemates/features/location/data/models/nominatim_result_model.dart';
import 'package:ridemates/features/location/domain/entities/resolved_area.dart';
import 'package:ridemates/features/location/domain/entities/saved_location.dart';

extension LocationResponseModelMapper on LocationResponseModel {
  SavedLocation toEntity() => SavedLocation(
    displayArea: displayArea,
    areaLevel: areaLevel,
    updatedAt: updatedAt,
  );
}

extension NominatimResultModelMapper on NominatimResultModel {
  ResolvedArea toEntity() =>
      ResolvedArea(displayArea: displayArea, areaLevel: areaLevel);
}
