import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_router.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/features/location/presentation/bloc/set_location/set_location_bloc.dart';
import 'package:ridemates/features/location/presentation/widgets/location_confirm_sheet.dart';
import 'package:ridemates/features/location/presentation/widgets/location_map.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 04 — Pin your location. An OpenStreetMap map with a centre pin the
/// user positions over their riding area; confirming saves the precise pin
/// server-side (write-only, LP-1) along with the client-resolved area label.
class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  final _mapController = MapController();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.profileSetup);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => getIt<SetLocationBloc>()..add(const SetLocationStarted()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: MultiBlocListener(
              listeners: [
                // Animate the map when the bloc asks to recentre (initial
                // device locate / recenter button).
                BlocListener<SetLocationBloc, SetLocationState>(
                  listenWhen: (p, c) =>
                      c.recenter != null && p.recenter != c.recenter,
                  listener: (context, state) {
                    final target = state.recenter!;
                    final zoom = _currentZoomOr(15);
                    _mapController.move(target, zoom);
                  },
                ),
                BlocListener<SetLocationBloc, SetLocationState>(
                  listenWhen: (p, c) => p.status != c.status,
                  listener: (context, state) {
                    if (state.status.isSuccess) {
                      context.go(AppRoutes.home);
                    } else if (state.status.isFailure) {
                      final message =
                          state.errorMessage ?? l10n.setLocationFailedMessage;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    }
                  },
                ),
              ],
              child: Stack(
                children: [
                  Positioned.fill(
                    child: LocationMap(
                      controller: _mapController,
                      initialCenter: context.read<SetLocationBloc>().state.pin,
                      onMoveEnd: (point) => context.read<SetLocationBloc>().add(
                        SetLocationPinMoved(point),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: _HeaderCard(onBack: () => _onBack(context)),
                      ),
                    ),
                  ),
                  _RecenterButton(
                    onPressed: () => context.read<SetLocationBloc>().add(
                      const SetLocationRecenterRequested(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Builder(
                      builder: (context) {
                        final state = context.watch<SetLocationBloc>().state;
                        return LocationConfirmSheet(
                          displayArea: state.displayArea,
                          isResolving: state.isResolving,
                          isSubmitting: state.status.isSubmitting,
                          onConfirm: () => context.read<SetLocationBloc>().add(
                            const SetLocationConfirmed(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  double _currentZoomOr(double fallback) {
    try {
      return _mapController.camera.zoom;
    } on Object {
      return fallback;
    }
  }
}

/// Floating header card with a back button and the screen instructions.
class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        borderRadius: AppRadii.tileRadius,
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D194032),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xs,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppColors.ink,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.setLocationHeaderTitle, style: AppTypography.title),
                  const SizedBox(height: 2),
                  Text(
                    l10n.setLocationHeaderSubtitle,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.inkMuted,
                    ),
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

/// Recenter-on-me control, floated just above the confirm sheet.
class _RecenterButton extends StatelessWidget {
  const _RecenterButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: AppSpacing.md,
      bottom: 280,
      child: Material(
        color: AppColors.surface,
        borderRadius: AppRadii.tileRadius,
        elevation: 3,
        shadowColor: const Color(0x59194032),
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppRadii.tileRadius,
          child: const SizedBox(
            width: 46,
            height: 46,
            child: Icon(Icons.my_location, size: 22, color: AppColors.leaf),
          ),
        ),
      ),
    );
  }
}
