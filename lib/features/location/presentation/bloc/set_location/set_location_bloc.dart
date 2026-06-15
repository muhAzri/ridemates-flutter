import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:ridemates/core/forms/form_status.dart';
import 'package:ridemates/core/location/device_location_service.dart';
import 'package:ridemates/core/network/api_exception.dart';
import 'package:ridemates/features/location/domain/usecases/resolve_area_usecase.dart';
import 'package:ridemates/features/location/domain/usecases/set_my_location_usecase.dart';

part 'set_location_event.dart';
part 'set_location_state.dart';
part 'set_location_bloc.freezed.dart';

/// Default map centre when device location is unavailable — Kebayoran Baru,
/// Jakarta Selatan (matches the FSD's Indonesian market context).
const _defaultCenter = LatLng(-6.2444, 106.8006);

/// Owns the "Pin your location" screen (screen 04): centres the map on the
/// device, reverse-geocodes the area as the pin moves, and persists the
/// confirmed pin. The pin is the single source of truth (FSD §5.2.1); precise
/// coordinates are sent on write only and never displayed back (LP-1).
class SetLocationBloc extends Bloc<SetLocationEvent, SetLocationState> {
  SetLocationBloc(
    this._deviceLocation,
    this._resolveArea,
    this._setMyLocation,
  ) : super(const SetLocationState()) {
    on<SetLocationStarted>(_onStarted);
    on<SetLocationPinMoved>(_onPinMoved);
    on<SetLocationRecenterRequested>(_onRecenterRequested);
    on<SetLocationConfirmed>(_onConfirmed);
  }

  final DeviceLocationService _deviceLocation;
  final ResolveAreaUseCase _resolveArea;
  final SetMyLocationUseCase _setMyLocation;

  Future<void> _onStarted(
    SetLocationStarted event,
    Emitter<SetLocationState> emit,
  ) async {
    emit(state.copyWith(isLocating: true));
    final position = await _deviceLocation.currentPosition();
    final center = position ?? _defaultCenter;
    emit(state.copyWith(isLocating: false, pin: center, recenter: center));
    await _resolve(center, emit);
  }

  Future<void> _onPinMoved(
    SetLocationPinMoved event,
    Emitter<SetLocationState> emit,
  ) async {
    emit(state.copyWith(pin: event.point));
    await _resolve(event.point, emit);
  }

  Future<void> _onRecenterRequested(
    SetLocationRecenterRequested event,
    Emitter<SetLocationState> emit,
  ) async {
    emit(state.copyWith(isLocating: true));
    final position = await _deviceLocation.currentPosition();
    emit(state.copyWith(isLocating: false));
    if (position == null) return;
    emit(state.copyWith(pin: position, recenter: position));
    await _resolve(position, emit);
  }

  Future<void> _onConfirmed(
    SetLocationConfirmed event,
    Emitter<SetLocationState> emit,
  ) async {
    emit(state.copyWith(status: FormStatus.submitting, errorMessage: null));
    try {
      await _setMyLocation(
        lat: state.pin.latitude,
        lng: state.pin.longitude,
        displayArea: state.displayArea,
        areaLevel: state.areaLevel,
      );
      emit(state.copyWith(status: FormStatus.success));
    } on ApiException catch (e) {
      emit(state.copyWith(status: FormStatus.failure, errorMessage: e.message));
    } on Object {
      emit(state.copyWith(status: FormStatus.failure));
    }
  }

  /// Reverse-geocodes [point] and applies the label only if the pin hasn't
  /// moved on since — drops stale results from overlapping lookups.
  Future<void> _resolve(LatLng point, Emitter<SetLocationState> emit) async {
    emit(state.copyWith(isResolving: true));
    final area = await _resolveArea(lat: point.latitude, lng: point.longitude);
    if (state.pin != point) return; // a newer move superseded this lookup
    emit(
      state.copyWith(
        isResolving: false,
        displayArea: area?.displayArea,
        areaLevel: area?.areaLevel,
      ),
    );
  }
}
