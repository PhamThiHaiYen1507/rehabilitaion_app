import 'package:commons/commons.dart';
import 'package:finplus/layers/domain/repository/authentication_repository.dart';
import 'package:finplus/models/login_data.dart';
import 'package:finplus/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class LoginController extends GetxController {
  final AuthenticationRepository _authentication;
  late final Rxn<LoginData> loginData;
  late final TextEditingController phoneNumber, password;
  late final FocusNode phoneNumberFocus, passwordFocus;
  late final Rx<String> phoneNumberError, passwordError;
  late final RxBool showPassword, enabled;

  LoginController(this._authentication);

  @override
  void onInit() {
    loginData = Rxn<LoginData>();
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
      final res = await _authentication.login(
          phoneNumber.text.trim(), password.text.trim());
      if (res.isRight) {
        Get.offAllNamed(Routes.home);
      }
    } else {
      phoneNumberError('Số điện thoại không hợp lệ');
    }
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    password.dispose();
    phoneNumberFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
