import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/utils/app_logger.dart';
import 'package:tawasul/core/widgets/app_empty_state.dart';

/// User-friendly error screen. The raw [error] is logged, never shown.
class AppErrorView extends StatefulWidget {
  const AppErrorView({this.error, this.onRetry, super.key});

  final Object? error;
  final VoidCallback? onRetry;

  @override
  State<AppErrorView> createState() => _AppErrorViewState();
}

class _AppErrorViewState extends State<AppErrorView> {
  @override
  void initState() {
    super.initState();
    if (widget.error != null) appLogger.e('UI error', error: widget.error);
  }

  @override
  Widget build(BuildContext context) => AppEmptyState(
    icon: CupertinoIcons.exclamationmark_triangle,
    title: AppStrings.errorTitle,
    message: AppStrings.errorMessage,
    accentColor: AppColors.error,
    action: widget.onRetry == null
        ? null
        : FilledButton.tonal(
            onPressed: widget.onRetry,
            child: const Text(AppStrings.retry),
          ),
  );
}
