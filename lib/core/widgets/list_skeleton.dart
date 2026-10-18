import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_durations.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/extensions/context_extensions.dart';

/// Shimmering placeholder rows shown while a list loads.
class ListSkeleton extends StatelessWidget {
  const ListSkeleton({this.itemCount = 8, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm.h),
          itemCount: itemCount,
          itemBuilder: (_, index) => _SkeletonRow(
            color: colors.surfaceMuted,
            // Vary bar widths so the skeleton feels organic.
            titleFactor: 0.45 + (index % 3) * 0.1,
          ),
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: AppDurations.shimmer,
          color: colors.surface.withValues(alpha: 0.6),
        );
  }
}

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow({required this.color, required this.titleFactor});

  final Color color;
  final double titleFactor;

  @override
  Widget build(BuildContext context) {
    Widget bar(double widthFactor, double height) => FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppRadius.xs.r),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.xl.w,
        vertical: AppSpacing.md.h,
      ),
      child: Row(
        children: [
          Container(
            width: 52.r,
            height: 52.r,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: AppSpacing.md.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bar(titleFactor, 12.r),
                SizedBox(height: AppSpacing.sm.h),
                bar(0.8, 10.r),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
