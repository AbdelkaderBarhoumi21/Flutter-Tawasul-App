/// Motion tokens shared by every animation in the app.
abstract final class AppDurations {
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 280);
  static const slow = Duration(milliseconds: 450);
  static const shimmer = Duration(milliseconds: 1300);
  static const typingDot = Duration(milliseconds: 1100);

  /// Delay between consecutive items of a staggered list entrance.
  static const stagger = Duration(milliseconds: 45);

  /// Items beyond this index appear without an entrance delay.
  static const maxStaggeredItems = 10;
}
