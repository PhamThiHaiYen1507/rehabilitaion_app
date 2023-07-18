import 'dart:async';

import 'package:commons/commons.dart';
import 'package:finplus/screens/SmartOTP/index.dart';
import 'package:finplus/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../providers/login_provider.dart';

class SignUpController extends GetxController {
  late final LoginProvider loginProvider;
  late final TextEditingController phoneNumber;
  late final FocusNode phoneNumberFocus;
  late final RxString phoneNumberError;
  late final RxBool enabled;
  final CHANGE_PASSWORD_TYPE type;

  SignUpController(this.type);

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
      final bool? result = await loginProvider.checkPhoneNumber(
          phoneNumber: phoneNumber.text.trim());

      switch (type) {
        case CHANGE_PASSWORD_TYPE.SIGNUP:
          if (result == false) {
            Get.to(() => SmartOTP(phoneNumber: phoneNumber.text, type: type));
          } else if (result == true) {
            Utils.showNotification(NOTIFICATION_TYPE.ERROR, 'Đăng ký',
                'Số điện thoại đã được đăng ký');
          }
          break;
        case CHANGE_PASSWORD_TYPE.FORGOT_PASSWORD:
          if (result == true) {
            Get.to(() => SmartOTP(phoneNumber: phoneNumber.text, type: type));
          } else if (result == false) {
            Utils.showNotification(NOTIFICATION_TYPE.ERROR, 'Quên mật khẩu',
                'Số điện thoại chưa được đăng ký');
          }
          break;
        default:
      }
    } else {
      phoneNumberError('Số điện thoại không hợp lệ');
    }
  }

  @override
  void onClose() {
    phoneNumber.dispose();
    phoneNumberFocus.dispose();
    super.onClose();
  }
}
