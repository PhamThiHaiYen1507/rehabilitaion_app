import 'package:commons/commons.dart';
import 'package:finplus/providers/login_provider.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class LoginController extends GetxController {
  late final LoginProvider loginProvider;
  late final TextEditingController phoneNumber, password;
  late final FocusNode phoneNumberFocus, passwordFocus;
  late final Rx<String> phoneNumberError, passwordError;
  late final RxBool showPassword, enabled;

  @override
  void onInit() {
    loginProvider = LoginProvider();
    phoneNumber = TextEditingController();
    password = TextEditingController();
    phoneNumberFocus = FocusNode();
    passwordFocus = FocusNode();
    phoneNumberError = RxString('');
    passwordError = RxString('');
    showPassword = RxBool(false);
    enabled = RxBool(false);
    super.onInit();
  }

  @override
  void onReady() {
    phoneNumber.addListener(() {
      password.addListener(() {
        enabled(phoneNumber.text.trim().isNotEmpty &&
            password.text.trim().isNotEmpty);
      });
    });
    super.onReady();
  }

  Future<void> onConfirm() async {
    phoneNumberFocus.unfocus();
    passwordFocus.unfocus();
    if (Utils.validatePhoneNumber(phoneNumber.text.trim())) {
      await loginProvider.login(
          phoneNumber: phoneNumber.text.trim(), password: password.text.trim());
    } else {
      phoneNumberError('Số điện thoại không hợp lệ');
    }
  }
}
