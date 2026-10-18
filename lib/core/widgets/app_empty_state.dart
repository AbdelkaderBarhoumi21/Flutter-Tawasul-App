import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/extensions/animation_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';

/// Friendly illustration-style placeholder for empty, error and
/// not-yet-implemented screens.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.accentColor = AppColors.primary,
    this.action,
    super.key,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color accentColor;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxxl.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96.r,
              height: 96.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.soft(accentColor),
              ),
              child: Icon(icon, size: AppIconSize.huge.r, color: accentColor),
            ),
            SizedBox(height: AppSpacing.xxl.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
            if (action != null) ...[
              SizedBox(height: AppSpacing.xxl.h),
              action!,
            ],
          ],
        ),
      ).popIn(),
    );
  }
}
