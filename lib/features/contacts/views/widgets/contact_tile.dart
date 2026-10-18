import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/date_time_extensions.dart';
import 'package:tawasul/core/widgets/app_avatar.dart';
import 'package:tawasul/core/widgets/app_loading_indicator.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    required this.user,
    required this.onTap,
    this.isLoading = false,
    super.key,
  });

  final User user;
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final lastActive = user.lastActive;
    final subtitle = user.online
        ? AppStrings.online
        : lastActive == null
        ? '@${user.id}'
        : '${AppStrings.lastSeen} ${lastActive.relativeLabel}';

    return PressableScale(
      onTap: onTap,
      pressedScale: 0.98,
      semanticLabel: user.name,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xl.w,
          vertical: AppSpacing.sm.h,
        ),
        child: Row(
          children: [
            AppAvatar(
              imageUrl: user.image,
              name: user.name,
              isOnline: user.online,
            ),
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
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: user.online ? AppColors.success : null,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: AppDurations.normal,
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: isLoading
                  ? const AppLoadingIndicator(size: 20, key: ValueKey('busy'))
                  : Container(
                      key: const ValueKey('idle'),
                      padding: EdgeInsets.all(AppSpacing.sm.r),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CupertinoIcons.chat_bubble_fill,
                        size: AppIconSize.sm.r,
                        color: AppColors.primary,
                      ),
                    ),
            ),
            SizedBox(width: AppSpacing.xxs.w),
          ],
        ),
      ),
    );
  }
}
