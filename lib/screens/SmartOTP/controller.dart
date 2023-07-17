import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class SmartOTPController extends GetxController {
  late final TextEditingController otp;
  late final RxBool enabled;
  @override
  void onInit() {
    otp = TextEditingController();
    enabled = RxBool(false);
    super.onInit();
  }

  @override
  void onReady() {
    otp.addListener(() {
      enabled(otp.text.length == 4);
    });
    super.onReady();
  }
}
