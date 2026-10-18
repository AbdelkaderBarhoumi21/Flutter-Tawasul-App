import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/widgets/app_empty_state.dart';
import 'package:tawasul/core/widgets/app_error_view.dart';
import 'package:tawasul/core/widgets/app_loading_indicator.dart';
import 'package:tawasul/core/widgets/responsive_center.dart';
import 'package:tawasul/features/chat/controllers/chat_controller.dart';
import 'package:tawasul/features/chat/views/widgets/chat_app_bar.dart';
import 'package:tawasul/features/chat/views/widgets/chat_input_bar.dart';
import 'package:tawasul/features/chat/views/widgets/message_list.dart';

/// Conversation screen. Expects a `StreamChannel` ancestor (see the router).
class ChatPage extends StatefulWidget {
  const ChatPage({required this.channel, super.key});

  final Channel channel;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final _controller = ChatController(channel: widget.channel);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: ChatAppBar(channel: widget.channel),
    body: ResponsiveCenter(
      child: Column(
        children: [
          Expanded(
            child: MessageListCore(
              messageListController: _controller.messageListController,
              loadingBuilder: (_) => const AppLoadingIndicator(),
              emptyBuilder: (_) => const AppEmptyState(
                icon: CupertinoIcons.hand_raised,
                title: AppStrings.sayHelloTitle,
                message: AppStrings.sayHelloMessage,
              ),
              errorBuilder: (_, error) => AppErrorView(error: error),
              messageListBuilder: (_, messages) => MessageList(
                messages: messages,
                animateAfter: _controller.openedAt,
                onLoadOlder: _controller.loadOlderMessages,
              ),
            ),
          ),
          ChatInputBar(controller: _controller),
        ],
      ),
    ),
  );
}
