extension StringX on String {
  /// Up to two uppercase initials, e.g. `Gordon Hayes` → `GH`.
  String get initials {
    final words = trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    if (words.isEmpty) return '?';
    return words.take(2).map((w) => w[0].toUpperCase()).join();
  }

  String get firstWord => trim().split(' ').first;
}
