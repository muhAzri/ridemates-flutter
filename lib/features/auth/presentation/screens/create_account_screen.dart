import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_router.dart';
import 'package:ridemates/features/auth/presentation/bloc/create_account/create_account_bloc.dart';
import 'package:ridemates/features/auth/presentation/widgets/auth_layout.dart';
import 'package:ridemates/features/auth/presentation/widgets/create_account_form.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 01 — Create account. Composed of [AuthLayout] + [CreateAccountForm].
class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) => getIt<CreateAccountBloc>(),
      child: Scaffold(
        body: BlocListener<CreateAccountBloc, CreateAccountState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.go(AppRoutes.profileSetup);
            } else if (state.status.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? l10n.signUpFailedMessage),
                ),
              );
            }
          },
          child: AuthLayout(
            title: l10n.createAccountHeroTitle,
            subtitle: l10n.appTagline,
            form: const CreateAccountForm(),
          ),
        ),
      ),
    );
  }
}
