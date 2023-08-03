// ignore_for_file: constant_identifier_names

import 'package:firebase_remote_config/firebase_remote_config.dart';

enum ENV { DEV, PROD }

class AppConfig {
  final ENV env;
  final int fetchCount;
  String baseUrl;
  bool secure;

  static AppConfig? _info;

  static AppConfig get info => _info!;

  factory AppConfig({
    required ENV env,
    required String baseUrl,
    required bool secure,
    required int fetchCount,
  }) {
    _info ??= AppConfig._internal(
      env: env,
      baseUrl: baseUrl,
      secure: secure,
      fetchCount: fetchCount,
    );
    return _info!;
  }

  AppConfig._internal({
    required this.env,
    required this.baseUrl,
    required this.secure,
    required this.fetchCount,
  });

  Map<String, dynamic> getConfig() {
    return {
      'baseUrl': baseUrl,
      'secure': secure,
    };
  }

  void updateConfig(Map<String, RemoteConfigValue> data) {
    baseUrl = data['baseUrl']?.asString() ?? baseUrl;
    secure = data['secure']?.asBool() ?? secure;
  }
}
