import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/widgets/app_icon_button.dart';
import 'package:tawasul/core/widgets/gradient_action_button.dart';
import 'package:tawasul/features/chat/controllers/chat_controller.dart';

/// Message composer: attachment button, growing text field and an animated
/// send button that wakes up as soon as there is something to send.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({required this.controller, super.key});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.sm.w,
            AppSpacing.sm.h,
            AppSpacing.md.w,
            AppSpacing.sm.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppIconButton(
                icon: CupertinoIcons.paperclip,
                tooltip: AppStrings.attach,
                filled: false,
                color: colors.textSecondary,
                onTap: context.showComingSoon,
              ),
              SizedBox(width: AppSpacing.xs.w),
              Expanded(
                child: TextField(
                  controller: controller.textController,
                  minLines: 1,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.send,
                  style: context.textTheme.bodyLarge,
                  onSubmitted: (_) => controller.sendMessage(),
                  decoration: const InputDecoration(
                    hintText: AppStrings.typeMessage,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.sm.w),
              ValueListenableBuilder<bool>(
                valueListenable: controller.canSend,
                builder: (_, canSend, _) => AnimatedScale(
                  scale: canSend ? 1 : 0.88,
                  duration: AppDurations.normal,
                  curve: Curves.easeOutBack,
                  child: AnimatedRotation(
                    turns: canSend ? 0 : -0.125,
                    duration: AppDurations.normal,
                    curve: Curves.easeOutCubic,
                    child: GradientActionButton(
                      icon: CupertinoIcons.paperplane_fill,
                      size: AppDimensions.sendButton,
                      tooltip: AppStrings.sendMessage,
                      enabled: canSend,
                      onPressed: controller.sendMessage,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
