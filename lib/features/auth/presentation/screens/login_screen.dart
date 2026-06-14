import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_router.dart';
import 'package:ridemates/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:ridemates/features/auth/presentation/widgets/auth_layout.dart';
import 'package:ridemates/features/auth/presentation/widgets/login_form.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 02 — Log in. Composed of the [AuthLayout] and [LoginForm] sections.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.go(AppRoutes.home);
            } else if (state.status.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? l10n.loginFailedMessage),
                ),
              );
            }
          },
          child: AuthLayout(
            title: l10n.loginHeroTitle,
            subtitle: l10n.loginHeroSubtitle,
            form: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
