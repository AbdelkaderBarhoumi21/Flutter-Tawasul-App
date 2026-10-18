import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/theme/app_theme_colors.dart';

/// Builds the Material 3 light and dark themes.
///
/// Must be called below `ScreenUtilInit`, since sizes are screen-adapted.
abstract final class AppTheme {
  static ThemeData light() =>
      _build(brightness: Brightness.light, colors: AppThemeColors.light);

  static ThemeData dark() =>
      _build(brightness: Brightness.dark, colors: AppThemeColors.dark);

  static ThemeData _build({
    required Brightness brightness,
    required AppThemeColors colors,
  }) {
    final isDark = brightness == Brightness.dark;
    final textTheme = _textTheme(colors);
    final pillShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.pill),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
        surface: colors.surface,
        onSurface: colors.textPrimary,
        surfaceContainerHighest: colors.surfaceMuted,
        onSurfaceVariant: colors.textSecondary,
        outline: colors.border,
        outlineVariant: colors.border,
      ),
      scaffoldBackgroundColor: colors.background,
      textTheme: textTheme,
      extensions: [colors],
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      iconTheme: IconThemeData(
        color: colors.textPrimary,
        size: AppIconSize.lg.r,
      ),
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
        space: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceMuted,
        hintStyle: textTheme.bodyMedium?.copyWith(color: colors.textTertiary),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg.w,
          vertical: AppSpacing.md.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.xl.r),
          borderSide: BorderSide.none,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: pillShape,
          minimumSize: Size.fromHeight(52.h),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: pillShape,
          textStyle: textTheme.labelLarge,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? colors.surfaceMuted
            : AppColors.lightTextPrimary,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md.r),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: colors.border,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xxl.r),
          ),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primary,
        selectionColor: AppColors.primary.withValues(alpha: 0.25),
        selectionHandleColor: AppColors.primary,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  static TextTheme _textTheme(AppThemeColors colors) {
    TextStyle style(
      double size,
      FontWeight weight, {
      double? height,
      double? letterSpacing,
      Color? color,
    }) => TextStyle(
      fontSize: size.sp,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
      color: color ?? colors.textPrimary,
    );

    return GoogleFonts.plusJakartaSansTextTheme(
      TextTheme(
        displaySmall: style(
          32,
          FontWeight.w800,
          height: 1.15,
          letterSpacing: -0.8,
        ),
        headlineMedium: style(
          28,
          FontWeight.w800,
          height: 1.2,
          letterSpacing: -0.6,
        ),
        headlineSmall: style(
          24,
          FontWeight.w700,
          height: 1.25,
          letterSpacing: -0.4,
        ),
        titleLarge: style(20, FontWeight.w700, letterSpacing: -0.3),
        titleMedium: style(16, FontWeight.w700, letterSpacing: -0.1),
        titleSmall: style(14, FontWeight.w600),
        bodyLarge: style(16, FontWeight.w400, height: 1.45),
        bodyMedium: style(14, FontWeight.w400, height: 1.45),
        bodySmall: style(12, FontWeight.w400, color: colors.textSecondary),
        labelLarge: style(14, FontWeight.w600),
        labelMedium: style(12, FontWeight.w600),
        labelSmall: style(
          11,
          FontWeight.w500,
          letterSpacing: 0.2,
          color: colors.textSecondary,
        ),
      ),
    );
  }
}
