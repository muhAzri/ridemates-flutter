import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';

/// Diagonal-stripe placeholder standing in for not-yet-loaded media (bike
/// photos, avatars). Matches the design's `repeating-linear-gradient(45deg…)`
/// swatch. Media in RideMates is stored externally as URLs; until a real image
/// is wired in, this gives every card a consistent, on-brand empty state.
class HatchPlaceholder extends StatelessWidget {
  const HatchPlaceholder({
    this.label,
    this.height,
    this.borderRadius,
    super.key,
  });

  /// Optional faint mono caption (e.g. "groupset", "bike").
  final String? label;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CustomPaint(
        painter: _HatchPainter(),
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: label == null
              ? null
              : Center(
                  child: Text(
                    label!,
                    style: AppTypography.mono.copyWith(
                      fontSize: 9,
                      color: const Color(0xFFB3AFA4),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _HatchPainter extends CustomPainter {
  static const _base = Color(0xFFEDE7DC);
  static const _stripe = Color(0xFFF4EFE6);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas
      ..drawRect(rect, Paint()..color = _base)
      ..save()
      ..clipRect(rect);

    // 45° diagonal stripes spaced one stripe-width apart, drawn as one path.
    final stripes = Path();
    const step = 14.0;
    for (var x = -size.height; x < size.width + size.height; x += step) {
      stripes
        ..moveTo(x, 0)
        ..lineTo(x + size.height, size.height);
    }
    canvas
      ..drawPath(
        stripes,
        Paint()
          ..color = _stripe
          ..strokeWidth = 7
          ..style = PaintingStyle.stroke,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
