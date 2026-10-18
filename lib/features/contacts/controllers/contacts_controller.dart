import 'package:flutter/foundation.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/utils/app_logger.dart';

/// Lists every other user and opens one-to-one conversations with them.
class ContactsController {
  ContactsController({required StreamChatClient client})
    : _client = client,
      users = StreamUserListController(
        client: client,
        filter: Filter.notEqual('id', client.state.currentUser!.id),
        sort: const [SortOption.asc('name')],
        limit: _pageSize,
      ) {
    users.doInitialLoad();
  }

  static const _pageSize = 20;

  final StreamChatClient _client;
  final StreamUserListController users;

  /// Id of the contact whose conversation is being opened, if any.
  final pendingUserId = ValueNotifier<String?>(null);

  /// Gets (or creates) the direct channel with [user] and starts watching it.
  Future<Channel?> openConversationWith(User user) async {
    if (pendingUserId.value != null) return null;
    pendingUserId.value = user.id;
    try {
      final channel = _client.channel(
        'messaging',
        extraData: {
          'members': [_client.state.currentUser!.id, user.id],
        },
      );
      await channel.watch();
      return channel;
    } on Exception catch (error, stackTrace) {
      appLogger.e(
        'Open conversation failed',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    } finally {
      pendingUserId.value = null;
    }
  }

  void dispose() {
    users.dispose();
    pendingUserId.dispose();
  }
}
