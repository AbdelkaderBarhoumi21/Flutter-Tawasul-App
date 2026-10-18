import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/channel_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/date_time_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/core/routing/app_routes.dart';
import 'package:tawasul/core/widgets/app_avatar.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';

/// A row in the conversation list: avatar, name, last message, time and
/// unread badge — all live-updating.
class ConversationTile extends StatelessWidget {
  const ConversationTile({required this.channel, super.key});

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.currentUser?.id;
    final peer = channel.directPeer(currentUserId);
    final channelState = channel.state!;

    return PressableScale(
      pressedScale: 0.98,
      onTap: () => context.pushNamed<void>(AppRoutes.chat, arguments: channel),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xl.w,
          vertical: AppSpacing.md.h,
        ),
        child: BetterStreamBuilder<int>(
          stream: channelState.unreadCountStream,
          initialData: channelState.unreadCount,
          builder: (context, unreadCount) => StreamBuilder<Message?>(
            stream: channelState.lastMessageStream,
            initialData: channelState.lastMessage,
            builder: (context, snapshot) {
              final lastMessage = snapshot.data;
              final hasUnread = unreadCount > 0;
              final timestamp = lastMessage?.createdAt ?? channel.lastMessageAt;

              return Row(
                children: [
                  AppAvatar(
                    imageUrl: channel.displayImage(currentUserId),
                    name: channel.displayName(currentUserId),
                    isOnline: peer?.online ?? false,
                  ),
                  SizedBox(width: AppSpacing.md.w),
                  Expanded(
                    child: _TileBody(
                      title: channel.displayName(currentUserId),
                      preview: lastMessage?.text,
                      timestamp: timestamp,
                      unreadCount: unreadCount,
                      hasUnread: hasUnread,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TileBody extends StatelessWidget {
  const _TileBody({
    required this.title,
    required this.preview,
    required this.timestamp,
    required this.unreadCount,
    required this.hasUnread,
  });

  final String title;
  final String? preview;
  final DateTime? timestamp;
  final int unreadCount;
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    final previewText = (preview == null || preview!.isEmpty)
        ? AppStrings.noMessagesYet
        : preview!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium,
              ),
            ),
            if (timestamp != null)
              Text(
                timestamp!.conversationLabel,
                style: textTheme.labelSmall?.copyWith(
                  color: hasUnread ? AppColors.primary : colors.textTertiary,
                  fontWeight: hasUnread ? FontWeight.w700 : null,
                ),
              ),
          ],
        ),
        SizedBox(height: AppSpacing.xs.h),
        Row(
          children: [
            Expanded(
              child: Text(
                previewText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium?.copyWith(
                  color: hasUnread ? colors.textPrimary : colors.textSecondary,
                  fontWeight: hasUnread ? FontWeight.w600 : null,
                ),
              ),
            ),
            _UnreadBadge(count: unreadCount),
          ],
        ),
      ],
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: AppDurations.normal,
    transitionBuilder: (child, animation) =>
        ScaleTransition(scale: animation, child: child),
    child: count == 0
        ? const SizedBox.shrink()
        : Container(
            key: ValueKey(count),
            margin: EdgeInsetsDirectional.only(start: AppSpacing.sm.w),
            constraints: BoxConstraints(minWidth: 22.r, minHeight: 22.r),
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs.w + 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              count > 99 ? '99+' : '$count',
              style: context.textTheme.labelSmall?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
  );
}
