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
import 'package:tawasul/core/widgets/app_avatar.dart';
import 'package:tawasul/core/widgets/app_icon_button.dart';
import 'package:tawasul/core/widgets/app_loading_indicator.dart';
import 'package:tawasul/core/widgets/responsive_center.dart';
import 'package:tawasul/features/auth/controllers/auth_controller.dart';
import 'package:tawasul/features/home/views/widgets/home_header.dart';
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
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.profile),
        leading: Center(
          child: AppIconButton(
            icon: CupertinoIcons.back,
            tooltip: AppStrings.back,
            onTap: context.pop,
          ),
        ),
      ),
      body: ResponsiveCenter(
        maxWidth: 560,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xl.w,
            vertical: AppSpacing.lg.h,
          ),
          children: [
            Center(
              child: Hero(
                tag: HomeHeader.profileHeroTag,
                child: AppAvatar(
                  imageUrl: user?.image,
                  name: user?.name,
                  size: AvatarSize.xl,
                  showStoryRing: true,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.lg.h),
            Text(
              user?.name ?? AppStrings.noName,
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall,
            ).staggeredEntrance(1),
            SizedBox(height: AppSpacing.xs.h),
            Text(
              '@${user?.id ?? ''}',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: context.colors.textSecondary,
              ),
            ).staggeredEntrance(2),
            SizedBox(height: AppSpacing.xxxl.h),
            const _SectionLabel(AppStrings.appearance).staggeredEntrance(3),
            const ThemeModeSelector().staggeredEntrance(4),
            SizedBox(height: AppSpacing.xxl.h),
            const _SectionLabel(AppStrings.account).staggeredEntrance(5),
            ListenableBuilder(
              listenable: _authController,
              builder: (context, _) => FilledButton.tonalIcon(
                style: FilledButton.styleFrom(
                  foregroundColor: AppColors.error,
                  backgroundColor: AppColors.error.withValues(alpha: 0.1),
                ),
                onPressed: _authController.isBusy ? null : _signOut,
                icon: _authController.isSigningOut
                    ? const AppLoadingIndicator(
                        size: 18,
                        color: AppColors.error,
                      )
                    : const Icon(CupertinoIcons.square_arrow_right),
                label: const Text(AppStrings.signOut),
              ),
            ).staggeredEntrance(6),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(left: AppSpacing.xs.w, bottom: AppSpacing.sm.h),
    child: Text(
      text.toUpperCase(),
      style: context.textTheme.labelSmall?.copyWith(
        letterSpacing: 1.2,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
