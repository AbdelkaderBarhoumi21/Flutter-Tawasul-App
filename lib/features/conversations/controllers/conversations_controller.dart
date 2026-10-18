import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/features/auth/models/demo_user.dart';
import 'package:tawasul/features/conversations/models/story.dart';

/// Loads the current user's channels (most recent first) and their stories.
class ConversationsController {
  ConversationsController({required StreamChatClient client})
    : _currentUserId = client.state.currentUser!.id,
      channels = StreamChannelListController(
        client: client,
        filter: Filter.in_('members', [client.state.currentUser!.id]),
        channelStateSort: const [SortOption.desc(ChannelSortKey.lastMessageAt)],
        limit: _pageSize,
      ) {
    channels.doInitialLoad();
  }

  static const _pageSize = 20;

  final String _currentUserId;
  final StreamChannelListController channels;

  /// Demo stories from every other demo account.
  late final List<Story> stories = [
    for (final user in DemoUser.all)
      if (user.id != _currentUserId)
        Story(name: user.name, imageUrl: user.image),
  ];

  void dispose() => channels.dispose();
}
