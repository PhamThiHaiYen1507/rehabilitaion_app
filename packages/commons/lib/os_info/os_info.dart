import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

@immutable
class OsInfo {
  late final String _uuid;
  late final String _version;
  late final String _buildNumber;

  static OsInfo? _instance;

  static String get uuid => _instance!._uuid;

  static String get version => _instance!._version;

  static String get buildNumber => _instance!._buildNumber;

  static Future<void> init() async {
    final deviceInfo = DeviceInfoPlugin();
    String id = '';
    if (Platform.isIOS) {
      // import 'dart:io'
      final iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      id = androidDeviceInfo.id;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _instance ??= OsInfo._internal(
      uuid: id,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }

  OsInfo._internal({
    required final String uuid,
    required final String version,
    required final String buildNumber,
  }) {
    _uuid = uuid;
    _version = version;
    _buildNumber = buildNumber;
  }
}
