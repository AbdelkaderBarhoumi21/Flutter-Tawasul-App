import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';

/// Row of shortcut cards under the profile header.
class ProfileQuickActions extends StatelessWidget {
  const ProfileQuickActions({super.key});

  static const _actions = [
    (CupertinoIcons.pencil, AppStrings.editProfile),
    (CupertinoIcons.qrcode, AppStrings.qrCode),
    (CupertinoIcons.share, AppStrings.share),
  ];

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (final (index, (icon, label)) in _actions.indexed) ...[
        if (index > 0) SizedBox(width: AppSpacing.md.w),
        Expanded(
          child: _QuickAction(icon: icon, label: label),
        ),
      ],
    ],
  );
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return PressableScale(
      onTap: context.showComingSoon,
      semanticLabel: label,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg.r),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: AppIconSize.md.r,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: AppSpacing.sm.h),
            Text(label, style: context.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
