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
import 'package:tawasul/core/widgets/connection_status_builder.dart';
import 'package:tawasul/features/chat/views/widgets/typing_dots.dart';

/// Subtitle under the chat title: connection state, typing indicator,
/// online/last-seen status or member count — cross-faded on change.
class ChatPresenceStatus extends StatelessWidget {
  const ChatPresenceStatus({required this.channel, super.key});

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    final channelState = channel.state!;
    return ConnectionStatusBuilder(
      builder: (context, status) => BetterStreamBuilder<List<User>>(
        stream: channelState.typingEventsStream.map((e) => e.keys.toList()),
        initialData: channelState.typingEvents.keys.toList(),
        builder: (context, typingUsers) => BetterStreamBuilder<List<Member>>(
          stream: channelState.membersStream,
          initialData: channelState.members,
          builder: (context, members) => AnimatedSwitcher(
            duration: AppDurations.normal,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                alignment: AlignmentDirectional.topStart,
                child: child,
              ),
            ),
            child: _buildStatus(context, status, typingUsers),
          ),
        ),
      ),
    );
  }

  Widget _buildStatus(
    BuildContext context,
    ConnectionStatus status,
    List<User> typingUsers,
  ) {
    switch (status) {
      case ConnectionStatus.connecting:
        return const _StatusText(
          key: ValueKey('connecting'),
          text: AppStrings.connecting,
          color: AppColors.warning,
        );
      case ConnectionStatus.disconnected:
        return const _StatusText(
          key: ValueKey('offline'),
          text: AppStrings.offline,
          color: AppColors.error,
        );
      case ConnectionStatus.connected:
        break;
    }

    if (typingUsers.isNotEmpty) {
      return Row(
        key: const ValueKey('typing'),
        mainAxisSize: MainAxisSize.min,
        children: [
          const TypingDots(),
          SizedBox(width: AppSpacing.xs.w),
          const _StatusText(text: AppStrings.typing, color: AppColors.primary),
        ],
      );
    }

    if (channel.isGroup) {
      final watchers = channel.state?.watcherCount ?? 0;
      final text = watchers > 0
          ? '${channel.memberCount} ${AppStrings.members}, '
                '$watchers ${AppStrings.watching}'
          : '${channel.memberCount} ${AppStrings.members}';
      return _StatusText(key: ValueKey(text), text: text);
    }

    final peer = channel.directPeer(context.currentUser?.id);
    if (peer == null) return const SizedBox.shrink(key: ValueKey('none'));
    if (peer.online) {
      return const _StatusText(
        key: ValueKey('online'),
        text: AppStrings.online,
        color: AppColors.success,
      );
    }
    final lastActive = peer.lastActive;
    if (lastActive == null) return const SizedBox.shrink(key: ValueKey('none'));
    final text = '${AppStrings.lastSeen} ${lastActive.relativeLabel}';
    return _StatusText(key: ValueKey(text), text: text);
  }
}

class _StatusText extends StatelessWidget {
  const _StatusText({required this.text, this.color, super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Text(
    text,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: context.textTheme.labelMedium?.copyWith(
      color: color ?? context.colors.textSecondary,
      fontWeight: FontWeight.w500,
    ),
  );
}
