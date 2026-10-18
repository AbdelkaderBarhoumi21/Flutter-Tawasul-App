import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tawasul/core/constants/app_strings.dart';
import 'package:tawasul/core/extensions/date_time_extensions.dart';
import 'package:tawasul/core/extensions/string_extensions.dart';
import 'package:tawasul/core/theme/app_theme.dart';
import 'package:tawasul/core/widgets/app_avatar.dart';
import 'package:tawasul/core/widgets/app_empty_state.dart';

Widget _wrap(Widget child) => ScreenUtilInit(
  designSize: const Size(390, 844),
  builder: (_, _) => MaterialApp(
    theme: AppTheme.light(),
    home: Scaffold(body: child),
  ),
);

void main() {
  group('StringX.initials', () {
    test('uses the first letter of up to two words', () {
      expect('Gordon Hayes'.initials, 'GH');
      expect('salvatore'.initials, 'S');
      expect('Ana Maria Lopez'.initials, 'AM');
    });

    test('falls back to ? for blank input', () {
      expect(''.initials, '?');
      expect('   '.initials, '?');
    });
  });

  group('DateTimeX', () {
    test('labels today and yesterday', () {
      final now = DateTime.now();
      expect(now.daySeparatorLabel, AppStrings.today);
      expect(
        now.subtract(const Duration(days: 1)).daySeparatorLabel,
        AppStrings.yesterday,
      );
      expect(
        now.subtract(const Duration(days: 1)).conversationLabel,
        AppStrings.yesterday,
      );
    });

    test('isSameDay ignores the time of day', () {
      final morning = DateTime(2026, 3, 5, 8);
      final evening = DateTime(2026, 3, 5, 22);
      expect(morning.isSameDay(evening), isTrue);
      expect(morning.isSameDay(DateTime(2026, 3, 6, 8)), isFalse);
    });
  });

  testWidgets('AppAvatar shows initials when there is no image', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const AppAvatar(name: 'Deven Joshi')));
    expect(find.text('DJ'), findsOneWidget);
  });

  testWidgets('AppEmptyState renders its title, message and action', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        AppEmptyState(
          icon: Icons.inbox,
          title: 'Empty',
          message: 'Nothing here',
          action: TextButton(onPressed: () {}, child: const Text('Retry')),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Empty'), findsOneWidget);
    expect(find.text('Nothing here'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}
