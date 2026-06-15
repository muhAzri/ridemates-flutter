import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/router/app_routes.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/utils/validators.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/auth/presentation/bloc/create_account/create_account_bloc.dart';
import 'package:ridemates/features/auth/presentation/widgets/auth_footer.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Sign-up form section: title, email + password fields, submit, Google and the
/// log-in footer. Dispatches [CreateAccountSubmitted] to [CreateAccountBloc].
class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CreateAccountBloc>().add(
        CreateAccountSubmitted(
          email: _email.text.trim(),
          password: _password.text,
        ),
      );
    }
  }

  void _signInWithGoogle() => context.read<CreateAccountBloc>().add(
    const CreateAccountGoogleRequested(),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isSubmitting = context.select<CreateAccountBloc, bool>(
      (bloc) => bloc.state.status.isSubmitting,
    );
    final isGoogleLoading = context.select<CreateAccountBloc, bool>(
      (bloc) => bloc.state.isGoogleInProgress,
    );
    final isBusy = isSubmitting || isGoogleLoading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.createAccountFormTitle,
            style: AppTypography.heading.copyWith(
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: l10n.emailFieldLabel,
            hintText: l10n.emailFieldHint,
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => Validators.email(
              value,
              requiredMessage: l10n.validationEmailRequired,
              invalidMessage: l10n.validationEmailInvalid,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: l10n.passwordFieldLabel,
            controller: _password,
            isPassword: true,
            helperText: l10n.passwordRequirementHelper,
            textInputAction: TextInputAction.next,
            validator: (value) => Validators.newPassword(
              value,
              requiredMessage: l10n.validationPasswordRequired,
              weakMessage: l10n.validationPasswordWeak,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: l10n.confirmPasswordFieldLabel,
            controller: _confirmPassword,
            isPassword: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            validator: (value) {
              if ((value ?? '').isEmpty) {
                return l10n.validationConfirmPasswordRequired;
              }
              if (value != _password.text) {
                return l10n.validationPasswordMismatch;
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            label: l10n.createAccountButton,
            isLoading: isSubmitting,
            onPressed: isBusy ? null : _submit,
          ),
          const SizedBox(height: AppSpacing.lg),
          OrDivider(label: l10n.orSeparator),
          const SizedBox(height: AppSpacing.lg),
          GoogleButton(
            label: l10n.continueWithGoogleButton,
            isLoading: isGoogleLoading,
            onPressed: isBusy ? null : _signInWithGoogle,
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthFooter(
            prompt: l10n.alreadyHaveAccountPrompt,
            actionLabel: l10n.logInLink,
            onPressed: () => context.go(AppRoutes.login),
          ),
        ],
      ),
    );
  }
}
