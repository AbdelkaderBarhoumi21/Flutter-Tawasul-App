import 'package:flutter/material.dart';

/// Raw color palette of the design system.
///
/// Widgets should prefer the semantic, theme-aware tokens exposed by
/// `context.colors` (see `AppThemeColors`) and only use brand/status colors
/// from here directly.
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF6366F1);
  static const primaryDeep = Color(0xFF4F46E5);
  static const secondary = Color(0xFF8B5CF6);
  static const accent = Color(0xFFEC4899);

  // Status
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);

  // Base
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  // Light neutrals
  static const lightBackground = Color(0xFFF7F8FC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceMuted = Color(0xFFF0F2F8);
  static const lightBorder = Color(0xFFE6E8F0);
  static const lightTextPrimary = Color(0xFF0F172A);
  static const lightTextSecondary = Color(0xFF64748B);
  static const lightTextTertiary = Color(0xFF94A3B8);

  // Dark neutrals
  static const darkBackground = Color(0xFF0B0D17);
  static const darkSurface = Color(0xFF151826);
  static const darkSurfaceMuted = Color(0xFF1E2233);
  static const darkBorder = Color(0xFF272C3F);
  static const darkTextPrimary = Color(0xFFF1F5F9);
  static const darkTextSecondary = Color(0xFFA0A8BC);
  static const darkTextTertiary = Color(0xFF6B7387);
}

/// Gradients shared by both themes.
abstract final class AppGradients {
  static const primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.secondary],
  );

  static const story = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [AppColors.accent, AppColors.secondary, AppColors.primary],
  );

  static LinearGradient soft(Color color) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0.08)],
  );
}
