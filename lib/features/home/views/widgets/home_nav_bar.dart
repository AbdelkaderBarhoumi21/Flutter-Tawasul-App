import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/widgets/gradient_action_button.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';
import 'package:tawasul/features/home/models/home_tab.dart';

/// Floating bottom navigation bar with a centered "new chat" action.
class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    required this.selected,
    required this.onSelected,
    required this.onNewChat,
    super.key,
  });

  final HomeTab selected;
  final ValueChanged<HomeTab> onSelected;
  final VoidCallback onNewChat;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    const tabs = HomeTab.values;
    final half = tabs.length ~/ 2;

    Widget item(HomeTab tab) => Expanded(
      child: _NavBarItem(
        tab: tab,
        isSelected: tab == selected,
        onTap: () => onSelected(tab),
      ),
    );

    return SafeArea(
      top: false,
      minimum: EdgeInsets.only(bottom: AppSpacing.md.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
        child: Container(
          height: AppDimensions.navBarHeight.r,
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.xxl.r),
            border: Border.all(color: colors.border),
            boxShadow: [
              BoxShadow(
                color: colors.shadow,
                blurRadius: 30.r,
                offset: Offset(0, 10.r),
              ),
            ],
          ),
          child: Row(
            children: [
              ...tabs.take(half).map(item),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs.w),
                child: GradientActionButton(
                  icon: CupertinoIcons.add,
                  size: 50,
                  tooltip: AppStrings.newChat,
                  onPressed: onNewChat,
                ),
              ),
              ...tabs.skip(half).map(item),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.tab,
    required this.isSelected,
    required this.onTap,
  });

  final HomeTab tab;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primary : context.colors.textTertiary;
    return PressableScale(
      onTap: onTap,
      pressedScale: 0.88,
      semanticLabel: tab.title,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: AppDurations.normal,
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: (isSelected ? AppSpacing.lg : AppSpacing.sm).w,
              vertical: AppSpacing.xs.h,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: AnimatedSwitcher(
              duration: AppDurations.fast,
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                isSelected ? tab.activeIcon : tab.icon,
                key: ValueKey(isSelected),
                size: AppIconSize.md.r,
                color: color,
              ),
            ),
          ),
          SizedBox(height: AppSpacing.xxs.h),
          AnimatedDefaultTextStyle(
            duration: AppDurations.normal,
            style: context.textTheme.labelSmall!.copyWith(
              color: color,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
            child: Text(
              tab.navLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
