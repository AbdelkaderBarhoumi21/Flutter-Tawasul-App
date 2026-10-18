import 'package:flutter/cupertino.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/widgets/app_empty_state.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) => const AppEmptyState(
    icon: CupertinoIcons.bell,
    title: AppStrings.notificationsEmptyTitle,
    message: AppStrings.notificationsEmptyMessage,
    accentColor: AppColors.warning,
  );
}
