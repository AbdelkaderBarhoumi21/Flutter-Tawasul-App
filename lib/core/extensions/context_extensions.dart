import 'package:flutter/material.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/theme/app_theme_colors.dart';

extension ThemeContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  AppThemeColors get colors => theme.extension<AppThemeColors>()!;
  bool get isDarkMode => theme.brightness == Brightness.dark;
}

extension LayoutContextX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  bool get isTablet => screenSize.shortestSide >= AppBreakpoints.tablet;
}

extension NavigationContextX on BuildContext {
  Future<T?> pushNamed<T extends Object?>(String route, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(route, arguments: arguments);

  Future<T?> pushReplacementNamed<T extends Object?>(
    String route, {
    Object? arguments,
  }) => Navigator.of(
    this,
  ).pushReplacementNamed<T, Object?>(route, arguments: arguments);

  /// Pushes [route] and removes every route below it.
  Future<T?> pushNamedAndClearStack<T extends Object?>(
    String route, {
    Object? arguments,
  }) => Navigator.of(
    this,
  ).pushNamedAndRemoveUntil<T>(route, (_) => false, arguments: arguments);

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop<T>(result);
}

extension FeedbackContextX on BuildContext {
  void showSnackMessage(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void showComingSoon() => showSnackMessage(AppStrings.comingSoon);
}
