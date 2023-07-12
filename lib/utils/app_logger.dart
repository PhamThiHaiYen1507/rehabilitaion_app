import 'package:commons/commons.dart';
import 'package:finplus/base/app_config/app_config.dart';
import 'package:flutter/foundation.dart';

final _AppLoggerImp _loggerImp = _AppLoggerImp();

class _AppLoggerImp extends AppLoggerDefine {
  _AppLoggerImp()
      : super(AppConfig.info.env == ENV.DEV ||
            (AppConfig.info.env == ENV.PROD && kDebugMode));
}

void logD(dynamic message) {
  _loggerImp.logD(message);
}

void logW(dynamic message) {
  _loggerImp.logW(message);
}

void logE(dynamic message, [StackTrace? stackTrace]) {
  _loggerImp.logE(message, stackTrace);
}
