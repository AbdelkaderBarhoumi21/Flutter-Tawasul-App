import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/animation_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/core/widgets/app_empty_state.dart';
import 'package:tawasul/core/widgets/app_paged_list_view.dart';
import 'package:tawasul/features/conversations/controllers/conversations_controller.dart';
import 'package:tawasul/features/conversations/views/widgets/conversation_tile.dart';
import 'package:tawasul/features/conversations/views/widgets/stories_bar.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  late final _controller = ConversationsController(client: context.client);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AppPagedListView<Channel>(
    controller: _controller.channels,
    padding: EdgeInsets.only(bottom: AppSpacing.lg.h),
    header: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.xl.w,
            AppSpacing.sm.h,
            AppSpacing.xl.w,
            0,
          ),
          child: Text(
            AppStrings.stories,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ),
        StoriesBar(stories: _controller.stories),
        SizedBox(height: AppSpacing.xs.h),
      ],
    ),
    emptyBuilder: (_) => const AppEmptyState(
      icon: CupertinoIcons.chat_bubble_2,
      title: AppStrings.noConversationsTitle,
      message: AppStrings.noConversationsMessage,
    ),
    itemBuilder: (_, channel, index) => ConversationTile(
      key: ValueKey(channel.cid),
      channel: channel,
    ).staggeredEntrance(index),
  );
}
