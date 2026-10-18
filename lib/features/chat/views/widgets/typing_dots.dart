import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tawasul/core/constants/app_colors.dart';
import 'package:tawasul/core/constants/app_durations.dart';

/// Three softly bouncing dots, the universal "someone is typing" signal.
class TypingDots extends StatefulWidget {
  const TypingDots({
    this.color = AppColors.primary,
    this.dotSize = 5,
    super.key,
  });

  final Color color;
  final double dotSize;

  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  static const _dotCount = 3;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.typingDot,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.dotSize.r;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_dotCount, (i) {
          // Each dot runs the same sine wave, phase-shifted.
          final phase = (_controller.value - i * 0.18) * 2 * math.pi;
          final lift = math.max(0, math.sin(phase));
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size * 0.25),
            child: Transform.translate(
              offset: Offset(0, -lift * size * 0.8),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.45 + lift * 0.55),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
