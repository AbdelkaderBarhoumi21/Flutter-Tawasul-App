import 'package:flutter/widgets.dart';

/// Spacing scale (logical pixels on the design canvas).
///
/// Apply ScreenUtil at the call site: `AppSpacing.lg.w`, `AppSpacing.md.h`,
/// `AppSpacing.sm.r`.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;
}

/// Corner radius scale.
abstract final class AppRadius {
  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 22;
  static const double xxl = 28;
  static const double pill = 999;
}

/// Icon size scale.
abstract final class AppIconSize {
  static const double sm = 16;
  static const double md = 20;
  static const double lg = 24;
  static const double xl = 28;
  static const double huge = 40;
}

/// Fixed component dimensions.
abstract final class AppDimensions {
  static const double iconButton = 44;
  static const double actionButton = 56;
  static const double sendButton = 46;
  static const double navBarHeight = 68;
  static const double storiesHeight = 104;
  static const double bubbleMaxWidthFactor = 0.75;
}

/// Layout breakpoints and ScreenUtil design canvases.
abstract final class AppBreakpoints {
  static const double tablet = 600;

  /// Content never stretches wider than this on large screens.
  static const double maxContentWidth = 720;

  static const Size mobileDesignSize = Size(390, 844);
  static const Size tabletDesignSize = Size(834, 1194);
}
