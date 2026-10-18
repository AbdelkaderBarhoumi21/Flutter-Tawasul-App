import 'package:flutter/cupertino.dart';
import 'package:tawasul/core/constants/app_strings.dart';

/// Top-level destinations of the home screen, in bottom-bar order.
enum HomeTab {
  messages(
    title: AppStrings.messages,
    navLabel: AppStrings.navChats,
    icon: CupertinoIcons.chat_bubble_2,
    activeIcon: CupertinoIcons.chat_bubble_2_fill,
  ),
  notifications(
    title: AppStrings.notifications,
    navLabel: AppStrings.navAlerts,
    icon: CupertinoIcons.bell,
    activeIcon: CupertinoIcons.bell_fill,
  ),
  calls(
    title: AppStrings.calls,
    navLabel: AppStrings.navCalls,
    icon: CupertinoIcons.phone,
    activeIcon: CupertinoIcons.phone_fill,
  ),
  contacts(
    title: AppStrings.contacts,
    navLabel: AppStrings.navPeople,
    icon: CupertinoIcons.person_2,
    activeIcon: CupertinoIcons.person_2_fill,
  );

  const HomeTab({
    required this.title,
    required this.navLabel,
    required this.icon,
    required this.activeIcon,
  });

  /// Large header title.
  final String title;

  /// Compact bottom-bar label.
  final String navLabel;
  final IconData icon;
  final IconData activeIcon;
}
