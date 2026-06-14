import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/theme.dart';
import 'package:ridemates/features/auth/presentation/widgets/auth_hero.dart';

/// Shared layout for the auth screens: a pine [AuthHero] sized to ~30% of the
/// viewport height, with the form below. Stays scrollable when the keyboard
/// shrinks the viewport.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.title,
    required this.subtitle,
    required this.form,
    super.key,
  });

  final String title;
  final String subtitle;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.3,
            child: AuthHero(
              title: title,
              subtitle: subtitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            child: form,
          ),
        ],
      ),
    );
  }
}
