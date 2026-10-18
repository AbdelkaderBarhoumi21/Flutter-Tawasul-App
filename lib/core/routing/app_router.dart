import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/routing/app_routes.dart';
import 'package:tawasul/core/widgets/app_empty_state.dart';
import 'package:tawasul/features/auth/views/pages/select_user_page.dart';
import 'package:tawasul/features/chat/views/pages/chat_page.dart';
import 'package:tawasul/features/home/views/pages/home_page.dart';
import 'package:tawasul/features/profile/views/pages/profile_page.dart';

/// Maps [AppRoutes] to pages. Transitions come from the theme's
/// `pageTransitionsTheme`.
abstract final class AppRouter {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    final page = switch ((settings.name, settings.arguments)) {
      (AppRoutes.selectUser, _) => const SelectUserPage(),
      (AppRoutes.home, _) => const HomePage(),
      (AppRoutes.profile, _) => const ProfilePage(),
      (AppRoutes.chat, final Channel channel) => StreamChannel(
        channel: channel,
        child: ChatPage(channel: channel),
      ),
      _ => const _NotFoundPage(),
    };
    return MaterialPageRoute<void>(settings: settings, builder: (_) => page);
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: const AppEmptyState(
      icon: CupertinoIcons.compass,
      title: AppStrings.pageNotFound,
      message: AppStrings.errorMessage,
    ),
  );
}
