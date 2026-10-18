import 'package:flutter/widgets.dart';
import 'package:tawasul/core/constants/app_sizes.dart';

/// Centers [child] horizontally and caps its width on tablets and desktops.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    required this.child,
    this.maxWidth = AppBreakpoints.maxContentWidth,
    super.key,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    // Size to the child vertically so it also works in unbounded slots
    // such as `Scaffold.bottomNavigationBar`.
    heightFactor: 1,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}
