import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration loaded from the bundled `.env` file.
///
/// See `.env.example` for the required keys.
abstract final class AppConfig {
  static const _streamApiKey = 'STREAM_API_KEY';

  static Future<void> load() => dotenv.load();

  static String get streamApiKey => dotenv.get(_streamApiKey);
}
