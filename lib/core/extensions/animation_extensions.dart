import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tawasul/core/constants/app_durations.dart';

extension EntranceAnimationX on Widget {
  /// Fades and slides the widget up into place, staggered by [index].
  ///
  /// Only the first few items are delayed so long lists stay snappy.
  Widget staggeredEntrance(int index) =>
      animate(
            delay: index < AppDurations.maxStaggeredItems
                ? AppDurations.stagger * index
                : Duration.zero,
          )
          .fadeIn(duration: AppDurations.normal, curve: Curves.easeOut)
          .slideY(
            begin: 0.12,
            end: 0,
            duration: AppDurations.normal,
            curve: Curves.easeOutCubic,
          );

  /// A gentle pop-in used for empty states and headers.
  Widget popIn({Duration delay = Duration.zero}) => animate(delay: delay)
      .fadeIn(duration: AppDurations.slow, curve: Curves.easeOut)
      .scaleXY(
        begin: 0.92,
        end: 1,
        duration: AppDurations.slow,
        curve: Curves.easeOutBack,
      );
}
