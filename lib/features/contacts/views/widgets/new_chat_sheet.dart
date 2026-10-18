import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/routing/app_routes.dart';
import 'package:tawasul/features/contacts/views/pages/contacts_page.dart';

/// Bottom sheet for starting a new conversation from the contact list.
abstract final class NewChatSheet {
  static const _heightFactor = 0.8;

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContentWidth),
    builder: (sheetContext) => FractionallySizedBox(
      heightFactor: _heightFactor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl.w),
            child: Text(
              AppStrings.startConversation,
              style: sheetContext.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: AppSpacing.sm.h),
          Expanded(
            child: ContactsPage(
              onConversationReady: (channel) {
                sheetContext.pop();
                context.pushNamed<void>(AppRoutes.chat, arguments: channel);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
