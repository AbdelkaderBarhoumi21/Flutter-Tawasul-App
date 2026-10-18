import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/theme/theme_controller.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';

/// Compact pill switch for System / Light / Dark with a sliding thumb.
class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  static const _options = [
    (
      ThemeMode.system,
      CupertinoIcons.device_phone_portrait,
      AppStrings.themeSystem,
    ),
    (ThemeMode.light, CupertinoIcons.sun_max_fill, AppStrings.themeLight),
    (ThemeMode.dark, CupertinoIcons.moon_fill, AppStrings.themeDark),
  ];

  static const _segmentSize = 34.0;

  /// Human-readable name of [mode], e.g. for a subtitle.
  static String labelOf(ThemeMode mode) =>
      _options.firstWhere((option) => option.$1 == mode).$3;

  @override
  Widget build(BuildContext context) {
    final controller = ThemeScope.of(context);
    final colors = context.colors;
    final selectedIndex = _options.indexWhere(
      (option) => option.$1 == controller.value,
    );
    final segment = _segmentSize.r;

    return Container(
      padding: EdgeInsets.all(3.r),
      decoration: BoxDecoration(
        color: colors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: SizedBox(
        width: segment * _options.length,
        height: segment,
        child: Stack(
          children: [
            AnimatedAlign(
              alignment: Alignment(-1.0 + selectedIndex, 0),
              duration: AppDurations.normal,
              curve: Curves.easeOutCubic,
              child: Container(
                width: segment,
                height: segment,
                decoration: BoxDecoration(
                  gradient: AppGradients.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 8.r,
                      offset: Offset(0, 2.r),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                for (final (index, (mode, icon, label)) in _options.indexed)
                  PressableScale(
                    onTap: () => controller.value = mode,
                    pressedScale: 0.85,
                    semanticLabel: label,
                    child: SizedBox.square(
                      dimension: segment,
                      child: Icon(
                        icon,
                        size: AppIconSize.sm.r,
                        color: index == selectedIndex
                            ? AppColors.white
                            : colors.textTertiary,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
