import 'package:flutter/material.dart';
import 'package:tawasul/core/constants/app_durations.dart';

/// Scales its [child] down slightly while pressed, giving tactile feedback.
class PressableScale extends StatefulWidget {
  const PressableScale({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.pressedScale = 0.96,
    this.semanticLabel,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressedScale;
  final String? semanticLabel;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  var _isPressed = false;

  bool get _enabled => widget.onTap != null || widget.onLongPress != null;

  void _updatePressed({required bool pressed}) {
    if (_isPressed == pressed || !_enabled) return;
    setState(() => _isPressed = pressed);
  }

  @override
  Widget build(BuildContext context) => Semantics(
    button: _enabled,
    label: widget.semanticLabel,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (_) => _updatePressed(pressed: true),
      onTapUp: (_) => _updatePressed(pressed: false),
      onTapCancel: () => _updatePressed(pressed: false),
      child: AnimatedScale(
        scale: _isPressed ? widget.pressedScale : 1,
        duration: AppDurations.fast,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    ),
  );
}
