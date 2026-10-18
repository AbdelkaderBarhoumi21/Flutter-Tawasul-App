import 'package:logger/logger.dart';

/// App-wide logger. Use instead of `print`/`debugPrint`.
final Logger appLogger = Logger(printer: PrettyPrinter(methodCount: 0));
