import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/features/profile/presentation/cubit/current_user_cubit.dart';
import 'package:ridemates/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // The signed-in user's profile is shared app-wide (above the router's
    // navigator) so every screen — including pushed routes like Settings —
    // reads the one persisted `/me` snapshot.
    return BlocProvider<CurrentUserCubit>.value(
      value: getIt<CurrentUserCubit>(),
      child: MaterialApp.router(
        theme: AppTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: getIt<GoRouter>(),
      ),
    );
  }
}
