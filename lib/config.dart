import 'package:finplus/base/app_config/app_config.dart';

void setAppDevelopment() {
  AppConfig(
    env: ENV.DEV,
    baseUrl: '123.31.12.162:3002',
    secure: false,
    marketUrl: '123.31.12.162:3002',
    marketSecure: false,
    fetchCount: 20,
    symbolStaticUrl: '123.31.12.162:9000',
    socketUrl: 'ws://123.31.12.162:8001/socketcluster/',
  );
}
