import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/widgets/app_avatar.dart';
import 'package:tawasul/core/widgets/app_loading_indicator.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';
import 'package:tawasul/features/auth/models/demo_user.dart';

/// Selectable account card on the sign-in screen.
class UserSelectCard extends StatelessWidget {
  const UserSelectCard({
    required this.user,
    required this.onTap,
    this.isLoading = false,
    this.enabled = true,
    super.key,
  });

  final DemoUser user;
  final VoidCallback onTap;
  final bool isLoading;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return PressableScale(
      onTap: enabled ? onTap : null,
      pressedScale: 0.97,
      semanticLabel: user.name,
      child: AnimatedContainer(
        duration: AppDurations.normal,
        curve: Curves.easeOut,
        padding: EdgeInsets.all(AppSpacing.md.r),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg.r),
          border: Border.all(
            color: isLoading ? AppColors.primary : colors.border,
            width: isLoading ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.shadow,
              blurRadius: 16.r,
              offset: Offset(0, 4.r),
            ),
          ],
        ),
        child: Row(
          children: [
            AppAvatar(imageUrl: user.image, name: user.name),
            SizedBox(width: AppSpacing.md.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleMedium,
                  ),
                  SizedBox(height: AppSpacing.xxs.h),
                  Text('@${user.id}', style: context.textTheme.bodySmall),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: AppDurations.normal,
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: isLoading
                  ? const AppLoadingIndicator(size: 20, key: ValueKey('busy'))
                  : Icon(
                      CupertinoIcons.chevron_right,
                      key: const ValueKey('idle'),
                      size: AppIconSize.sm.r,
                      color: colors.textTertiary,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
