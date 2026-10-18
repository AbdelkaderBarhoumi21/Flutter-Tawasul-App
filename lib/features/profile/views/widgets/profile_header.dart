import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/animation_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/widgets/app_avatar.dart';
import 'package:tawasul/core/widgets/app_icon_button.dart';
import 'package:tawasul/features/home/views/widgets/home_header.dart';

/// Gradient banner with a floating avatar, name, handle and status chip.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.name,
    required this.handle,
    this.imageUrl,
    this.isOnline = false,
    super.key,
  });

  final String name;
  final String handle;
  final String? imageUrl;
  final bool isOnline;

  static const _bannerHeight = 150.0;
  static const _avatarRing = 5.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final topInset = MediaQuery.paddingOf(context).top;
    final bannerHeight = topInset + _bannerHeight.h;
    final avatarExtent = AvatarSize.xl.dimension.r + _avatarRing.r * 2;

    return Column(
      children: [
        SizedBox(
          height: bannerHeight + avatarExtent / 2,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Light status bar only while the gradient is under it.
              AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: _Banner(height: bannerHeight),
              ),
              Positioned(
                top: topInset + AppSpacing.sm.h,
                left: AppSpacing.lg.w,
                right: AppSpacing.lg.w,
                child: Row(
                  children: [
                    AppIconButton(
                      icon: CupertinoIcons.back,
                      tooltip: AppStrings.back,
                      color: AppColors.white,
                      backgroundColor: AppColors.white.withValues(alpha: 0.18),
                      onTap: context.pop,
                    ),
                    SizedBox(width: AppSpacing.md.w),
                    Text(
                      AppStrings.profile,
                      style: textTheme.titleLarge?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: bannerHeight - avatarExtent / 2,
                left: 0,
                right: 0,
                child: Center(
                  child: Hero(
                    tag: HomeHeader.profileHeroTag,
                    child: Container(
                      padding: EdgeInsets.all(_avatarRing.r),
                      decoration: BoxDecoration(
                        color: context.colors.background,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 24.r,
                            offset: Offset(0, 8.r),
                          ),
                        ],
                      ),
                      child: AppAvatar(
                        imageUrl: imageUrl,
                        name: name,
                        size: AvatarSize.xl,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.md.h),
        Text(
          name,
          textAlign: TextAlign.center,
          style: textTheme.headlineSmall,
        ).staggeredEntrance(1),
        SizedBox(height: AppSpacing.xxs.h),
        Text(
          handle,
          style: textTheme.bodyMedium?.copyWith(
            color: context.colors.textSecondary,
          ),
        ).staggeredEntrance(2),
        if (isOnline) ...[
          SizedBox(height: AppSpacing.md.h),
          const _StatusChip().staggeredEntrance(3),
        ],
      ],
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    Widget bubble(double size) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: 0.08),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(AppRadius.xxl.r),
      ),
      child: Container(
        height: height,
        decoration: const BoxDecoration(gradient: AppGradients.primary),
        child: Stack(
          children: [
            Positioned(top: -40.r, right: -30.r, child: bubble(160.r)),
            Positioned(bottom: -60.r, left: -40.r, child: bubble(140.r)),
            Positioned(bottom: 28.r, right: 64.r, child: bubble(36.r)),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip();

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: AppSpacing.md.w,
      vertical: AppSpacing.xs.h,
    ),
    decoration: BoxDecoration(
      color: AppColors.success.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: const BoxDecoration(
            color: AppColors.success,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppSpacing.xs.w + 2),
        Text(
          AppStrings.online,
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColors.success,
          ),
        ),
      ],
    ),
  );
}
