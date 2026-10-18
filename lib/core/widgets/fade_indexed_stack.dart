import 'package:flutter/material.dart';
import 'package:tawasul/core/constants/app_durations.dart';

/// An [IndexedStack] that cross-fades between children and keeps their state.
///
/// Children are built lazily the first time they are selected.
class FadeIndexedStack extends StatefulWidget {
  const FadeIndexedStack({
    required this.index,
    required this.children,
    super.key,
  });

  final int index;
  final List<Widget> children;

  @override
  State<FadeIndexedStack> createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack> {
  late final Set<int> _visited = {widget.index};

  @override
  void didUpdateWidget(covariant FadeIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    _visited.add(widget.index);
  }

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      for (var i = 0; i < widget.children.length; i++)
        if (_visited.contains(i))
          _FadeChild(isActive: i == widget.index, child: widget.children[i])
        else
          const SizedBox.shrink(),
    ],
  );
}

class _FadeChild extends StatelessWidget {
  const _FadeChild({required this.isActive, required this.child});

  final bool isActive;
  final Widget child;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    ignoring: !isActive,
    child: ExcludeSemantics(
      excluding: !isActive,
      // The fade must stay outside TickerMode: a muted ticker would freeze
      // the fade-out and leave hidden pages visible.
      child: AnimatedOpacity(
        opacity: isActive ? 1 : 0,
        duration: AppDurations.normal,
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: isActive ? Offset.zero : const Offset(0, 0.015),
          duration: AppDurations.normal,
          curve: Curves.easeOutCubic,
          child: TickerMode(enabled: isActive, child: child),
        ),
      ),
    ),
  );
}
