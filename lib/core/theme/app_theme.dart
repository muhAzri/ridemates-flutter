import 'package:flutter/material.dart';
import 'package:ridemates/core/theme/app_colors.dart';
import 'package:ridemates/core/theme/app_radii.dart';
import 'package:ridemates/core/theme/app_typography.dart';

/// Assembles the brand [ThemeData]. Wire via
/// `MaterialApp(theme: AppTheme.light)` so every framework widget inherits the
/// RideMates design system.
abstract final class AppTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme.light(
      primary: AppColors.leaf,
      secondary: AppColors.pine,
      tertiary: AppColors.clay,
      onTertiary: Colors.white,
      onSurface: AppColors.ink,
      surfaceContainerLowest: AppColors.surface,
      surfaceContainerLow: AppColors.paper,
      surfaceContainer: AppColors.paper,
      outline: AppColors.border,
      outlineVariant: AppColors.borderField,
      error: AppColors.error,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.paper,
      textTheme: AppTypography.textTheme,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.pine,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.leaf,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          textStyle: AppTypography.textTheme.labelLarge,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.fieldRadius,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.pine,
          backgroundColor: AppColors.surface,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          textStyle: AppTypography.textTheme.labelLarge,
          side: const BorderSide(color: AppColors.borderSecondary, width: 1.5),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.fieldRadius,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.leaf,
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.cardRadius,
          side: BorderSide(color: AppColors.border),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: AppTypography.body.copyWith(color: AppColors.inkFaint),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: _fieldBorder(AppColors.borderField),
        enabledBorder: _fieldBorder(AppColors.borderField),
        focusedBorder: _fieldBorder(AppColors.leaf),
        errorBorder: _fieldBorder(AppColors.error),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.mint,
        selectedColor: AppColors.leaf,
        labelStyle: AppTypography.textTheme.labelMedium?.copyWith(
          color: AppColors.onMint,
          letterSpacing: 0,
        ),
        side: const BorderSide(color: AppColors.mintBorder),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        shape: const StadiumBorder(),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderSubtle,
        thickness: 1,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.leaf
              : AppColors.borderField,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),
    );
  }

  static OutlineInputBorder _fieldBorder(Color color) => OutlineInputBorder(
    borderRadius: AppRadii.fieldRadius,
    borderSide: BorderSide(color: color, width: 1.5),
  );
}
