import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// latlong2 also exports a `Path` type; hide it so `Path` means `dart:ui.Path`.
import 'package:latlong2/latlong.dart' hide Path;
import 'package:ridemates/core/theme/theme.dart';

/// OpenStreetMap-backed map for picking a location. The pin is fixed at the
/// screen centre and the map pans beneath it (the "move the map under the pin"
/// pattern), so the current centre *is* the pin. [onMoveEnd] fires once the map
/// settles so the caller can reverse-geocode without spamming the geocoder.
class LocationMap extends StatelessWidget {
  const LocationMap({
    required this.controller,
    required this.initialCenter,
    required this.onMoveEnd,
    super.key,
  });

  final MapController controller;
  final LatLng initialCenter;
  final ValueChanged<LatLng> onMoveEnd;

  static const double _initialZoom = 15;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: controller,
          options: MapOptions(
            initialCenter: initialCenter,
            initialZoom: _initialZoom,
            minZoom: 3,
            maxZoom: 18,
            onMapEvent: (event) {
              // Only react once a gesture / animation settles, not on every
              // intermediate frame — keeps geocoder calls within OSM policy.
              if (event is MapEventMoveEnd ||
                  event is MapEventFlingAnimationEnd ||
                  event is MapEventDoubleTapZoomEnd) {
                onMoveEnd(event.camera.center);
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.ridemates.app',
            ),
          ],
        ),
        // Fixed pin + approximate-area ring, locked to the screen centre.
        const IgnorePointer(child: Center(child: _CenterPin())),
      ],
    );
  }
}

/// The leaf pin with the dashed approximate-area ring behind it. The ring is
/// decorative — it signals "your area, not your exact spot" (LP-4).
class _CenterPin extends StatelessWidget {
  const _CenterPin();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.leaf.withValues(alpha: 0.14),
              border: Border.all(
                color: AppColors.leaf.withValues(alpha: 0.45),
                width: 2,
              ),
            ),
          ),
          // Lift the pin so its tip rests on the exact centre point.
          Transform.translate(
            offset: const Offset(0, -22),
            child: const _PinMarker(),
          ),
        ],
      ),
    );
  }
}

class _PinMarker extends StatelessWidget {
  const _PinMarker();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x59194032),
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: SizedBox(
        width: 44,
        height: 56,
        child: CustomPaint(painter: _PinPainter()),
      ),
    );
  }
}

/// Draws the teardrop pin (leaf fill, white outline + dot) from the design.
class _PinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final r = w / 2;

    final path = Path()
      ..addOval(Rect.fromCircle(center: Offset(r, r), radius: r))
      ..moveTo(r * 0.35, r * 1.4)
      ..lineTo(r, h)
      ..lineTo(r * 1.65, r * 1.4)
      ..close();

    canvas
      ..drawPath(
        path,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..strokeJoin = StrokeJoin.round,
      )
      ..drawPath(path, Paint()..color = AppColors.leaf)
      ..drawCircle(Offset(r, r), r * 0.32, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
