import 'package:jiffy/jiffy.dart';
import 'package:tawasul/core/constants/app_strings.dart';

/// Chat-oriented date formatting. All labels use local time.
extension DateTimeX on DateTime {
  Jiffy get _local => Jiffy.parseFromDateTime(toLocal());

  bool isSameDay(DateTime other) {
    final a = toLocal();
    final b = other.toLocal();
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool get isToday => isSameDay(DateTime.now());

  bool get isYesterday =>
      isSameDay(DateTime.now().subtract(const Duration(days: 1)));

  bool get _isWithinLastWeek {
    final now = DateTime.now();
    final local = toLocal();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfDay = DateTime(local.year, local.month, local.day);
    return startOfToday.difference(startOfDay).inDays < 7;
  }

  /// `9:41 AM`
  String get timeLabel => _local.jm;

  /// Compact label for conversation lists: time, `Yesterday`, `Mon`, `9/23/2025`.
  String get conversationLabel {
    if (isToday) return timeLabel;
    if (isYesterday) return AppStrings.yesterday;
    if (_isWithinLastWeek) return _local.E;
    return _local.yMd;
  }

  /// Label for day separators inside a chat: `Today`, `Tuesday`, `Mar 5`.
  String get daySeparatorLabel {
    if (isToday) return AppStrings.today;
    if (isYesterday) return AppStrings.yesterday;
    if (_isWithinLastWeek) return _local.EEEE;
    if (toLocal().year == DateTime.now().year) return _local.MMMd;
    return _local.yMMMd;
  }

  /// `5 minutes ago`
  String get relativeLabel => _local.fromNow();
}
