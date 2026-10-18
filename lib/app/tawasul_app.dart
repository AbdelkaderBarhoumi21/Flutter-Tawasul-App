import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/constants/app_sizes.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/routing/app_router.dart';
import 'package:tawasul/core/routing/app_routes.dart';
import 'package:tawasul/core/theme/app_theme.dart';
import 'package:tawasul/core/theme/theme_controller.dart';

/// Root widget: wires screen adaptation, theming, routing and Stream Chat.
class TawasulApp extends StatefulWidget {
  const TawasulApp({required this.client, super.key});

  final StreamChatClient client;

  @override
  State<TawasulApp> createState() => _TawasulAppState();
}

class _TawasulAppState extends State<TawasulApp> with WidgetsBindingObserver {
  final _themeController = ThemeController();
  late Size _designSize = _resolveDesignSize();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  /// Rebuilds only when rotation or a resize changes the canvas — not on
  /// keyboard insets, which also trigger this callback.
  @override
  void didChangeMetrics() {
    final designSize = _resolveDesignSize();
    if (designSize != _designSize) setState(() => _designSize = designSize);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _themeController.dispose();
    super.dispose();
  }

  /// Tablets get a larger canvas so the UI keeps phone-like proportions
  /// instead of being scaled up, and the canvas follows the orientation so
  /// landscape phones are not scaled down.
  static Size _resolveDesignSize() {
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final size = view.physicalSize / view.devicePixelRatio;
    final canvas = size.shortestSide >= AppBreakpoints.tablet
        ? AppBreakpoints.tabletDesignSize
        : AppBreakpoints.mobileDesignSize;
    return size.width > size.height ? canvas.flipped : canvas;
  }

  @override
  Widget build(BuildContext context) => ThemeScope(
    controller: _themeController,
    child: ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeController,
        builder: (context, themeMode, _) => MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: themeMode,
          initialRoute: AppRoutes.selectUser,
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: (context, child) =>
              StreamChatCore(client: widget.client, child: child!),
        ),
      ),
    ),
  );
}
