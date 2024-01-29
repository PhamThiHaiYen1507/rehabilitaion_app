import 'package:commons/commons.dart';
import 'package:finplus/providers/login_provider.dart';

class HomeController extends GetxController {
  late final LoginProvider loginProvider;
  @override
  void onInit() {
    loginProvider = LoginProvider();
    webSocket();
    super.onInit();
  }

  void webSocket() {}
}
