import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/core/routing/app_routes.dart';
import 'package:tawasul/core/widgets/app_avatar.dart';

/// Large-title header shown above every home tab.
class HomeHeader extends StatelessWidget {
  const HomeHeader({required this.title, super.key});

  static const profileHeroTag = 'hero-profile-avatar';

  final String title;

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl.w,
        AppSpacing.md.h,
        AppSpacing.xl.w,
        AppSpacing.sm.h,
      ),
      child: Row(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: AppDurations.normal,
              switchInCurve: Curves.easeOutCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 0.25),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              layoutBuilder: (current, previous) => Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [...previous, ?current],
              ),
              child: Text(
                title,
                key: ValueKey(title),
                style: context.textTheme.headlineMedium,
              ),
            ),
          ),
          Hero(
            tag: profileHeroTag,
            child: AppAvatar(
              imageUrl: user?.image,
              name: user?.name,
              size: AvatarSize.sm,
              onTap: () => context.pushNamed<void>(AppRoutes.profile),
            ),
          ),
        ],
      ),
    );
  }
}
