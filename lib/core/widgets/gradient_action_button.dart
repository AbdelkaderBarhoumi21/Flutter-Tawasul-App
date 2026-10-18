import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';

/// Circular brand-gradient button with a soft glow, used for primary actions
/// (new chat, send).
class GradientActionButton extends StatelessWidget {
  const GradientActionButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.size = AppDimensions.actionButton,
    this.enabled = true,
    super.key,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;
  final double size;
  final bool enabled;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: PressableScale(
      onTap: enabled ? onPressed : null,
      pressedScale: 0.88,
      semanticLabel: tooltip,
      child: AnimatedOpacity(
        opacity: enabled ? 1 : 0.45,
        duration: AppDurations.fast,
        child: AnimatedContainer(
          duration: AppDurations.normal,
          curve: Curves.easeOut,
          width: size.r,
          height: size.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppGradients.primary,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: enabled ? 0.38 : 0),
                blurRadius: 18.r,
                offset: Offset(0, 6.r),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.white, size: (size * 0.42).r),
        ),
      ),
    ),
  );
}
