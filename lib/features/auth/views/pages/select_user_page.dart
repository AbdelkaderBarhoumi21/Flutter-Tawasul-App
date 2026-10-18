import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/animation_extensions.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';
import 'package:tawasul/core/routing/app_routes.dart';
import 'package:tawasul/core/widgets/responsive_center.dart';
import 'package:tawasul/features/auth/controllers/auth_controller.dart';
import 'package:tawasul/features/auth/models/demo_user.dart';
import 'package:tawasul/features/auth/views/widgets/user_select_card.dart';
import 'package:tawasul/features/auth/views/widgets/welcome_header.dart';

class SelectUserPage extends StatefulWidget {
  const SelectUserPage({super.key});

  @override
  State<SelectUserPage> createState() => _SelectUserPageState();
}

class _SelectUserPageState extends State<SelectUserPage> {
  late final _controller = AuthController(client: context.client);

  Future<void> _onUserSelected(DemoUser user) async {
    final success = await _controller.signIn(user);
    if (!mounted) return;
    if (success) {
      await context.pushReplacementNamed<void>(AppRoutes.home);
    } else {
      context.showSnackMessage(AppStrings.signInFailed);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: ResponsiveCenter(
        maxWidth: 560,
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.xxl.w,
                  AppSpacing.huge.h,
                  AppSpacing.xxl.w,
                  AppSpacing.xxxl.h,
                ),
                sliver: const SliverToBoxAdapter(child: WelcomeHeader()),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl.w),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    AppStrings.chooseAccount.toUpperCase(),
                    style: context.textTheme.labelSmall?.copyWith(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.xl.w,
                  AppSpacing.md.h,
                  AppSpacing.xl.w,
                  AppSpacing.xxxl.h,
                ),
                sliver: SliverList.separated(
                  itemCount: DemoUser.all.length,
                  separatorBuilder: (_, _) => SizedBox(height: AppSpacing.md.h),
                  itemBuilder: (context, index) {
                    final user = DemoUser.all[index];
                    return UserSelectCard(
                      user: user,
                      isLoading: _controller.pendingUserId == user.id,
                      enabled: !_controller.isBusy,
                      onTap: () => _onUserSelected(user),
                    ).staggeredEntrance(index + 3);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
