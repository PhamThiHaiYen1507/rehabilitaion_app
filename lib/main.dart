import 'dart:async';
import 'dart:convert';

import 'package:finplus/app/app.dart';
import 'package:finplus/config.dart';
import 'package:finplus/global.dart';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';

Future<void> main() async {
  setAppDevelopment();

  final Completer _completer = Completer();

  final StompClient client = StompClient(
      config: StompConfig.sockJS(
    url: 'https://rehab.serveo.net/ws',
    onConnect: (p0) {
      print('connected');
      _completer.complete();
    },
    onWebSocketError: (p0) {
      print(p0);
    },
  ));
  client.activate();

  await _completer.future;

  client.subscribe(
    destination: '/topic/public',
    callback: (p0) {
      print(p0.body);
    },
  );

  client.send(
      destination: '/topic/public',
      body: json.encode({'type': 'CHAT', 'content': 'test nhe', 'sender': 'n'}),
      headers: {'content-type': 'application/json'});

  await Global.initial();
  runApp(const Healhub());
}
