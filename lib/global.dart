import 'package:commons/app_logger/app_logger.dart';
import 'package:commons/commons.dart';
import 'package:commons/os_info/os_info.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:finplus/base/network/app_connection.dart';
import 'package:finplus/utils/types.dart';
import 'package:finplus/widgets/LoadingIndicator/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base/app_config/app_config.dart';

void showLoadingCircle() => Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: const SizedBox.expand(
          child: Center(
            child: LoadingIndicator(),
          ),
        ),
      ),
      barrierDismissible: true,
      routeSettings: const RouteSettings(name: 'loading'),
    );

void hideLoadingCircle() => Get.back(result: false, closeOverlays: true);

class Global {
  static Future<void> initial() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterCryptography.registerWith();
    if (AppConfig.info.env == ENV.DEV ||
        (AppConfig.info.env == ENV.PROD && kDebugMode)) AppLogger.init();

    if (!kIsWeb) AppConnection.init();
    await Storage.init();
    if (!kIsWeb) await OsInfo.init();

    LoadingOverlay(barrierColor: Colors.black26);

    final String? params =
        Storage.get<String>(KEY.SAVE_LOGIN_PARAMS.toString());
    if (params != null && params.isNotEmpty) {
      //loginData = await LoginProvider().login(saveParams: saveParams);
    }
  }
}
