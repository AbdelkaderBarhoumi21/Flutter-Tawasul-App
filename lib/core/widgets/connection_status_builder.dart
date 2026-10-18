import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:tawasul/core/extensions/stream_chat_extensions.dart';

/// Rebuilds whenever the Stream Chat websocket [ConnectionStatus] changes.
class ConnectionStatusBuilder extends StatelessWidget {
  const ConnectionStatusBuilder({required this.builder, super.key});

  final Widget Function(BuildContext context, ConnectionStatus status) builder;

  @override
  Widget build(BuildContext context) {
    final client = context.client;
    return BetterStreamBuilder<ConnectionStatus>(
      stream: client.wsConnectionStatusStream,
      initialData: client.wsConnectionStatus,
      errorBuilder: (_, _) => const SizedBox.shrink(),
      builder: builder,
    );
  }
}
