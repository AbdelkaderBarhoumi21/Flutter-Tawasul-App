import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/utils/app_logger.dart';

/// Business logic of a single chat: composing, sending, typing events,
/// read receipts and history pagination.
class ChatController {
  ChatController({required this.channel}) {
    _unreadSubscription = channel.state!.unreadCountStream.listen(_markRead);
    textController.addListener(_onTextChanged);
  }

  final Channel channel;
  final textController = TextEditingController();
  final messageListController = MessageListController();

  /// Whether the composer currently holds sendable text.
  final canSend = ValueNotifier<bool>(false);

  /// Messages created after this moment get an entrance animation.
  final DateTime openedAt = DateTime.now();

  late final StreamSubscription<int> _unreadSubscription;

  void _onTextChanged() {
    final hasText = textController.text.trim().isNotEmpty;
    canSend.value = hasText;
    if (hasText) unawaited(channel.keyStroke());
  }

  Future<void> _markRead(int unreadCount) async {
    if (unreadCount > 0) await channel.markRead();
  }

  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    textController.clear();
    try {
      await channel.sendMessage(Message(text: text));
      await channel.stopTyping();
    } on Exception catch (error, stackTrace) {
      appLogger.e('Send message failed', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> loadOlderMessages() async =>
      messageListController.paginateData?.call();

  void dispose() {
    unawaited(_unreadSubscription.cancel());
    textController
      ..removeListener(_onTextChanged)
      ..dispose();
    canSend.dispose();
  }
}
