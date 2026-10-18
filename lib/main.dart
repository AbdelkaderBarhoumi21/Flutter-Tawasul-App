import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/app/tawasul_app.dart';
import 'package:tawasul/core/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.load();

  final client = StreamChatClient(AppConfig.streamApiKey);
  runApp(TawasulApp(client: client));
}
