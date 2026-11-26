// lib/core/configs/app_theme.dart

import 'package:flutter/material.dart';
import 'package:train_away/theme/app_colors.dart';

abstract final class AppTheme {
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.navy,
      onPrimary: AppColors.white,
      secondary: AppColors.burgundy,
      onSecondary: AppColors.white,
      error: Color(0xFFB3261E),
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
      outline: AppColors.navy,
      outlineVariant: AppColors.divider,
      shadow: AppColors.white,
      scrim: AppColors.black,
      inverseSurface: AppColors.navy,
      onInverseSurface: AppColors.white,
      inversePrimary: AppColors.burgundy,
      surfaceTint: AppColors.navy,
      surfaceContainerHigh: AppColors.surfaceGrey,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'DM Sans',
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.navy,
        surfaceTintColor: AppColors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.navy,
        unselectedItemColor: AppColors.muted,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      dividerColor: AppColors.divider,
    );
  }

  static ThemeData get dark {
    const scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.navy,
      onPrimary: _darkBackground,
      secondary: AppColors.burgundy,
      onSecondary: AppColors.white,
      error: Color(0xFFCF6679),
      onError: AppColors.black,
      surface: _darkBackground,
      onSurface: AppColors.white,
      outline: AppColors.grey,
      outlineVariant: AppColors.muted,
      shadow: AppColors.black,
      scrim: AppColors.white,
      inverseSurface: AppColors.white,
      onInverseSurface: AppColors.black,
      inversePrimary: AppColors.burgundy_ligth,
      surfaceTint: AppColors.navy,
      surfaceContainerHigh: AppColors.muted,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'DM Sans',
      colorScheme: scheme,
      scaffoldBackgroundColor: _darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: _darkBackground,
        foregroundColor: AppColors.white,
        surfaceTintColor: _darkBackground,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _darkBackground,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.grey,
      ),
      cardTheme: const CardThemeData(
        color: _darkSurface,
        surfaceTintColor: _darkSurface,
      ),
      dividerColor: AppColors.muted,
    );
  }
}