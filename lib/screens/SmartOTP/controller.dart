import 'dart:async';

import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class SmartOTPController extends GetxController {
  late final TextEditingController otp;
  late final FocusNode otpFocus;
  late final RxBool enabled;
  late Timer timeout;
  late final RxInt timeRefest;
  @override
  void onInit() {
    otp = TextEditingController();
    otpFocus = FocusNode();
    enabled = RxBool(false);
    timeRefest = RxInt(30);
    onRefest();
    super.onInit();
  }

  @override
  void onReady() {
    otp.addListener(() {
      enabled(otp.text.length == 4);
    });
    otpFocus.addListener(() {
      if (otpFocus.hasFocus) {
        Timer(const Duration(seconds: 3), () {
          otp.value = const TextEditingValue(text: '1507');
        });
      }
    });
    super.onReady();
  }

  void onRefest() {
    timeRefest(30);
    timeout = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeRefest.value--;
      if (timeRefest.value < 0) {
        timeout.cancel();
      }
    });
  }

  @override
  void onClose() {
    otp.dispose();
    otpFocus.dispose();
    timeout.cancel();
    super.onClose();
  }
}
