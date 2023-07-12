import 'dart:async';

import 'package:commons/commons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

typedef ConnectionChangeFunc = void Function(bool hasConnect);

class AppConnection {
  late final Map<String, ConnectionChangeFunc> _listeners = {};

  // ignore: cancel_subscriptions
  late final StreamSubscription<ConnectivityResult> _subscription;

  static late final AppConnection _instance;

  bool _hasConnect = true;

  static Future<void> init() async {
    _instance = AppConnection._();

    await _instance._checkConnection();
  }

  static bool get hasConnection => _instance._hasConnect;

  AppConnection._() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      await _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    final internetChecker = InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 30),
      checkInterval: const Duration(seconds: 30),
    );
    _hasConnect = await internetChecker.hasConnection;

    for (final element in _listeners.entries) {
      element.value(_hasConnect);
    }
  }

  static void addListener(ConnectionChangeFunc onListen, [String? id]) {
    final generateId = id ?? const Uuid().v4();
    _instance._listeners[generateId] = onListen;
  }

  static void removeListener(String id) {
    _instance._listeners.remove(id);
  }

  static void closeListenerConnection() {
    _instance._subscription.cancel();
    _instance._listeners.clear();
  }
}
