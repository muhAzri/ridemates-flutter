import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/di/injection.dart';
import 'package:ridemates/core/router/app_routes.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/profile/presentation/bloc/profile_setup/profile_setup_bloc.dart';
import 'package:ridemates/features/profile/presentation/widgets/profile_setup_form.dart';
import 'package:ridemates/features/profile/presentation/widgets/profile_setup_header.dart';
import 'package:ridemates/features/profile/presentation/widgets/profile_setup_skeleton.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Screen 03 — Set up profile. Loads the current profile (prefills fields +
/// avatar), then lets the user complete onboarding. Header + scrollable form +
/// pinned Continue button.
class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _bio = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _bio.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileSetupBloc>().add(
        ProfileSetupSubmitted(
          displayName: _name.text.trim(),
          bio: _bio.text.trim(),
        ),
      );
    }
  }

  void _onBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.createAccount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocProvider(
      create: (_) =>
          getIt<ProfileSetupBloc>()..add(const ProfileSetupStarted()),
      child: Builder(
        builder: (context) {
          final isLoading = context.select<ProfileSetupBloc, bool>(
            (bloc) => bloc.state.isLoading,
          );
          final isSubmitting = context.select<ProfileSetupBloc, bool>(
            (bloc) => bloc.state.status.isSubmitting,
          );
          return Scaffold(
            body: SafeArea(
              child: MultiBlocListener(
                listeners: [
                  // Prefill the text fields once the profile has loaded.
                  BlocListener<ProfileSetupBloc, ProfileSetupState>(
                    listenWhen: (p, c) => p.isLoading && !c.isLoading,
                    listener: (context, state) {
                      _name.text = state.displayName ?? '';
                      _bio.text = state.bio ?? '';
                    },
                  ),
                  BlocListener<ProfileSetupBloc, ProfileSetupState>(
                    listenWhen: (p, c) => p.status != c.status,
                    listener: (context, state) {
                      if (state.status.isSuccess) {
                        // Onboarding continues to screen 04 — set location.
                        context.go(AppRoutes.setLocation);
                      } else if (state.status.isFailure) {
                        final message =
                            state.errorMessage ?? l10n.profileSaveFailedMessage;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      }
                    },
                  ),
                ],
                child: Column(
                  children: [
                    ProfileSetupHeader(
                      title: l10n.profileSetupTitle,
                      stepLabel: l10n.profileSetupStep(1, 2),
                      onBack: () => _onBack(context),
                    ),
                    Expanded(
                      child: isLoading
                          ? const ProfileSetupSkeleton()
                          : SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(
                                AppSpacing.lg,
                                AppSpacing.xs,
                                AppSpacing.lg,
                                AppSpacing.lg,
                              ),
                              child: ProfileSetupForm(
                                formKey: _formKey,
                                nameController: _name,
                                bioController: _bio,
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.sm,
                        AppSpacing.lg,
                        AppSpacing.xl,
                      ),
                      child: PrimaryButton(
                        label: l10n.continueButton,
                        isLoading: isSubmitting,
                        onPressed: isLoading || isSubmitting
                            ? null
                            : () => _submit(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
