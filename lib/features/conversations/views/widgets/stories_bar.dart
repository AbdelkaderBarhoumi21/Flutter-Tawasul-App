import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/core/extensions/string_extensions.dart';
import 'package:tawasul/core/widgets/app_avatar.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';
import 'package:tawasul/features/conversations/models/story.dart';

/// Horizontal list of stories, led by the current user's "add story" item.
class StoriesBar extends StatelessWidget {
  const StoriesBar({required this.stories, super.key});

  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return SizedBox(
      height: AppDimensions.storiesHeight.r,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xl.w,
          vertical: AppSpacing.sm.h,
        ),
        itemCount: stories.length + 1,
        separatorBuilder: (_, _) => SizedBox(width: AppSpacing.lg.w),
        itemBuilder: (context, index) {
          final Widget item = index == 0
              ? _StoryItem(
                  label: AppStrings.yourStory,
                  avatar: _AddStoryAvatar(
                    imageUrl: user?.image,
                    name: user?.name,
                  ),
                )
              : _StoryItem(
                  label: stories[index - 1].name.firstWord,
                  avatar: AppAvatar(
                    imageUrl: stories[index - 1].imageUrl,
                    name: stories[index - 1].name,
                    showStoryRing: true,
                  ),
                );
          return item
              .animate(delay: AppDurations.stagger * index)
              .fadeIn(duration: AppDurations.normal)
              .slideX(begin: 0.3, end: 0, curve: Curves.easeOutCubic);
        },
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  const _StoryItem({required this.label, required this.avatar});

  final String label;
  final Widget avatar;

  @override
  Widget build(BuildContext context) => PressableScale(
    onTap: context.showComingSoon,
    semanticLabel: label,
    child: SizedBox(
      width: 64.r,
      child: Column(
        children: [
          avatar,
          SizedBox(height: AppSpacing.xs.h),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelSmall,
          ),
        ],
      ),
    ),
  );
}

class _AddStoryAvatar extends StatelessWidget {
  const _AddStoryAvatar({this.imageUrl, this.name});

  final String? imageUrl;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final badgeSize = 20.r;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          // Match the outer size of avatars with a story ring.
          padding: EdgeInsets.all(5.r),
          child: AppAvatar(imageUrl: imageUrl, name: name),
        ),
        PositionedDirectional(
          end: 2.r,
          bottom: 2.r,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.background, width: 2),
            ),
            child: Icon(
              CupertinoIcons.add,
              size: badgeSize * 0.6,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
