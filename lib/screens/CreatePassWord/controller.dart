import 'package:commons/commons.dart';
import 'package:flutter/widgets.dart';

class CreatePassWordController extends GetxController {
  late final TextEditingController password, confirmPassWord;
  late final FocusNode passwordFocus, confirmPassWordFocus;
  late final RxString confirmPassWordError;
  late final RxBool showPassword, showConfirmPassword, enabled;

  @override
  void onInit() {
    password = TextEditingController();
    confirmPassWord = TextEditingController();
    passwordFocus = FocusNode();
    confirmPassWordFocus = FocusNode();
    confirmPassWordError = RxString('');
    showPassword = RxBool(false);
    showConfirmPassword = RxBool(false);
    enabled = RxBool(false);
    super.onInit();
  }

  Future<void> onConfirm() async {}
  @override
  void onClose() {
    password.dispose();
    confirmPassWord.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    password.addListener(() {
      confirmPassWord.addListener(() {
        enabled(password.text.trim().isNotEmpty &&
            confirmPassWord.text.trim().isNotEmpty);
      });
    });
    super.onReady();
  }
}
