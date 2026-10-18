import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';

/// Rounded, softly filled icon button used in app bars and toolbars.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.size = AppDimensions.iconButton,
    this.filled = true,
    this.color,
    this.backgroundColor,
    super.key,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final double size;
  final bool filled;
  final Color? color;

  /// Overrides the default muted fill (e.g. a glass effect on gradients).
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Tooltip(
      message: tooltip,
      child: PressableScale(
        onTap: onTap,
        pressedScale: 0.9,
        semanticLabel: tooltip,
        child: Container(
          width: size.r,
          height: size.r,
          decoration: BoxDecoration(
            color: filled ? backgroundColor ?? colors.surfaceMuted : null,
            borderRadius: BorderRadius.circular(AppRadius.md.r),
          ),
          child: Icon(
            icon,
            size: AppIconSize.md.r,
            color: color ?? colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
