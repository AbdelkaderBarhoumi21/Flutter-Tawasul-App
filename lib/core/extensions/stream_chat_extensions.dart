import 'package:flutter/widgets.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Shortcuts to the Stream Chat client from any widget below `StreamChatCore`.
extension StreamChatContextX on BuildContext {
  StreamChatClient get client => StreamChatCore.of(this).client;

  User? get currentUser => StreamChatCore.of(this).currentUser;
}
