import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/animation_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';

/// Brand mark, title and subtitle at the top of the sign-in screen.
class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64.r,
          height: 64.r,
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(AppRadius.xl.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 24.r,
                offset: Offset(0, 10.r),
              ),
            ],
          ),
          child: Icon(
            CupertinoIcons.chat_bubble_2_fill,
            color: AppColors.white,
            size: AppIconSize.xl.r,
          ),
        ).popIn(),
        SizedBox(height: AppSpacing.xxl.h),
        Text(AppStrings.welcomeTitle, style: textTheme.headlineMedium)
            .animate(delay: AppDurations.stagger * 2)
            .fadeIn(duration: AppDurations.slow)
            .slideX(begin: -0.05, end: 0, curve: Curves.easeOutCubic),
        SizedBox(height: AppSpacing.sm.h),
        Text(
              AppStrings.welcomeSubtitle,
              style: textTheme.bodyLarge?.copyWith(
                color: context.colors.textSecondary,
              ),
            )
            .animate(delay: AppDurations.stagger * 4)
            .fadeIn(duration: AppDurations.slow)
            .slideX(begin: -0.05, end: 0, curve: Curves.easeOutCubic),
      ],
    );
  }
}
