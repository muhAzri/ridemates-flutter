import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ridemates/core/router/app_router.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/core/utils/validators.dart';
import 'package:ridemates/core/widgets/widgets.dart';
import 'package:ridemates/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:ridemates/features/auth/presentation/widgets/auth_footer.dart';
import 'package:ridemates/l10n/l10n.dart';

/// Login form section: email + password fields, submit, Google and the
/// sign-up footer. Dispatches [LoginSubmitted] to the surrounding [LoginBloc].
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        LoginSubmitted(email: _email.text.trim(), password: _password.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isSubmitting = context.select<LoginBloc, bool>(
      (bloc) => bloc.state.status.isSubmitting,
    );

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.loginFormTitle,
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
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            labelTrailing: Text(
              l10n.forgotPasswordLink,
              style: AppTypography.label.copyWith(
                letterSpacing: 0,
                color: AppColors.leaf,
                fontWeight: FontWeight.w700,
              ),
            ),
            validator: (value) => Validators.requiredPassword(
              value,
              requiredMessage: l10n.validationPasswordRequired,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PrimaryButton(
            label: l10n.logInButton,
            isLoading: isSubmitting,
            onPressed: _submit,
          ),
          const SizedBox(height: AppSpacing.lg),
          OrDivider(label: l10n.orSeparator),
          const SizedBox(height: AppSpacing.lg),
          GoogleButton(
            label: l10n.continueWithGoogleButton,
            onPressed: () {},
          ),
          const SizedBox(height: AppSpacing.xl),
          AuthFooter(
            prompt: l10n.noAccountPrompt,
            actionLabel: l10n.signUpLink,
            onPressed: () => context.go(AppRoutes.createAccount),
          ),
        ],
      ),
    );
  }
}
