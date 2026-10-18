import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';
import 'package:tawasul/core/extensions/string_extensions.dart';
import 'package:tawasul/core/widgets/pressable_scale.dart';

enum AvatarSize {
  xs(32),
  sm(40),
  md(52),
  lg(64),
  xl(104);

  const AvatarSize(this.dimension);

  final double dimension;
}

/// Circular user avatar with an initials fallback, an optional online
/// indicator and an optional gradient story ring.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    this.imageUrl,
    this.name,
    this.size = AvatarSize.md,
    this.isOnline = false,
    this.showStoryRing = false,
    this.onTap,
    super.key,
  });

  final String? imageUrl;
  final String? name;
  final AvatarSize size;
  final bool isOnline;
  final bool showStoryRing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dimension = size.dimension.r;
    final fallback = _InitialsFallback(name: name, dimension: dimension);
    final url = imageUrl;

    Widget avatar = ClipOval(
      child: SizedBox.square(
        dimension: dimension,
        child: url == null || url.isEmpty
            ? fallback
            : CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                fadeInDuration: AppDurations.normal,
                placeholder: (_, _) => fallback,
                errorWidget: (_, _, _) => fallback,
              ),
      ),
    );

    if (showStoryRing) {
      avatar = DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppGradients.story,
        ),
        child: Padding(
          padding: EdgeInsets.all(2.5.r),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.background,
            ),
            child: Padding(padding: EdgeInsets.all(2.5.r), child: avatar),
          ),
        ),
      );
    }

    if (isOnline) {
      final dotSize = dimension * 0.28;
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colors.background,
                  width: dotSize * 0.18,
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (onTap == null) return avatar;
    return PressableScale(onTap: onTap, semanticLabel: name, child: avatar);
  }
}

class _InitialsFallback extends StatelessWidget {
  const _InitialsFallback({required this.name, required this.dimension});

  final String? name;
  final double dimension;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(gradient: AppGradients.soft(AppColors.primary)),
    child: Center(
      child: Text(
        (name ?? '').initials,
        style: TextStyle(
          fontSize: dimension * 0.36,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    ),
  );
}
