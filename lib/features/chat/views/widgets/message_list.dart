import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/extensions/date_time_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/features/chat/views/widgets/date_separator.dart';
import 'package:tawasul/features/chat/views/widgets/message_bubble.dart';

/// Reversed list of messages with day separators, sender grouping and
/// infinite scroll towards older history.
class MessageList extends StatelessWidget {
  const MessageList({
    required this.messages,
    required this.animateAfter,
    required this.onLoadOlder,
    super.key,
  });

  /// Messages ordered newest first, as provided by `MessageListCore`.
  final List<Message> messages;

  /// Only messages created after this moment animate in.
  final DateTime animateAfter;
  final VoidCallback onLoadOlder;

  /// Messages further apart than this start a new visual group.
  static const _groupingWindow = Duration(minutes: 3);

  /// Distance from the top (in pixels) at which older messages are fetched.
  static const _loadOlderThreshold = 300.0;

  static bool _belongTogether(Message a, Message b) =>
      a.user?.id == b.user?.id &&
      a.createdAt.isSameDay(b.createdAt) &&
      a.createdAt.difference(b.createdAt).abs() < _groupingWindow;

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics.extentAfter < _loadOlderThreshold) onLoadOlder();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.currentUser?.id;
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: ListView.builder(
        reverse: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg.w,
          vertical: AppSpacing.md.h,
        ),
        itemCount: messages.length,
        // Lets existing bubbles keep their element (and finished animation)
        // when a new message shifts every index by one.
        findChildIndexCallback: (key) {
          if (key is! ValueKey<String>) return null;
          final index = messages.indexWhere((m) => m.id == key.value);
          return index < 0 ? null : index;
        },
        itemBuilder: (context, index) {
          final message = messages[index];
          final older = index + 1 < messages.length
              ? messages[index + 1]
              : null;
          final newer = index > 0 ? messages[index - 1] : null;
          final startsNewDay =
              older == null || !message.createdAt.isSameDay(older.createdAt);

          return Column(
            key: ValueKey(message.id),
            children: [
              if (startsNewDay) DateSeparator(date: message.createdAt),
              MessageBubble(
                message: message,
                isMine: message.user?.id == currentUserId,
                isFirstInGroup:
                    older == null || !_belongTogether(message, older),
                isLastInGroup:
                    newer == null || !_belongTogether(message, newer),
                animate: message.createdAt.isAfter(animateAfter),
              ),
            ],
          );
        },
      ),
    );
  }
}
