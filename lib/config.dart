import 'package:finplus/base/app_config/app_config.dart';

void setAppDevelopment() {
  AppConfig(
    env: ENV.DEV,
    baseUrl: 'healhub.serveo.net',
    secure: true,
    fetchCount: 20,
  );
}
