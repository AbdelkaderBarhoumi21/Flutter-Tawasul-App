import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/animation_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/core/routing/app_routes.dart';
import 'package:tawasul/core/widgets/app_empty_state.dart';
import 'package:tawasul/core/widgets/app_paged_list_view.dart';
import 'package:tawasul/features/contacts/controllers/contacts_controller.dart';
import 'package:tawasul/features/contacts/views/widgets/contact_tile.dart';

/// Contact list. Tapping a contact opens (or creates) the conversation.
class ContactsPage extends StatefulWidget {
  const ContactsPage({this.onConversationReady, super.key});

  /// Called with the opened channel. Defaults to pushing the chat screen.
  final ValueChanged<Channel>? onConversationReady;

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late final _controller = ContactsController(client: context.client);

  Future<void> _openConversation(User user) async {
    final channel = await _controller.openConversationWith(user);
    if (!mounted) return;
    if (channel == null) {
      context.showSnackMessage(AppStrings.openChatFailed);
    } else if (widget.onConversationReady != null) {
      widget.onConversationReady!(channel);
    } else {
      await context.pushNamed<void>(AppRoutes.chat, arguments: channel);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<String?>(
    valueListenable: _controller.pendingUserId,
    builder: (_, pendingUserId, _) => AppPagedListView<User>(
      controller: _controller.users,
      padding: EdgeInsets.only(top: AppSpacing.xs.h, bottom: AppSpacing.lg.h),
      emptyBuilder: (_) => const AppEmptyState(
        icon: CupertinoIcons.person_2,
        title: AppStrings.noContactsTitle,
        message: AppStrings.noContactsMessage,
      ),
      itemBuilder: (_, user, index) => ContactTile(
        key: ValueKey(user.id),
        user: user,
        isLoading: pendingUserId == user.id,
        onTap: () => _openConversation(user),
      ).staggeredEntrance(index),
    ),
  );
}
