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

/// Segmented control for System / Light / Dark appearance.
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

  @override
  Widget build(BuildContext context) {
    final controller = ThemeScope.of(context);
    final colors = context.colors;
    return Container(
      padding: EdgeInsets.all(AppSpacing.xs.r),
      decoration: BoxDecoration(
        color: colors.surfaceMuted,
        borderRadius: BorderRadius.circular(AppRadius.lg.r),
      ),
      child: Row(
        children: [
          for (final (mode, icon, label) in _options)
            Expanded(
              child: PressableScale(
                onTap: () => controller.value = mode,
                semanticLabel: label,
                child: AnimatedContainer(
                  duration: AppDurations.normal,
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
                  decoration: BoxDecoration(
                    color: controller.value == mode
                        ? colors.surface
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.md.r),
                    boxShadow: controller.value == mode
                        ? [BoxShadow(color: colors.shadow, blurRadius: 10.r)]
                        : null,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        size: AppIconSize.md.r,
                        color: controller.value == mode
                            ? AppColors.primary
                            : colors.textTertiary,
                      ),
                      SizedBox(height: AppSpacing.xs.h),
                      Text(label, style: context.textTheme.labelMedium),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
