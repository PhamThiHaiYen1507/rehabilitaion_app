import 'package:finplus/base/app_config/app_config.dart';

void setAppDevelopment() {
  AppConfig(
    env: ENV.DEV,
    baseUrl: '10.0.2.2:9090',
    secure: false,
    marketUrl: '10.0.2.2:9090',
    marketSecure: false,
    fetchCount: 20,
    symbolStaticUrl: '10.0.2.2:9090',
    socketUrl: 'ws://123.31.12.162:8001/socketcluster/',
  );
}
