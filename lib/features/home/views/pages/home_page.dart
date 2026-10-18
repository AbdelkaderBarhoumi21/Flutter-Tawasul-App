import 'package:flutter/material.dart';
import 'package:tawasul/core/widgets/fade_indexed_stack.dart';
import 'package:tawasul/core/widgets/responsive_center.dart';
import 'package:tawasul/features/calls/views/pages/calls_page.dart';
import 'package:tawasul/features/contacts/views/pages/contacts_page.dart';
import 'package:tawasul/features/contacts/views/widgets/new_chat_sheet.dart';
import 'package:tawasul/features/conversations/views/pages/conversations_page.dart';
import 'package:tawasul/features/home/controllers/home_controller.dart';
import 'package:tawasul/features/home/models/home_tab.dart';
import 'package:tawasul/features/home/views/widgets/home_header.dart';
import 'package:tawasul/features/home/views/widgets/home_nav_bar.dart';
import 'package:tawasul/features/notifications/views/pages/notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  Widget _pageFor(HomeTab tab) => switch (tab) {
    HomeTab.messages => const ConversationsPage(),
    HomeTab.notifications => const NotificationsPage(),
    HomeTab.calls => const CallsPage(),
    HomeTab.contacts => const ContactsPage(),
  };

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<HomeTab>(
    valueListenable: _controller,
    builder: (context, tab, _) => Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: ResponsiveCenter(
          child: Column(
            children: [
              HomeHeader(title: tab.title),
              Expanded(
                child: FadeIndexedStack(
                  index: tab.index,
                  children: HomeTab.values.map(_pageFor).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ResponsiveCenter(
        child: HomeNavBar(
          selected: tab,
          onSelected: (tab) => _controller.value = tab,
          onNewChat: () => NewChatSheet.show(context),
        ),
      ),
    ),
  );
}
