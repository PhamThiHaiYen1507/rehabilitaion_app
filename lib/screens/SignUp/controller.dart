import 'package:commons/commons.dart';
import 'package:finplus/routes/routes.dart';
import 'package:finplus/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../providers/login_provider.dart';

class SignUpController extends GetxController {
  late final LoginProvider loginProvider;
  late final TextEditingController phoneNumber;
  late final FocusNode phoneNumberFocus;
  late final RxString phoneNumberError;
  late final RxBool enabled;
  @override
  void onInit() {
    loginProvider = LoginProvider();
    phoneNumber = TextEditingController();
    phoneNumberFocus = FocusNode();
    phoneNumberError = RxString('');
    enabled = RxBool(false);
    super.onInit();
  }

  @override
  void onReady() {
    phoneNumber.addListener(() {
      enabled(phoneNumber.text.trim().isNotEmpty);
    });
    super.onReady();
  }

  Future<void> onConfirm() async {
    phoneNumberFocus.unfocus();
    if (Utils.validatePhoneNumber(phoneNumber.text.trim())) {
      final bool result = await loginProvider.checkPhoneNumber(
          phoneNumber: phoneNumber.text.trim());
      if (result) {
        Get.toNamed(Routes.smart_otp);
      }
    } else {
      phoneNumberError('Số điện thoại không hợp lệ');
    }
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    super.onClose();
  }
}
