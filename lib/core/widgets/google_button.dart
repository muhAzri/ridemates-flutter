import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridemates/core/constants/app_assets.dart';
import 'package:ridemates/core/theme/theme.dart';

/// Google Sign-In button following Google's branding guidelines
/// (https://developers.google.com/identity/branding-guidelines), light theme:
/// white fill, `#1F1F1F` Roboto Medium 14/20 text, `#747775` 1px stroke, and
/// the unaltered standard-colour "G" logo. [label] must be an approved string
/// ("Continue with Google" / "Sign in with Google" / "Sign up with Google").
class GoogleButton extends StatelessWidget {
  const GoogleButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  static const Color _fill = Color(0xFFFFFFFF);
  static const Color _textColor = Color(0xFF1F1F1F);
  static const Color _stroke = Color(0xFF747775);

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: Material(
          color: _fill,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.fieldRadius,
            side: BorderSide(color: _stroke),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: enabled ? onPressed : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: isLoading
                  ? const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _textColor,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.googleLogo,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              height: 20 / 14,
                              fontWeight: FontWeight.w500,
                              color: _textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
