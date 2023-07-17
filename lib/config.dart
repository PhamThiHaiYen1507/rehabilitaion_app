import 'package:finplus/base/app_config/app_config.dart';

void setAppDevelopment() {
  AppConfig(
    env: ENV.DEV,
    baseUrl: 'localhost:9090',
    secure: false,
    marketUrl: 'localhost:9090',
    marketSecure: false,
    fetchCount: 20,
    symbolStaticUrl: 'localhost:9090',
    socketUrl: 'ws://123.31.12.162:8001/socketcluster/',
  );
}
