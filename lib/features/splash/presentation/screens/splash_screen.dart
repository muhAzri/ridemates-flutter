import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_routes.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/auth/domain/repositories/auth_repository.dart';

/// Root splash — leaf background with the centred brand mark. On launch it
/// decides where to go: an existing (persisted) session resumes into the app,
/// otherwise the user is sent to login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Minimum time the splash stays visible, so it doesn't flash.
  static const Duration _minDisplay = Duration(milliseconds: 1200);

  @override
  void initState() {
    super.initState();
    unawaited(_resolveStartDestination());
  }

  Future<void> _resolveStartDestination() async {
    // Run the auth check and the minimum-display delay concurrently.
    final authFuture = _isAuthenticated();
    await Future<void>.delayed(_minDisplay);
    final isAuthenticated = await authFuture;
    if (!mounted) return;
    context.go(isAuthenticated ? AppRoutes.home : AppRoutes.login);
  }

  Future<bool> _isAuthenticated() async {
    try {
      return await getIt<AuthRepository>().isAuthenticated();
    } on Object {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.leaf,
      body: Center(child: AppLogo(size: 180)),
    );
  }
}
