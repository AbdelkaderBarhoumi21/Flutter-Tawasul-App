import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/date_time_extensions.dart';

/// A single chat bubble for both outgoing ([isMine]) and incoming messages.
///
/// Consecutive messages from the same sender are visually grouped: inner
/// corners tighten and only the last bubble of a group shows its time.
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.isMine,
    this.isFirstInGroup = true,
    this.isLastInGroup = true,
    this.animate = false,
    super.key,
  });

  final Message message;
  final bool isMine;
  final bool isFirstInGroup;
  final bool isLastInGroup;

  /// Plays the entrance animation (used for newly arrived messages).
  final bool animate;

  /// Sender-side corners tighten inside a group; the bottom one is the tail.
  BorderRadiusDirectional _radius() {
    final large = Radius.circular(AppRadius.xl.r);
    final small = Radius.circular(AppRadius.xs.r);
    final senderTop = isFirstInGroup ? large : small;
    return isMine
        ? BorderRadiusDirectional.only(
            topStart: large,
            bottomStart: large,
            topEnd: senderTop,
            bottomEnd: small,
          )
        : BorderRadiusDirectional.only(
            topEnd: large,
            bottomEnd: large,
            topStart: senderTop,
            bottomStart: small,
          );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textColor = isMine ? AppColors.white : colors.textPrimary;
    final metaColor = isMine
        ? AppColors.white.withValues(alpha: 0.75)
        : colors.textTertiary;
    final maxWidth =
        context.screenSize.width.clamp(0, AppBreakpoints.maxContentWidth) *
        AppDimensions.bubbleMaxWidthFactor;
    final text = message.text;

    final Widget bubble = Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md.w + 2,
        vertical: AppSpacing.sm.h + 2,
      ),
      decoration: BoxDecoration(
        gradient: isMine ? AppGradients.primary : null,
        color: isMine ? null : colors.incomingBubble,
        borderRadius: _radius(),
        border: isMine ? null : Border.all(color: colors.border),
        boxShadow: isMine
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 12.r,
                  offset: Offset(0, 4.r),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text == null || text.isEmpty ? AppStrings.attach : text,
            style: context.textTheme.bodyMedium?.copyWith(color: textColor),
          ),
          if (isLastInGroup) ...[
            SizedBox(height: AppSpacing.xxs.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.createdAt.timeLabel,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: metaColor,
                    fontSize: 10.sp,
                  ),
                ),
                if (isMine) ...[
                  SizedBox(width: AppSpacing.xs.w),
                  _DeliveryIcon(state: message.state, color: metaColor),
                ],
              ],
            ),
          ],
        ],
      ),
    );

    final aligned = Padding(
      padding: EdgeInsets.only(
        top: (isFirstInGroup ? AppSpacing.sm : AppSpacing.xxs).h,
      ),
      child: Align(
        alignment: isMine
            ? AlignmentDirectional.centerEnd
            : AlignmentDirectional.centerStart,
        child: bubble,
      ),
    );

    if (!animate) return aligned;
    return aligned
        .animate()
        .fadeIn(duration: AppDurations.normal)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic)
        .scaleXY(
          begin: 0.9,
          end: 1,
          alignment: isMine ? Alignment.bottomRight : Alignment.bottomLeft,
          curve: Curves.easeOutBack,
          duration: AppDurations.normal,
        );
  }
}

class _DeliveryIcon extends StatelessWidget {
  const _DeliveryIcon({required this.state, required this.color});

  final MessageState state;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    var iconColor = color;
    if (state.isFailed) {
      icon = CupertinoIcons.exclamationmark_circle_fill;
      iconColor = AppColors.error;
    } else if (state.isOutgoing) {
      icon = CupertinoIcons.clock;
    } else {
      icon = CupertinoIcons.checkmark_alt;
    }
    return AnimatedSwitcher(
      duration: AppDurations.fast,
      child: Icon(icon, key: ValueKey(icon), size: 12.r, color: iconColor),
    );
  }
}
