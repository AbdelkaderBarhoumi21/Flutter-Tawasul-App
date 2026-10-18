import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/animation_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/core/routing/app_routes.dart';
import 'package:tawasul/core/theme/theme_controller.dart';
import 'package:tawasul/core/widgets/app_loading_indicator.dart';
import 'package:tawasul/core/widgets/responsive_center.dart';
import 'package:tawasul/features/auth/controllers/auth_controller.dart';
import 'package:tawasul/features/profile/views/widgets/profile_header.dart';
import 'package:tawasul/features/profile/views/widgets/profile_quick_actions.dart';
import 'package:tawasul/features/profile/views/widgets/settings_group.dart';
import 'package:tawasul/features/profile/views/widgets/theme_mode_selector.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final _authController = AuthController(client: context.client);

  Future<void> _signOut() async {
    final success = await _authController.signOut();
    if (!mounted) return;
    if (success) {
      await context.pushNamedAndClearStack<void>(AppRoutes.selectUser);
    } else {
      context.showSnackMessage(AppStrings.signOutFailed);
    }
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    final sectionGap = SizedBox(height: AppSpacing.xxl.h);

    return Scaffold(
      body: ResponsiveCenter(
        maxWidth: 560,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: ProfileHeader(
                name: user?.name ?? AppStrings.noName,
                handle: '@${user?.id ?? ''}',
                imageUrl: user?.image,
                isOnline: user?.online ?? false,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.xl.w,
                AppSpacing.xxl.h,
                AppSpacing.xl.w,
                AppSpacing.huge.h,
              ),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverList.list(
                  children: [
                    const ProfileQuickActions().staggeredEntrance(4),
                    sectionGap,
                    SettingsGroup(
                      title: AppStrings.appearance,
                      children: [
                        SettingsTile(
                          icon: CupertinoIcons.circle_lefthalf_fill,
                          title: AppStrings.theme,
                          subtitle: ThemeModeSelector.labelOf(
                            ThemeScope.of(context).value,
                          ),
                          // The selector handles its own taps.
                          onTap: null,
                          trailing: const ThemeModeSelector(),
                        ),
                      ],
                    ).staggeredEntrance(5),
                    sectionGap,
                    SettingsGroup(
                      title: AppStrings.settings,
                      children: [
                        SettingsTile(
                          icon: CupertinoIcons.bell_fill,
                          title: AppStrings.settingsNotifications,
                          subtitle: AppStrings.settingsNotificationsSubtitle,
                          onTap: context.showComingSoon,
                        ),
                        SettingsTile(
                          icon: CupertinoIcons.lock_fill,
                          title: AppStrings.settingsPrivacy,
                          subtitle: AppStrings.settingsPrivacySubtitle,
                          onTap: context.showComingSoon,
                        ),
                        SettingsTile(
                          icon: CupertinoIcons.folder_fill,
                          title: AppStrings.settingsStorage,
                          subtitle: AppStrings.settingsStorageSubtitle,
                          onTap: context.showComingSoon,
                        ),
                        SettingsTile(
                          icon: CupertinoIcons.question_circle_fill,
                          title: AppStrings.settingsHelp,
                          subtitle: AppStrings.settingsHelpSubtitle,
                          onTap: context.showComingSoon,
                        ),
                      ],
                    ).staggeredEntrance(6),
                    sectionGap,
                    ListenableBuilder(
                      listenable: _authController,
                      builder: (context, _) => SettingsGroup(
                        title: AppStrings.account,
                        children: [
                          SettingsTile(
                            icon: CupertinoIcons.square_arrow_right,
                            title: AppStrings.signOut,
                            subtitle: AppStrings.signOutSubtitle,
                            isDestructive: true,
                            onTap: _authController.isBusy ? null : _signOut,
                            trailing: _authController.isSigningOut
                                ? const AppLoadingIndicator(
                                    size: 18,
                                    color: AppColors.error,
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ).staggeredEntrance(7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
