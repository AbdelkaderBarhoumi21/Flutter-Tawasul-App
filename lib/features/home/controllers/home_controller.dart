import 'package:flutter/foundation.dart';
import 'package:tawasul/features/home/models/home_tab.dart';

/// Tracks the currently selected [HomeTab].
class HomeController extends ValueNotifier<HomeTab> {
  HomeController() : super(HomeTab.messages);
}
