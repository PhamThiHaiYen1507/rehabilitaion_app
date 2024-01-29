import 'package:commons/commons.dart';

import '../layers/presentation/home/index.dart';
import '../layers/presentation/login/index.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String message = '/message';
}

class AppNavigate {
  static final screens = [
    GetPage(name: Routes.login, page: () => const Login()),
    GetPage(name: Routes.home, page: () => const Home()),
  ];
}
