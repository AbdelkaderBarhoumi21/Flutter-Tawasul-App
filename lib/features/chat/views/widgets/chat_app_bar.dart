import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/channel_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/core/widgets/app_avatar.dart';
import 'package:tawasul/core/widgets/app_icon_button.dart';
import 'package:tawasul/features/chat/views/widgets/chat_presence_status.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({required this.channel, super.key});

  final Channel channel;

  @override
  Size get preferredSize => Size.fromHeight(64.h);

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.currentUser?.id;
    final peer = channel.directPeer(currentUserId);
    final name = channel.displayName(currentUserId);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(bottom: BorderSide(color: context.colors.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox.fromSize(
          size: preferredSize,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md.w),
            child: Row(
              children: [
                AppIconButton(
                  icon: CupertinoIcons.back,
                  tooltip: AppStrings.back,
                  filled: false,
                  onTap: context.pop,
                ),
                SizedBox(width: AppSpacing.xs.w),
                AppAvatar(
                  imageUrl: channel.displayImage(currentUserId),
                  name: name,
                  size: AvatarSize.sm,
                  isOnline: peer?.online ?? false,
                ),
                SizedBox(width: AppSpacing.md.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleMedium,
                      ),
                      SizedBox(height: AppSpacing.xxs.h),
                      ChatPresenceStatus(channel: channel),
                    ],
                  ),
                ),
                AppIconButton(
                  icon: CupertinoIcons.video_camera,
                  tooltip: AppStrings.videoCall,
                  filled: false,
                  onTap: context.showComingSoon,
                ),
                AppIconButton(
                  icon: CupertinoIcons.phone,
                  tooltip: AppStrings.voiceCall,
                  filled: false,
                  onTap: context.showComingSoon,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
