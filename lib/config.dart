import 'package:finplus/base/app_config/app_config.dart';

void setAppDevelopment() {
  AppConfig(
    env: ENV.DEV,
    baseUrl: 'rehab.serveo.net',
    secure: true,
    fetchCount: 20,
  );
}
