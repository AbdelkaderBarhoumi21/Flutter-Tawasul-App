import 'package:flutter/cupertino.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/widgets/app_empty_state.dart';

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) => const AppEmptyState(
    icon: CupertinoIcons.phone,
    title: AppStrings.callsEmptyTitle,
    message: AppStrings.callsEmptyMessage,
    accentColor: AppColors.success,
  );
}
