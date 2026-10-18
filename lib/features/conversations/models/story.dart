import 'package:flutter/foundation.dart';

@immutable
class Story {
  const Story({required this.name, required this.imageUrl});

  final String name;
  final String imageUrl;
}
