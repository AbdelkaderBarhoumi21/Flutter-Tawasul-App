import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({this.size = 28, this.color, super.key});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox.square(
      dimension: size.r,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 2.5,
        strokeCap: StrokeCap.round,
        valueColor: color == null ? null : AlwaysStoppedAnimation(color),
      ),
    ),
  );
}
