import 'package:finplus/app/app.dart';
import 'package:finplus/config.dart';
import 'package:finplus/global.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

Future<void> main() async {
  setAppDevelopment();

  final wsUrl = Uri.parse('ws://10.0.0.2/my-websocket-endpoint');
  final channel = WebSocketChannel.connect(wsUrl);

  await channel.ready;

  channel.stream.listen((message) {
    print(message);
  });
  await Global.initial();
  runApp(const Healhub());
}
