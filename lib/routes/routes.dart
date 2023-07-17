import 'package:commons/commons.dart';
import 'package:finplus/screens/SignUp/index.dart';
import 'package:finplus/screens/SmartOTP/index.dart';
import 'package:finplus/screens/login/index.dart';

class Routes {
  static const String login = '/login';
  static const String sign_up = '/sign_up';
  static const String smart_otp = '/smart_otp';
}

class AppNavigate {
  static final screens = [
    GetPage(name: Routes.login, page: () => const Login()),
    GetPage(name: Routes.sign_up, page: () => const SignUp()),
    GetPage(name: Routes.smart_otp, page: () => const SmartOTP())
  ];
}
